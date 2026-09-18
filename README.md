# Redrob Labs

Community health defaults for every repository in this organization.

한국어: [README.ko.md](./README.ko.md)

## What is here

| File | What it settles |
|---|---|
| [CONTRIBUTING.md](./CONTRIBUTING.md) | How an outside contributor gets a change merged. |
| [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md) | How we behave with each other. |
| [SECURITY.md](./SECURITY.md) | Where a vulnerability report goes. Never a public issue. |
| [SUPPORT.md](./SUPPORT.md) | Where a question goes. |
| [FORKS.md](./FORKS.md) | The rules that apply because most of these repositories are forks. |

Files at these paths are used by **every repository in this organization that does not have its
own copy**, so a repository's own file always wins and this is a floor rather than an override.
`profile/README.md` renders on the organization's public profile page.

## The engineering standards live in the other organization

Branching, repository naming, design tokens and the rules an AI agent works under are shared
with our other organization and are published there, not duplicated here:

| | |
|---|---|
| [GITFLOW.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/GITFLOW.md) | Branches, merges, releases, hotfixes, upstream syncs, and what CI enforces. |
| [REPO-NAMING.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/REPO-NAMING.md) | Repository names, descriptions and topics. |
| [DESIGN.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/DESIGN.md) | Tokens, type, motion, and how to verify a visual change. |
| [AGENTS.md](https://github.com/mckinley-and-rice/.github/blob/main/AGENTS.md) | What an AI agent must verify before claiming it. |

They are linked rather than copied on purpose: a copy drifts and nothing reports it. Both
organizations are ours, and those documents are written to apply to both.

**GitHub's health-file inheritance stops at the organization boundary**, which is why this
repository exists at all even though the other one already has the same four files. Inheritance
is per organization; the standards are not.

## The gap between the standard and this organization

Recorded because an unrecorded gap reads as the standard being wrong.

[GITFLOW.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/GITFLOW.md) makes
`develop` the default branch. Five repositories here are still on `main`: `redrob-studio`,
`redrob-verify`, `redrob-image`, `redrob-ide` and `redrob-labs`. Twelve are on `develop`.
Changing a default branch is a breaking change to CI, because a workflow filtered on
`branches: [main]` stops running silently, so each of those five needs its workflow branch
filters audited in the same change.

Three public repositories ship a license GitHub cannot classify, so their sidebar shows no
license at all: `redrob-cowork`, `redrob-design` and `redrob-ide` report `NOASSERTION`. In the
first two this is because the `LICENSE` file opens with stacked fork copyright lines before the
license body. The license is real and the notices are correct; what is broken is only GitHub's
detection of it, and for an open source repository that detection is how most people check.

## This repository's own branches

| | |
|---|---|
| `main` | **Default.** The published state. GitHub serves the inherited health files from here. |
| `develop` | Integration. Changes land here first, then are promoted by a merge commit. |
| Branch names | `<type>/<slug>`, types `feat fix chore docs test refactor perf`. |

`main` being the default is a deliberate deviation from the shared standard, for the reason the
standard itself gives: the default branch of a `.github` repository is the surface served to
every other repository, not the contributors' view. Both branches are protected, and admin
enforcement is on.
