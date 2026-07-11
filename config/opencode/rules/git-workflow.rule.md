# Git Workflow Rule

## Branch Strategy
- `main` — stable, protected
- `develop` — active development, protected (1 review, no delete, no force push)
- `feature/*` — short-lived feature branches from `develop`
- `fix/*` — bug fix branches
- `docs/*` — documentation-only changes
- `chore/*` — maintenance, refactoring, infrastructure

## Commits
- Conventional Commits: `type(scope): description`
  - Types: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `perf`
- Every commit must include: `Co-Authored-By: Roy Batty <roy.batty@cosckoya.bot>`
- Committer: `cosckoya`
- No force-push without permission
- Push directly (never force-push) to `main` or `develop`

## PR Workflow
1. Branch from `develop`
2. Open PR to `develop`
3. Squash-merge to `develop`
4. When `develop` is stable, PR to `main`
5. `develop` is never deleted after merge
