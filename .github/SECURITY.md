name: Security Policy

If you believe you have found a security vulnerability in this repository, please report it privately.

## Reporting Security Issues

**Do not** open a public issue for security vulnerabilities. Instead:

1. **Use GitHub Security Advisory**: Go to the "Security" tab → "Advisories" → "Report a vulnerability" to submit a private security report
2. **Contact maintainers privately**: If you prefer, email the repository maintainers directly

Provide:
- Description of the vulnerability
- Steps to reproduce
- Affected versions/components
- Suggested remediation (if available)

## Supported Versions

Security updates are provided for:
- Latest stable version (main branch)
- Previous minor versions (at maintainer discretion)

## Security Update Timeline

- **Critical**: Fixed and released within 24-48 hours
- **High**: Fixed and released within 1 week
- **Medium/Low**: Included in next planned release

## Security Best Practices for Users

This project follows security best practices (2026):

✅ **Enabled**:
- Secret scanning with push protection
- Dependabot security alerts & updates
- Branch protection on main (1 required review)
- Pre-commit hooks for code quality
- Signed commits recommended

⚠️ **Recommendations for users**:
- Keep dependencies updated (run `make all` periodically)
- Use SSH keys for authentication (configure in `~/.ssh/config`)
- Rotate any exposed secrets immediately
- Review `.pre-commit-config.yaml` for installed hooks

## Acknowledgments

We appreciate security researchers who report vulnerabilities responsibly.
