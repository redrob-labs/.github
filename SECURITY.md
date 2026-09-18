# Security policy

## Reporting a vulnerability

Email <security@redrob.ai>. Do not open a public issue.

Include the repository, the version or commit, what you found, and the steps to reproduce it.
We reply about repositories in this organization, and we will tell you if the issue belongs to a
different repository than the one you reported it against, including when it belongs upstream.

Please give us a reasonable window to ship a fix before publishing details. Most of these
products are installed desktop applications, so a fix reaches users only as fast as they update.

This is the organization's default policy. A repository with its own `SECURITY.md` describes its
own scope, and that one is authoritative for it.

## In scope

- Remote code execution, sandbox escape, or privilege escalation in a shipped application.
- A path that exfiltrates a user's files, credentials, or conversation content off their machine.
- Prompt injection that reaches a real action: writing outside the workspace, running a command,
  or sending data to a third party. A model saying something odd is not a vulnerability; a model
  being steered into an action the user did not authorize is.
- Credential handling: a token written to a log, a world-readable config, or a secret that
  survives a sign-out.
- Update-channel weaknesses: an unsigned or unverified artifact, a downgrade that is accepted, or
  a feed an attacker can influence.
- Anything that lets an attacker inject content or script into a rendered page or a webview.
- Dependency vulnerabilities reachable from a shipped artifact.
- A credential or secret exposed in a repository, a build log, or a release asset.

## Out of scope

- A finding that only reproduces with a debug build, a disabled sandbox, or a flag no shipped
  configuration sets.
- Model output quality, hallucination, jailbreaks that produce text only, and prompt extraction.
- A vulnerability in a third-party model or service we call rather than operate. Report it to
  them; tell us so we can gate around it.
- Findings that require an attacker who already has local code execution as the same user.
- Scanner output with no demonstrated impact, and missing hardening headers on a preview
  deployment.

## Forks

Most of these repositories are forks. If the vulnerability is in upstream code we did not
change, say so and report it upstream as well; we will still gate or patch on our side. If our
fork **introduced** it, that is ours, and telling us which side it came from is the fastest way
to get it fixed rather than argued about.

## If you find a credential in a repository

Report it privately and immediately. Do not open a pull request that removes it: the pull
request is public and points at the commit.

Assume any credential that reached a commit is compromised and rotate it. Removing it from the
current tree does not remove it from the history, and in a fork network a commit stays reachable
from upstream even after the branch is deleted.
