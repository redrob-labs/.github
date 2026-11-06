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
| [FORKS.md](./FORKS.md) | The rules that apply because many of these repositories are forks. |

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
`develop` the default branch. Four repositories here are still on `main`: `redrob-image`,
`redrob-labs`, and the archived `redrob-studio` and `redrob-verify`. Twelve are on `develop`.
Changing a default branch is a breaking change to CI, because a workflow filtered on
`branches: [main]` stops running silently, so each of those four needs its workflow branch
filters audited in the same change.

## This repository's own branches

| | |
|---|---|
| `main` | **Default and only branch.** GitHub serves the inherited health files from here. |
| Branch names | `<type>/<slug>`, types `feat fix chore docs test refactor perf`. |

A change lands through a pull request straight into `main`. There is no `develop`: the default
branch of a `.github` repository is the surface served to every other repository, and this one
holds documents and shared workflows with nothing of its own to build. `main` is protected, and
admin enforcement is on.
