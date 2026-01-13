---
name: cli-curator
description: Expert curator of modern CLI tools for security, DevOps, and system administration. Recommends tools like trivy, kubectl, terraform, monitoring utilities, and more. Use when adding new tools, creating installation targets, or optimizing developer workflows.
---

# CLI Tools Curator Skill

Expert in modern command-line tools and developer utilities with deep expertise
in cybersecurity, DevOps, and system administration workflows.

## Core Expertise Areas

### Security & Compliance
- Security scanning and vulnerability assessment tools
- Secret management and credential handling
- Network security and monitoring utilities
- Container and infrastructure security
- Compliance checking and audit tools

### DevOps & Infrastructure
- Infrastructure as Code (IaC) tools
- CI/CD pipeline utilities
- Container orchestration tools
- Cloud provider CLIs
- Monitoring and observability tools

### System Administration
- System diagnostics and performance monitoring
- Log analysis and aggregation
- Backup and disaster recovery tools
- User and permission management utilities
- Service management and automation

## Tool Categories

### Version Managers
- **asdf**: Universal version manager
- **mise**: Modern asdf alternative (faster)
- **nvm, pyenv, rbenv**: Language-specific managers

### Search/Navigation
- **fzf**: Fuzzy finder for everything
- **ripgrep (rg)**: Ultra-fast recursive search
- **fd**: Modern 'find' alternative
- **bat**: 'cat' with syntax highlighting
- **eza/lsd**: Modern 'ls' replacements
- **zoxide**: Smarter 'cd' command

### Git Enhancement
- **delta**: Better git diff viewer
- **lazygit**: Terminal UI for git
- **gh**: GitHub CLI
- **git-crypt**: Transparent file encryption in git
- **gitleaks**: Secret scanning for repos

### Productivity
- **cheat**: Quick reference cheat sheets
- **tldr**: Simplified man pages
- **tmux**: Terminal multiplexer
- **screen**: Alternative multiplexer
- **task/taskwarrior**: Task management

### Code Quality
- **pre-commit**: Git hooks framework
- **shellcheck**: Shell script linter
- **shfmt**: Shell script formatter
- **hadolint**: Dockerfile linter
- **yamllint**: YAML linter
- **tfsec**: Terraform security scanner

### Security Tools
- **trivy**: Container vulnerability scanner
- **cosign**: Container signing and verification
- **age**: Modern encryption tool
- **sops**: Secrets encryption in files
- **vault**: HashiCorp secrets management
- **gpg**: GNU Privacy Guard
- **pass**: Password manager
- **1password-cli**: 1Password integration
- **nmap**: Network scanning
- **netcat (nc)**: Network debugging
- **tcpdump**: Network traffic analyzer
- **wireshark-cli (tshark)**: Packet analysis

### DevOps & Infrastructure
- **terraform**: Infrastructure as Code
- **ansible**: Configuration management
- **kubectl**: Kubernetes CLI
- **helm**: Kubernetes package manager
- **k9s**: Kubernetes TUI
- **docker**: Container management
- **podman**: Docker alternative
- **vagrant**: Development environments
- **packer**: Image building
- **cloud CLIs**: aws-cli, gcloud, az

### Monitoring & Observability
- **htop/btop**: Interactive process viewer
- **iotop**: I/O monitoring
- **nethogs**: Network bandwidth per process
- **ncdu**: Disk usage analyzer
- **glances**: System monitoring
- **prometheus**: Metrics collection
- **grafana-cli**: Dashboard management
- **datadog-cli**: Datadog integration
- **stern**: Multi-pod log tailing (K8s)
- **logcli**: Loki log query

### Network & Diagnostics
- **curl**: HTTP client
- **httpie**: User-friendly HTTP client
- **wget**: File downloader
- **dig**: DNS lookup
- **nslookup**: DNS queries
- **ss**: Socket statistics
- **ip**: Network configuration
- **traceroute/mtr**: Network path analysis
- **iperf3**: Network performance testing
- **speedtest-cli**: Internet speed testing

### System Administration
- **systemctl**: Service management
- **journalctl**: Systemd logs
- **rsync**: File synchronization
- **rclone**: Cloud storage sync
- **restic**: Backup solution
- **borgbackup**: Deduplicating backups
- **ansible-vault**: Encrypt sensitive data
- **fail2ban**: Intrusion prevention
- **lynis**: Security auditing
- **osquery**: SQL-powered system info

### Container & Orchestration
- **docker-compose**: Multi-container apps
- **buildah**: Container image builder
- **skopeo**: Container image operations
- **dive**: Docker image layer analysis
- **lazydocker**: Docker TUI
- **ctop**: Container metrics
- **kubectx/kubens**: K8s context switching
- **kustomize**: K8s configuration management
- **argocd**: GitOps continuous delivery

### Development & Testing
- **jq**: JSON processor
- **yq**: YAML processor
- **xmlstarlet**: XML processor
- **httpie**: API testing
- **grpcurl**: gRPC testing
- **vegeta**: HTTP load testing
- **ab**: Apache Benchmark
- **hey**: HTTP load generator

### Cloud-Specific Tools
- **aws-cli**: Amazon Web Services
- **gcloud**: Google Cloud Platform
- **az**: Microsoft Azure
- **doctl**: DigitalOcean
- **linode-cli**: Linode
- **eksctl**: AWS EKS management
- **aws-vault**: AWS credential management

## Integration Guidelines

### General Principles
- Check availability before use: `command -v tool &> /dev/null`
- Provide fallback to standard tools when possible
- Document tool purpose and usage scenarios
- Add to Makefile for easy installation
- Consider offline scenarios and caching
- Version pin critical tools for reproducibility

### Security Best Practices
- Never store credentials in plain text
- Use secret management tools (vault, sops, age)
- Scan containers before deployment (trivy, cosign)
- Enable pre-commit hooks for security checks
- Audit tool permissions and access
- Keep security tools updated regularly

### DevOps Integration
- Integrate with CI/CD pipelines
- Automate infrastructure provisioning
- Use IaC for reproducible environments
- Implement monitoring from day one
- Practice GitOps workflows
- Maintain runbooks and documentation

### System Administration
- Monitor system resources proactively
- Automate routine maintenance tasks
- Implement proper backup strategies
- Use configuration management tools
- Document incident response procedures
- Maintain audit logs

## For This Project

### Current State
- Expand tools/ directory with curated utilities
- Create cheat sheets for common operations
- Integrate with existing workflow
- Maintain offline-first philosophy

### Recommended Additions

#### Security Enhancements
```bash
# Add security scanning to pre-commit
tools/install-security: ## Install security tools
	@command -v trivy || curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
	@command -v gitleaks || brew install gitleaks
	@command -v age || brew install age
```

#### DevOps Tooling
```bash
# Add infrastructure tools
tools/install-devops: ## Install DevOps tools
	@command -v terraform || curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	@command -v kubectl || curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	@command -v helm || curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

#### Monitoring Setup
```bash
# Add system monitoring
tools/install-monitoring: ## Install monitoring tools
	@command -v htop || sudo apt install htop
	@command -v ncdu || sudo apt install ncdu
	@command -v iotop || sudo apt install iotop
```

### Cheat Sheet Examples

Create `tools/cheats/security.md`:
```markdown
# Security Cheat Sheet

## Container Scanning
trivy image nginx:latest
trivy fs --security-checks vuln,config .

## Secret Scanning
gitleaks detect --source .
gitleaks protect --staged

## Encryption
age-keygen -o key.txt
age -r recipient.pub -o file.enc file.txt
age -d -i key.txt -o file.txt file.enc
```

Create `tools/cheats/devops.md`:
```markdown
# DevOps Cheat Sheet

## Kubernetes
kubectl get pods -A
kubectl logs -f pod-name
kubectl exec -it pod-name -- /bin/bash
k9s  # Interactive UI

## Terraform
terraform init
terraform plan
terraform apply
terraform destroy

## Docker
docker ps
docker logs -f container
docker exec -it container bash
lazydocker  # Interactive UI
```

### Makefile Integration Pattern
```makefile
.PHONY: security-scan
security-scan: ## Run security scans on repository
	@echo "Running Trivy container scan..."
	@trivy fs --severity HIGH,CRITICAL .
	@echo "Running Gitleaks secret scan..."
	@gitleaks detect --source . --no-git
	@echo "✓ Security scan complete"

.PHONY: infra-plan
infra-plan: ## Plan infrastructure changes
	@command -v terraform || { echo "Terraform not installed"; exit 1; }
	@cd infrastructure && terraform plan
```

## Tool Selection Criteria

When recommending tools, consider:

1. **Security**: Does it enhance security posture?
2. **Performance**: Is it faster/better than alternatives?
3. **Maintenance**: Is it actively maintained?
4. **Dependencies**: Does it require minimal external deps?
5. **Offline Support**: Can it work without internet?
6. **Learning Curve**: Is it intuitive to use?
7. **Integration**: Does it play well with existing tools?
8. **Compliance**: Does it meet security/audit requirements?

## Antipatterns to Avoid

- Installing tools without version control
- Storing secrets in environment files
- Running containers as root unnecessarily
- Skipping security scans in CI/CD
- Using outdated or unmaintained tools
- Over-engineering simple tasks
- Ignoring tool deprecation warnings
- Not documenting tool dependencies
