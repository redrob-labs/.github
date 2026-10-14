<#
.SYNOPSIS
  Authenticode-sign files with signtool through Azure Artifact Signing, then verify them.

.DESCRIPTION
  Driven by the sign-windows composite action. Reads SIGN_FILES (paths or globs, newline- or
  space-separated), SIGN_DESCRIPTION, SIGN_URL, ARTIFACT_SIGNING_ENDPOINT, ARTIFACT_SIGNING_ACCOUNT,
  ARTIFACT_SIGNING_CERT_PROFILE, EXPECTED_CN and WINDOWS_TIMESTAMP_URL. The Azure credential is
  whatever DefaultAzureCredential finds: in CI the `az login` done by azure/login with the job's
  OpenID Connect token; on a developer machine, `az login`. No certificate file, no client secret.

  With the three ARTIFACT_SIGNING_* variables unset it warns and leaves the files unsigned (exit 0),
  so a dry run on a fork still produces installers. Half-configured, it fails.

  Also usable directly as a bundler's sign command, so tauri (`bundle.windows.signCommand`) and
  electron-builder (`win.sign` hook) call this same copy instead of carrying their own:

    pwsh -NoProfile -File <checkout>/actions/sign-windows/sign.ps1 <file> [<file>...]

  Files given as arguments win over SIGN_FILES. SIGN_DESCRIPTION defaults to the repository name
  and SIGN_URL to the repository's GitHub URL when GITHUB_REPOSITORY is set.
#>
param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]] $FileArgs = @()
)
$ErrorActionPreference = 'Stop'

if (-not $env:SIGN_DESCRIPTION -and $env:GITHUB_REPOSITORY) { $env:SIGN_DESCRIPTION = ($env:GITHUB_REPOSITORY -split '/')[-1] }
if (-not $env:SIGN_URL -and $env:GITHUB_REPOSITORY) { $env:SIGN_URL = "https://github.com/$env:GITHUB_REPOSITORY" }
if (-not $env:SIGN_DESCRIPTION) { throw 'SIGN_DESCRIPTION is not set' }
if (-not $env:SIGN_URL) { throw 'SIGN_URL is not set' }

function Write-Warn([string] $Message) {
  if ($env:GITHUB_ACTIONS) { Write-Output "::warning::$Message" } else { Write-Warning $Message }
}

function Find-SignTool {
  if ($env:SIGNTOOL) { return $env:SIGNTOOL }
  $onPath = Get-Command signtool.exe -ErrorAction SilentlyContinue
  if ($onPath) { return $onPath.Source }
  $kits = Join-Path ${env:ProgramFiles(x86)} 'Windows Kits\10\bin'
  $found = Get-ChildItem -Path $kits -Recurse -Filter signtool.exe -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -match '\\x64\\signtool\.exe$' } |
    Sort-Object FullName -Descending | Select-Object -First 1
  if (-not $found) { throw 'signtool.exe not found (install the Windows SDK)' }
  return $found.FullName
}

function Invoke-SignTool([string[]] $Arguments) {
  & $script:SignTool @Arguments
  if ($LASTEXITCODE -ne 0) { throw "signtool $($Arguments[0]) failed with exit code $LASTEXITCODE" }
}

# Expand the file list: one entry per line or per whitespace run, globs resolved, duplicates dropped.
$patterns = if ($FileArgs.Count -gt 0) { @($FileArgs) } else { @(($env:SIGN_FILES -split '[\r\n\s]+') | Where-Object { $_ }) }
if ($patterns.Count -eq 0) { throw 'no files: pass them as arguments or in SIGN_FILES' }
$Files = @()
foreach ($pattern in $patterns) {
  $matched = @(Get-Item -Path $pattern -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
  if ($matched.Count -eq 0) { throw "nothing matches '$pattern'" }
  $Files += $matched
}
$Files = @($Files | Select-Object -Unique)

$required = 'ARTIFACT_SIGNING_ENDPOINT', 'ARTIFACT_SIGNING_ACCOUNT', 'ARTIFACT_SIGNING_CERT_PROFILE'
$missing = @($required | Where-Object { -not [Environment]::GetEnvironmentVariable($_) })
if ($missing.Count -eq $required.Count) {
  Write-Warn "Artifact Signing not configured ($($required -join ', ') unset): leaving unsigned: $($Files -join ', ')"
  exit 0
}
if ($missing.Count -gt 0) { throw "Artifact Signing half-configured; missing: $($missing -join ', ')" }

$script:SignTool = Find-SignTool
$tmp = Join-Path ([IO.Path]::GetTempPath()) "redrob-sign-$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

try {
  Write-Output "Signing with Azure Artifact Signing ($env:ARTIFACT_SIGNING_ACCOUNT / $env:ARTIFACT_SIGNING_CERT_PROFILE): $($Files -join ', ')"
  # The signtool dlib from the Microsoft.ArtifactSigning.Client NuGet package. It authenticates with
  # DefaultAzureCredential, so the `az login` performed before this script is what it uses.
  $pkg = Join-Path $tmp 'artifact-signing-client.zip'
  Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/Microsoft.ArtifactSigning.Client' -OutFile $pkg
  Expand-Archive -Path $pkg -DestinationPath (Join-Path $tmp 'client') -Force
  $dlib = Get-ChildItem -Path (Join-Path $tmp 'client') -Recurse -Filter Azure.CodeSigning.Dlib.dll |
    Where-Object { $_.FullName -match '\\x64\\' } | Select-Object -First 1
  if (-not $dlib) { throw 'Azure.CodeSigning.Dlib.dll not found in Microsoft.ArtifactSigning.Client' }
  $metadata = Join-Path $tmp 'metadata.json'
  @{
    Endpoint               = $env:ARTIFACT_SIGNING_ENDPOINT.TrimEnd('/')
    CodeSigningAccountName = $env:ARTIFACT_SIGNING_ACCOUNT
    CertificateProfileName = $env:ARTIFACT_SIGNING_CERT_PROFILE
    # Only the credentials a CI runner or a developer shell can satisfy. Without this list a missing
    # login falls through to InteractiveBrowserCredential, which opens a browser nobody sees and
    # waits forever (one release hung 30 minutes on it). With it, it fails in seconds.
    ExcludeCredentials     = @(
      'InteractiveBrowserCredential', 'ManagedIdentityCredential', 'SharedTokenCacheCredential',
      'VisualStudioCredential', 'VisualStudioCodeCredential', 'AzurePowerShellCredential',
      'AzureDeveloperCliCredential', 'WorkloadIdentityCredential'
    )
  } | ConvertTo-Json | Set-Content -Path $metadata -Encoding utf8
  $ts = if ($env:WINDOWS_TIMESTAMP_URL) { $env:WINDOWS_TIMESTAMP_URL } else { 'http://timestamp.acs.microsoft.com' }
  $common = @('sign', '/v', '/fd', 'SHA256', '/td', 'SHA256', '/d', $env:SIGN_DESCRIPTION, '/du', $env:SIGN_URL)
  Invoke-SignTool ($common + @('/tr', $ts, '/dlib', $dlib.FullName, '/dmdf', $metadata) + $Files)

  # A Public Trust certificate chains to a Microsoft root every Windows trusts, so the full
  # Authenticode check must pass. Anything less (unsigned, broken chain, bad hash) fails. The signer
  # is compared on the CN attribute: the rendered subject quotes a CN containing a comma.
  foreach ($file in $Files) {
    Invoke-SignTool @('verify', '/pa', '/v', $file)
    $signature = Get-AuthenticodeSignature -FilePath $file
    if ($signature.Status -ne 'Valid') { throw "$file signature status $($signature.Status): $($signature.StatusMessage)" }
    $cn = $signature.SignerCertificate.GetNameInfo([System.Security.Cryptography.X509Certificates.X509NameType]::SimpleName, $false)
    if ($env:EXPECTED_CN -and $cn -ne $env:EXPECTED_CN) {
      throw "$file signed by CN=$cn, expected CN=$($env:EXPECTED_CN) (subject: $($signature.SignerCertificate.Subject))"
    }
    Write-Output "$file signed by CN=$cn"
  }
}
finally {
  Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
