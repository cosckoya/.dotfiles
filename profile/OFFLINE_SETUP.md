# Offline / Self-Contained Setup

This repository is designed to work completely offline without requiring internet access.

## Philosophy

✅ **All dependencies included** - No remote downloads during setup
✅ **Version controlled** - All configurations tracked in git
✅ **Reproducible** - Same setup on any machine
✅ **Portable** - Works in air-gapped environments

## Self-Contained Components

### 1. Tmux Configuration ✅

**Location:** `profile/tmux.conf`
**Source:** [Oh my tmux!](https://github.com/gpakosz/.tmux)
**Status:** Fully included in repository

```bash
# No internet required
make tmux -C profile
```

**What it does:**
- Symlinks local `tmux.conf` to `~/.tmux.conf`
- Symlinks `tmux.local` to `~/.tmux.conf.local`
- No remote downloads

### 2. ZSH Configuration ✅

**Location:** `profile/zshrc`, `profile/zsh.d/`
**Status:** Fully included in repository

```bash
# No internet required
make zsh -C profile
```

**Note:** Zinit plugin manager will download plugins on first run. This is expected behavior for a plugin manager.

### 3. Neovim Configuration ✅

**Location:** `profile/vimrc`
**Status:** Fully included in repository

```bash
# No internet required
make neovim -C profile
```

**Note:** Vim/Neovim plugins will download on first `vim` launch if you use a plugin manager.

## Internet-Dependent Components

Some tools require internet for initial setup:

### ASDF Version Manager

```bash
make asdf  # Downloads latest version
```

**Reason:** Needs to fetch latest release from GitHub

### Tools Installation

```bash
make tools -C tools  # May download pre-commit, checkmake
```

**Components:**
- `pre-commit` - Python package (via pip)
- `cheat` - Via ASDF
- `checkmake` - Binary from GitHub releases

### Container Tools

```bash
make all -C container  # May download Docker, kubectl, helm, etc.
```

**Components:**
- Docker CE
- Kubernetes tools
- Container utilities

### Cloud Tools

```bash
make all -C cloud  # Downloads terraform, checkov, etc via ASDF
```

## Offline-First Design

### What Works Offline

✅ **Profile setup** (ZSH, Tmux, Neovim)
✅ **Configuration management**
✅ **Pre-existing tool usage**
✅ **Documentation access**

### What Requires Internet (First Time)

❌ **ASDF installation** (downloads binary)
❌ **Tool installations** (most tools)
❌ **Plugin managers** (Zinit, vim-plug, etc.)

## Making More Components Offline

### Option 1: Pre-download Binaries

Create a `cache/` directory with pre-downloaded binaries:

```bash
mkdir -p cache/binaries
# Download tools
wget -O cache/binaries/checkmake https://...
wget -O cache/binaries/asdf https://...
```

### Option 2: Package Managers

Use system package managers when available:

```bash
# Ubuntu/Debian
sudo apt install tmux zsh neovim

# macOS
brew install tmux zsh neovim
```

### Option 3: Air-Gap Installation

For completely offline setups:

1. Download all tools on internet-connected machine
2. Transfer to target machine
3. Install from local files

## Verification

### Check for Remote Dependencies

```bash
# Search for wget/curl in Makefiles
grep -r "wget\|curl" --include="Makefile" .

# Test offline setup
make -n tmux -C profile | grep -i http
```

### Test Offline Mode

```bash
# Disable network (as root)
sudo iptables -A OUTPUT -j DROP

# Try setup
make profile

# Re-enable network
sudo iptables -F
```

## File Manifest

### Included in Repository

```
profile/
├── tmux.conf          # ✅ Oh my tmux! base config (98KB)
├── tmux.local         # ✅ Your customizations
├── tmux.README.md     # ✅ Documentation
├── zshrc              # ✅ ZSH configuration
├── zsh.d/             # ✅ ZSH modules
│   ├── alias.zsh
│   ├── autocomplete.zsh
│   ├── config.zsh
│   ├── tmux.zsh
│   ├── toolbox.zsh
│   └── tools.zsh
├── vimrc              # ✅ Vim/Neovim config
└── Makefile           # ✅ Setup automation
```

### Not Included (Downloaded at Runtime)

```
~/.local/share/zinit/         # ZSH plugin manager
~/.asdf/                      # Version manager
~/.vim/plugged/               # Vim plugins
/home/user/bin/checkmake      # Makefile linter
```

## Benefits

### For Development
- 🚀 Fast setup (no downloads)
- 🔒 Secure (no external code execution)
- 📦 Portable (works anywhere)

### For Production
- 🏢 Enterprise-friendly (air-gap compatible)
- 🔐 Security-compliant (no internet required)
- ⚡ Quick deployment (instant setup)

### For Personal Use
- ✈️ Travel-friendly (works offline)
- 🏠 Home network issues (no problems)
- 💾 Backup-ready (all files included)

## Migration from External Dependencies

### Before (Required Internet)

```makefile
tmux:
	wget https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf
```

### After (Fully Offline)

```makefile
tmux:
	ln -s -f ${PROFILE}/tmux.conf ${HOME}/.tmux.conf
```

## Updates

### Updating Offline Components

To update included configurations:

```bash
# Download latest tmux.conf
curl -o profile/tmux.conf https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf

# Commit to repository
git add profile/tmux.conf
git commit -m "Update tmux.conf to latest upstream version"
```

### Update Frequency

| Component | Update Frequency | Method |
|-----------|-----------------|--------|
| tmux.conf | Every 6 months | Manual download |
| zshrc | As needed | Direct edit |
| vimrc | As needed | Direct edit |
| Makefiles | As needed | Direct edit |

## Best Practices

1. **Version control everything** - Commit all config files
2. **Document sources** - Note where external configs came from
3. **Test offline** - Verify setup works without internet
4. **Keep snapshots** - Tag working configurations
5. **Update consciously** - Don't auto-update from upstream

## FAQ

### Q: Why include external configs in the repo?

**A:** To ensure reproducibility and offline capability. External dependencies can disappear or change unexpectedly.

### Q: How to update external configs?

**A:** Manually download and commit to the repository. See "Updates" section.

### Q: What about license compliance?

**A:** All included configs are permissively licensed (MIT, WTFPL, etc.). See individual README files.

### Q: Can I use this in a corporate environment?

**A:** Yes! The self-contained nature makes it perfect for restricted/air-gapped networks.

## Support

For issues or questions about offline setup, see:
- `tmux.README.md` - Tmux configuration details
- `TMUX_INTEGRATION.md` - Auto-start integration
- `MAKEFILE_BEST_PRACTICES.md` - Makefile documentation
