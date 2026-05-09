# Security Policy

If you find a security vulnerability in this repository, report it privately. Do not open a public issue.

## Reporting a Vulnerability

Use **GitHub Security Advisories**: Security tab → Advisories → "Report a vulnerability".

Include:

- Description of the vulnerability
- Steps to reproduce
- Affected versions or components
- Suggested remediation if available

Reports are acknowledged within 72 hours.

## Supported Versions

| Version | Security support |
|---------|-----------------|
| `main` (latest stable) | Active |
| Previous minor versions | Maintainer discretion |

## Response Timeline

| Severity | Target resolution |
|----------|------------------|
| Critical | 24–48 hours |
| High | 7 days |
| Medium / Low | Next planned release |

## Repository Security Posture (May 2026)

Controls active on this repository:

- Secret scanning with push protection (GitHub GHAS)
- Dependabot security alerts and automated updates
- Branch protection on `main` (1 required review, status checks required)
- Pre-commit hooks: secret detection, syntax validation, LF enforcement
- CI scanning: Trivy filesystem scan on every push

Recommended practices for users of these dotfiles:

- Rotate any credential exposed via shell history or config files immediately
- Use SSH keys for GitHub authentication (`~/.ssh/config`)
- Pin tool versions with `mise` to avoid unexpected supply-chain updates
- Run `pre-commit install` after cloning to activate local commit hooks

## Acknowledgments

Responsible disclosure is appreciated. Researchers who report valid vulnerabilities will be credited in the relevant release notes.
