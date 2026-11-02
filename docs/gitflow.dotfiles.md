# Gitflow and DevSecOps

> Reference for the branching model, CI gates, auto-merge, and release process used in this repository.

## Branching Model

| Branch | Purpose | Merges from |
|--------|---------|-------------|
| `main` | Production. Release-only; every commit is a tagged release. | `develop` (via auto-PR) |
| `develop` | Integration. Always green; accumulates features and fixes. | Feature/fix branches |
| `feature/*`, `fix/*`, `docs/*`, `chore/*`, `perf/*` | Short-lived work branches | `develop` |
| `hotfix/*` | Urgent fixes branched from `main` | `main` (then backmerged to `develop`) |

- Feature branches are short-lived (days, not weeks).
- Merged branches are deleted automatically (`delete_branch_on_merge`).
- Invariant: `develop` always contains everything in `main` (`develop ⊇ main`).

## Branch Protection

Both `main` and `develop` are protected by a ruleset plus the classic branch protection (defense in depth).

- No deletion, no force-push (non-fast-forward).
- Pull request required before merging.
- Required status checks must pass (see [CI Gates](#ci-gates)).
- `enforce_admins` is disabled (maintainer can bypass in emergencies).

Rulesets: `main-protection`, `develop-protection`. Classic protection is the fallback guarantee for deletion prevention.

## CI Gates

| Gate | Trigger | Job | Purpose |
|------|---------|-----|---------|
| `pre-commit checks` | All PRs | `pre-commit` | Hooks: syntax, secrets, whitespace, LF |
| `Shell syntax validation` | All PRs | `shell-syntax` | `zsh -n` on `zshrc` and `zsh.d/*.zsh` |
| `ZSH startup performance` | All PRs | `startup-time` | Startup under 110 ms |
| `Security scanning` | All PRs | `security-scan` | Trivy filesystem scan |
| `Dependency vulnerability check` | All PRs | `dependency-check` | Hardcoded secrets scan |
| `Alignment check (main in develop)` | PRs to `develop` | `alignment-check` | Ensures `main` is an ancestor of the PR head |
| `PR source check (only develop -> main)` | PRs to `main` | `pr-source-check` | Only `develop` may merge into `main` |

Full definitions: [`.github/workflows/ci.yml`](../.github/workflows/ci.yml).

## Auto-merge

Semi-automatic. Workflows create the PR and enable auto-merge; merges happen only after all required checks pass.

- `auto-pr.yml` — on push to `develop`, opens (or reuses) a PR `develop → main` and enables auto-merge with a merge commit (`--merge`).
- `backmerge.yml` — on push to `main`, opens (or reuses) a PR `main → develop` and enables auto-merge, keeping `develop ⊇ main`.
- Auto-merge is enabled at repository level (`allow_auto_merge`).

## Dependabot

Configuration: [`.github/dependabot.yml`](../.github/dependabot.yml).

- Ecosystem: `github-actions`, weekly, target branch `develop`.
- Minor and patch updates are grouped into a single PR.
- Auto-merge policy (`.github/workflows/dependabot-auto-merge.yml`): only `version-update:semver-minor` and `version-update:semver-patch` are auto-merged; major updates require manual review.

## Releases and Tagging

- Releases are created by merging `develop → main`.
- Tags use Semantic Versioning: `vMAJOR.MINOR.PATCH` (annotated tags on `main`).
- Tag naming examples: `v2.1.0`, `v2.1.1`.
- The maintainer creates tags after a release merge: `git tag -a vX.Y.Z -m "Release vX.Y.Z" && git push origin vX.Y.Z`.

## Branch Cleanup

- Merged branches are deleted automatically (`delete_branch_on_merge`).
- Stale remote branches are pruned with `git fetch --prune`.

## Workflow Files

| File | Purpose |
|------|---------|
| [`.github/workflows/ci.yml`](../.github/workflows/ci.yml) | CI gates |
| [`.github/workflows/auto-pr.yml`](../.github/workflows/auto-pr.yml) | Auto-PR develop → main |
| [`.github/workflows/backmerge.yml`](../.github/workflows/backmerge.yml) | Backmerge main → develop |
| [`.github/workflows/dependabot-auto-merge.yml`](../.github/workflows/dependabot-auto-merge.yml) | Dependabot auto-merge |

## Related

- [`CONTRIBUTING.md`](../CONTRIBUTING.md) — contributor procedures
- [`.github/SECURITY.md`](../.github/SECURITY.md) — vulnerability disclosure
