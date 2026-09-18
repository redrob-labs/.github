# Working in a fork

Most repositories here are forks. That single fact changes more about how you contribute than
anything else in [CONTRIBUTING.md](./CONTRIBUTING.md), because a fork's most consequential
operation is not a feature: it is absorbing upstream, which arrives as a large, conflict-prone
merge.

한국어: [FORKS.ko.md](./FORKS.ko.md)

| Repository | Upstream |
|---|---|
| `redrob-code` | opencode |
| `redrob-cowork` | OpenWork |
| `redrob-design` | OpenPencil |
| `redrob-office` | GenOffice |
| `redrob-browser` | Chromium |
| `redrob-ide` | Visual Studio Code |
| `redrob-cad` | FreeCAD |
| `redrob-reblend` | Blender |

Each repository records its own upstream and the exact point it sits on, in `UPSTREAM.md` or
`docs/UPSTREAM.md`, with the pin in `upstream-base.json`, `UPSTREAM_VERSION` or
`docs/upstream-sources.toml`. Read that file, not this table, before you touch anything: this
table tells you a fork exists, and that file tells you where it is.

## The two rules that are enforced

**Never replace an upstream copyright notice.** Add ours below theirs. MIT requires the notice
to be retained in every copy, so replacing it is a licence violation and not a tidy-up. The
holder is a person with the brand in parentheses and contributors named collectively, which is
why the notices look the way they do.

A copyright notice is never translated, either. Korean documents keep their prose in Korean and
quote the notice verbatim, because a translated notice reads as a second, different holder.

**Never add anything under a subtree upstream licenses separately.** In `redrob-cowork` that is
`ee/`, which upstream licenses under the OpenWork Enterprise Edition License and which requires
an upstream subscription for production use. That fork ships the MIT-licensed portion only.

Both are checked: `pnpm check:upstream-boundary` in `redrob-cowork`, `redrob-office` and
`redrob-design`. It also verifies the pin and the attribution lines, so it fails on a stale
`upstream-base.json` as well.

## Some upstream identifiers are load-bearing

Do not finish a rebrand while resolving a conflict. These have all bitten us:

- **A legacy config directory is read on purpose.** `redrob-code` still reads `.opencode`
  alongside `.redrob` so existing checkouts keep working.
- **An error code is a contract.** A single snake_case token like `opencode_unconfigured` is
  what a client branches on with a string compare. Renaming it looks like the same cleanup as
  renaming the message beside it, and it silently breaks the recovery path forever. Rebrand the
  prose in the message body; leave the code.
- **Some package names are not ours to rename.** `@gitlab/opencode-gitlab-auth`,
  `opencode-gitlab-auth` and `opencode-poe-auth` are real published packages.
- **Some strings belong to upstream's own resources.** In `redrob-cad`, six of eight
  `QT_TR_NOOP` strings are upstream FreeCAD resources and stay; only the two that are ours
  change.
- **Sign-in prompts naming a third party usually mean it.** In `redrob-browser`, "Sign in to
  Google?" is correct: that button signs into a Google account, not a Redrob one. Rewriting it
  to our name is a false statement about a product that does not exist.

The shape of the mistake is always the same: a rename that reads as consistency, applied to a
string that was an interface.

## Absorbing upstream

Follow upstream **tags**, not its development branch. A tag is a point upstream themselves
decided was coherent; the development branch is whatever was pushed an hour ago.

Sync branches are `sync/upstream-<tag>` and open a pull request into the default branch, never
into `main` directly. **Merge them as a merge commit, never a squash**: a squash destroys the
merge base, and the next sync replays work already taken.

Three things hold on every sync we have run:

- **The merge base is real, so most of upstream arrives for free.** A three-way merge takes
  upstream's version of every file we never touched, and every region our changes do not
  overlap. On the first sync of one repository, 40 files needed a human out of 229 conflicts;
  the rest were "upstream changed something we deliberately deleted".
- **Conflicts cluster on rebranding.** Where upstream edits a line we renamed, the merge cannot
  know which side wins. Keep ours, take their surrounding change.
- **Resolving is a judgement call, so no tool should guess.** Our sync workflow stops on
  conflict and reports which paths conflicted rather than resolving them.

## Patch-based forks

`redrob-browser` and `redrob-ide` do not carry a merged tree; they carry patches applied to a
pristine upstream checkout. Two rules there:

**Pin `.patch` files to LF.** Add `*.patch -text` to `.gitattributes`. On Windows, `core.autocrlf`
or the checkout action will rewrite a patch to CRLF, the `index` line's trailing CR makes the
blob lookup fail, and context lines stop matching, so a patch that applies on Linux breaks only
on Windows. You can reproduce it on Linux by converting a patch to CRLF.

**A reproduction gate proves you can rebuild the tree, not that you are current.** A
byte-identical replay of the patch set says nothing about whether upstream has moved. Currency
is the pin file's job.

## Before you propose a change to a fork's boundary

A public fork's visibility cannot be changed, and a commit that entered a fork network stays
reachable from upstream even after you delete the branch. So a change that moves code across
the upstream boundary is effectively permanent from the moment it is pushed. Open an issue
first.
