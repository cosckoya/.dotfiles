# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Production-ready dotfiles for Linux development environments. Self-contained, offline-capable, and optimized for performance. Focused on ZSH, Tmux, Neovim, and Kitty terminal configurations with ~110ms ZSH startup time (92% faster than typical configurations).

## Build and Installation Commands

### Primary Installation
```bash
make all          # Install everything (asdf + profile)
make profile      # Install ZSH, Tmux, Kitty, and Neovim configs only
make asdf         # Install/update ASDF version manager
```

### Neovim Installation
```bash
make install-nvim # Install Neovim via snap (requires sudo)
make neovim       # Configure Neovim with Lua setup
```

**Note**: Neovim 0.11+ is required. Install with `make install-nvim` which uses:
```bash
sudo snap install nvim --classic
```

### Individual Components
```bash
make zsh          # Install ZSH configuration and set as default shell
make tmux         # Install Tmux configuration
make kitty        # Install Kitty terminal configuration
make neovim       # Install Neovim Lua configuration (requires nvim 0.11+)
```

### Utilities
```bash
make help         # Show all available targets
```

## Architecture and Key Components

### Configuration Structure
The repository uses a modular approach for maintainability:

- **zshrc** - Main ZSH entry point that orchestrates module loading
- **zsh.d/** - Modular ZSH configuration split by function:
  - `config.zsh` - User-configurable variables (tmux auto-start behavior, session names)
  - `tools.zsh` - Editor selection, PATH management, npm lazy-loading
  - `alias.zsh` - Command aliases and functions (uses function syntax for performance)
  - `autocomplete.zsh` - Lazy-loaded completions for kubectl/helm/kind
  - `tmux.zsh` - Tmux helper functions
  - `toolbox.zsh` - Utility functions
- **config/** - Centralized configuration directory:
  - `tmux.conf` - Unified tmux 3.4+ configuration (238 lines, optimized from 1889-line original)
  - `kitty.conf` - Kitty terminal emulator settings
  - `nvim/` - Complete Neovim Lua configuration (see Neovim Configuration Architecture section)
- **vimrc** - Legacy Vim configuration (kept for backwards compatibility)
- **Makefile** - Main installation orchestrator with color-coded output

### Performance Optimizations

**ZSH Startup (~110ms):**
- Zinit plugin manager with turbo mode (asynchronous loading with staggered delays: wait"1", wait"2", wait"3")
- Lazy-loading for completions and npm commands
- Compinit caching with -C flag
- Reduced history size (5000 vs 10000)
- Conditional plugin loading with graceful fallbacks

**Tmux Configuration:**
- Native tmux 3.4+ syntax (no external dependencies)
- Drizzt Do'Urden color scheme matching ZSH and Kitty
- Lavender borders for active panes, cavern stone for inactive
- Mouse support enabled with kitty-specific optimizations
- Vi-style copy mode with system clipboard integration
- Aggressive resize for multi-client scenarios

**Module Loading Pattern:**
- All tool checks use `command -v` before execution
- PATH additions only occur if directories exist
- Editor fallback chain: nvim → vim → nano
- Zinit plugins only load if git is available

### Key Implementation Details

**Prompt System (RPROMPT) - Drizzt Do'Urden:**
- Dynamic right prompt built via `_build_rprompt()` function
- Git branch (Icy blue from Twinkle #7ec8e3 / 117) via vcs_info - only shows in git repos
- Python virtualenv (Lavender eyes #b19cd9 / 141) - shows when activated
- Kubernetes context (Drow magic green #5ab897 / 78) - shows if kubectl context exists
- Fallback message "Klaatu Barada Nitko!" (Magical yellow #f0c987 / 222) when no context
- Left prompt: `┌──(hostname の username)\n└─#` with Drizzt color-coded components (lavender, icy blue, yellow, red)

**Tmux Integration:**
- Smart auto-start that respects IDE, SSH, and desktop environment contexts
- Configurable via `TMUX_AUTOSTART_ENABLED`, `TMUX_SKIP_SSH`, `TMUX_SKIP_IDE`, `TMUX_SKIP_DESKTOP`
- Default session name controlled by `TMUX_AUTOSTART_SESSION` (defaults to "default")
- Vi-style keybindings with optimized scrolling (C-u/C-d for half-page)
- Multi-platform clipboard support (xsel, wl-copy, pbcopy)

**Color Scheme (Drizzt Do'Urden) - Complete Coherence:**
- **Fully unified theme** across ZSH, Tmux, Kitty, and Neovim with matching powerline styles
- Inspired by the legendary drow ranger from the Forgotten Realms
- Background: #100814 (deep drow cavern - darker purple, superior contrast), Foreground: #e0dfe8
- Primary colors: Lavender #b19cd9 (violet eyes), Icy Blue #7ec8e3 (Twinkle), Green #5ab897 (drow magic)
- Inactive borders: #4a5273 (improved contrast over previous #3d4466)
- ZSH uses 256-color codes: 141=lavender, 117=icy blue, 78=green, 222=yellow, 167=red
- Dircolors configured in ~/.dircolors for consistent ls output
- WCAG AAA contrast ratios: 15:1 (text), 9:1 (lavender), 10.5:1 (icy blue)
- **Tmux status bar**: Simplified powerline with essential info (pane count, time, root warning with blink)
- **Neovim statusline**: Matching powerline with mode-specific colors (Normal=lavender, Insert=green, Visual=cyan)

### Lazy Loading Mechanism
Completions and heavy tools use a self-removing wrapper pattern:
```zsh
# Function undefines itself after first use, then sources the real completion
_load_tool_completion() {
  source <(tool completion zsh)
  unfunction _load_tool_completion
}
compdef _load_tool_completion tool
```

### Platform Compatibility
- **Target OS:** Ubuntu/Debian Linux
- **Required:** zsh 5.9+, git 2.40+, tmux 3.2+, neovim 0.11+
- **Optional with fallbacks:** kubectl, helm, docker, npm, asdf, bat, fzf
- **Clipboard:** Supports xsel, xclip, wl-copy, pbcopy
- **Neovim Installation:** Via snap (`sudo snap install nvim --classic`) provides latest stable version

## Important Configuration Variables

When modifying tmux auto-start behavior, edit `zsh.d/config.zsh`:
- `TMUX_AUTOSTART_ENABLED` - Enable/disable tmux auto-start (default: true)
- `TMUX_AUTOSTART_SESSION` - Default session name (default: "default")
- `TMUX_SKIP_SSH` - Skip tmux in SSH sessions (default: false)
- `TMUX_SKIP_IDE` - Skip tmux in IDEs like VSCode (default: true)
- `TMUX_SKIP_DESKTOP` - Skip tmux in graphical desktop sessions (default: true)
- `TMUX_SKIP_DESKTOP_SESSIONS` - Comma-separated list of desktop sessions to skip (default: "bspwm,i3,gnome,kde,xfce")

## Code Quality Guidelines

From `.copilot-instructions.md`:

**Performance:**
- Never add startup checks without `command -v` guard
- Always lazy-load completions that run external commands
- Prefer conditional `[[ -d $path ]]` over command checks for paths
- Use Zinit turbo mode with wait delays for non-critical plugins
- Keep history size ≤ 5000

**Compatibility:**
- Check for tool existence before using
- Provide fallbacks for critical tools
- Use safe defaults if anything fails (no stderr pollution)
- Support multiple clipboard managers
- Test on Ubuntu/Debian with minimal tools

**Code Style:**
- Use 2-space indents for ZSH
- Comment complex sections (vcs_info, turbo loading)
- Avoid nested conditionals (use early returns)
- Keep related configs together
- Remove commented code before merging to main

## Testing Commands

```bash
# Test ZSH startup performance
time zsh -ic exit

# Reload ZSH configuration
exec zsh

# Test tmux configuration
tmux source ~/.tmux.conf

# Test in fresh shell
zsh -c 'source ~/.zshrc'
```

## Neovim Configuration Architecture

The Neovim setup uses a modern Lua-based architecture:

**Entry Point**: `config/nvim/init.lua`
- Auto-bootstraps lazy.nvim plugin manager on first launch
- Loads core configuration modules in sequence
- Configures lazy.nvim with performance optimizations (disabled plugins: gzip, matchit, netrw, etc.)

**Core Modules** (`config/nvim/lua/core/`):
- `options.lua` - Editor settings (line numbers, indentation, clipboard, etc.)
- `keymaps.lua` - Custom keybindings
- `autocmds.lua` - Autocommands for behavior automation

**Plugin Modules** (`config/nvim/lua/plugins/`):
- `init.lua` - Plugin manager configuration
- `lsp.lua` - LSP configuration with Mason for language servers (Lua, Python, Bash)
- `completion.lua` - nvim-cmp + LuaSnip for autocompletion and snippets
- `ui.lua` - UI enhancements (which-key, tokyonight theme)
- `editor.lua` - Editor plugins (Telescope fuzzy finder, etc.)

**Key Features**:
- Native LSP integration (no CoC or other external servers)
- Lazy loading for optimal startup performance
- Self-contained (no npm/cargo/go dependencies)
- Automatic plugin installation on first launch

## Pre-commit Hooks

The repository uses pre-commit hooks (`.pre-commit-config.yaml`) for code quality:

**Enabled Hooks**:
- `check-merge-conflict` - Prevents committing merge conflicts
- `end-of-file-fixer` - Ensures files end with newline
- `trailing-whitespace` - Removes trailing whitespace
- `check-yaml` - Validates YAML syntax
- `check-added-large-files` - Prevents large files (except `img/`)
- `check-case-conflict` - Detects case-sensitive filename conflicts
- `detect-private-key` - Prevents committing private keys
- `mixed-line-ending` - Enforces LF line endings
- `makefile-syntax` - Validates Makefile syntax
- `checkmake` - Lints Makefiles (optional, skips if not installed)

**Installation**: Run `pre-commit install` after cloning to enable hooks.

## Important File Locations

**Current Structure** (post-migration):
- Configuration files moved from root to `config/` directory
- `config/tmux.conf` - Previously at root as `tmux.conf`
- `config/kitty.conf` - Previously at root as `kitty.conf`
- `config/nvim/` - New Lua-based Neovim configuration
- Old `vimrc` still exists at root for backwards compatibility

**Active Files**:
- `zshrc` - Main ZSH entry point
- `zsh.d/*.zsh` - Modular ZSH configuration
- `config/tmux.conf` - Tmux 3.4+ configuration
- `config/kitty.conf` - Kitty terminal settings
- `config/nvim/` - Complete Neovim Lua setup
- `Makefile` - Installation orchestrator
- `.pre-commit-config.yaml` - Git hook configuration
