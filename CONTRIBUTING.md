# Contributing

These are open source products, and outside contributions are genuinely welcome. This is the
default agreement for every repository in this organization; a repository with its own
`CONTRIBUTING.md` uses that one instead, and where the two disagree the repository wins because
it knows its own build.

한국어: [CONTRIBUTING.ko.md](./CONTRIBUTING.ko.md)

## What gets merged quickly

- A bug fix with a reproduction, or a test that fails before it and passes after.
- Accessibility fixes: focus order, contrast, labels, reduced-motion paths.
- A crash, a data-loss path, or anything that breaks on one platform only.
- Korean or English copy that reads wrong, including awkward Korean.
- Dead code, unused assets, and a dependency you can show is unreachable.

## What needs a discussion first

Open an issue before writing the code.

- A new dependency, especially one that pulls a toolchain with it.
- A change to a file format, a config schema, or anything a user's existing files rely on.
- A new provider, model, or integration. Several of these products deliberately expose one
  engine or one provider, and that is a product decision rather than a missing feature.
- Anything that touches how upstream is absorbed. See [FORKS.md](./FORKS.md).
- A rewrite. A pull request that rewrites a subsystem is very hard to review and usually
  arrives after the reviewer would have said no to the plan.

## Most of these repositories are forks

Read [FORKS.md](./FORKS.md) before your first change. Two of its rules are enforced by CI, and
one of them will make you delete work if you learn it late: never replace an upstream copyright
notice, and never add anything under a directory that upstream licenses separately.

## Branches

Base your work on the repository's **default branch**, which is `develop` in most of these
repositories and `main` in a few. Cutting from the wrong one is the most common first mistake.

Working branches are `<type>/<short-slug>`:

```
fix/composer-drop-zone
feat/reasoning-effort
chore/bump-electron
docs/upstream-sync
```

The allowed type list is **per repository**, held in that repository's
`.github/workflows/gitflow.yml` as `ALLOWED_TYPES`. Read it before you name a branch: some use
`feat`, others use `feature`, and the check fails a branch that guessed. A branch name says
what the change is, never who or what produced it, so an agent or tool name is not a type.

The full model, including how upstream syncs and releases work, is in
[GITFLOW.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/GITFLOW.md).

## Commits

Conventional prefixes, imperative mood, lower case subject:

```
fix(composer): show the drop zone during dragover, not only on drop
```

The body is where the value is. Say what was wrong and why the fix is the right shape, not what
the diff already shows. If the cause was somewhere other than where the symptom appeared, say
so; that is the sentence the next person needs.

Commit and pull request bodies are in English so the history reads in one language. Issues and
discussion may be in Korean or English, and nobody will ask you to switch.

No em dashes, anywhere: commits, pull requests, code comments, documentation.

Commits can be as small as you like. A fine-grained history is good: one logical step per commit
makes a change easy to read and easy to revert. Split freely.

A pull request is the opposite unit. Keep it to one thing, deduplicated and no larger than it
needs to be. Before you open one, fold away the noise: squash the "fix typo", "oops" and
revert-of-a-revert churn, drop a change that is already on the base branch, and leave out
anything a reviewer would have to mentally set aside to judge the real change. A reviewer should
be able to say in one sentence what the PR does (that sentence is the template's first line); if
it takes more, the branch is doing more than one thing and should be two PRs. Small commits
inside a tight, single-purpose PR is exactly the shape we want.

## Before you open a pull request

Run the repository's own gates, listed in its `README.md`. They differ per repository, so read
rather than guess. Then rebase on the base branch and keep the branch focused: a reviewer should
be able to state what it does in one sentence.

Two things that waste a review round:

**A fresh clone has no dependencies, so a test run before installing them fails in bulk** with
module resolution errors and a lower total test count. That is not a regression in your change.
Install first, then run.

**Re-measure any number you publish.** A count, size, version or timing in a commit message,
pull request body or changelog is measured from the built artifact in the same sitting. A number
carried forward from an earlier run usually counts a different set.

## User-facing strings

Every user-visible string goes through the repository's translation layer and lands in both the
English and Korean tables. English is the source of truth, and a missing Korean key falls back
to English rather than breaking.

Do not machine-translate to satisfy a completeness check. Where a repository has a translation
baseline file, an untranslated English value recorded there is the honest state; an invented
Korean string looks like something a person reviewed.

## Design changes

Anything a user looks at follows
[DESIGN.md](https://github.com/mckinley-and-rice/.github/blob/main/docs/DESIGN.md). The two
rules that matter most: take token values from the canonical stylesheet rather than retyping
them from memory, and verify by looking at the built screen rather than the diff. A green build
has shipped an invisible label and a control that did nothing.

## Reviews and merging

A pull request needs its checks green and a maintainer merge. Merge style is not a preference,
because it changes what the next merge can do:

| Situation | Style |
|---|---|
| Working branch | **squash** |
| Upstream sync | **merge commit** |
| Promotion to `main` | **merge commit** |

Squashing an upstream sync destroys the merge base, and the next sync then replays work already
taken.

If a maintainer declines your change on scope or direction grounds, that is not a judgement of
you or of the code. Ask what would make it mergeable, or leave it as an issue for someone else.

## Reporting a bug

Use the issue templates. A useful report names the platform, the version, and what you saw on
screen. A screenshot of the actual window beats a description of it, and pasted log text beats a
screenshot of log text because text is searchable. Remove any token before you paste.

## Security

Do not open a public issue for a vulnerability. See [SECURITY.md](./SECURITY.md).

## License of your contribution

By contributing you agree your work is released under the license in that repository's
`LICENSE`, which is not the same file in every repository here: most are Apache-2.0, one is
MIT, one is GPL-3.0, and the forks stack our notice under the upstream one. Check the repository
you are contributing to.

**There is no CLA and no sign-off requirement.** You keep the copyright in your own
contribution; the notice names contributors collectively rather than assigning anything. If we
ever need something more than this, it will be asked for in advance and not applied
retroactively.
