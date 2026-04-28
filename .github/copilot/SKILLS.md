# Copilot Skills - Deep Dive Guides

**Skill guides for specialized topics in this project.**

Auto-loaded when Copilot initializes. Use these for detailed explanations beyond the main README.copilot.md.

---

## 📚 Available Skills

### 1. Shell Performance Optimization
**File:** [`shell-performance.md`](./skills/shell-performance.md)

**Focus:** ZSH startup time optimization, profiling, and lazy-loading patterns

**Use when:**
- ZSH startup is slow
- Need to profile completion loading
- Want to understand Zinit turbo mode
- Implementing lazy-loading patterns

**Topics covered:**
- Startup time measurement
- Profiling with zprof
- Lazy-loading completions
- Zinit turbo mode optimization
- Common performance pitfalls

---

### 2. Lua & Neovim Configuration
**File:** [`lua-neovim.md`](./skills/lua-neovim.md)

**Focus:** Modern Neovim setup with Lua, plugin management, and LSP configuration

**Use when:**
- Working with Neovim configuration
- Setting up LSP and completions
- Managing plugins with lazy.nvim
- Writing Lua configs for Neovim

**Topics covered:**
- Lua fundamentals for Neovim
- Lazy.nvim plugin specs
- LSP setup with Mason
- Completion configuration
- Keymapping and custom functions
- Performance optimization

---

### 3. Tmux Modern Configuration
**File:** [`tmux-modern.md`](./skills/tmux-modern.md)

**Focus:** Tmux 3.4+ native syntax, keybindings, and theming

**Use when:**
- Configuring Tmux keybindings
- Setting up Tmux status bar
- Working with modern Tmux syntax
- Troubleshooting Tmux integration

**Topics covered:**
- Tmux 3.4+ native syntax
- Vi-mode configuration
- Keybinding patterns
- Status bar customization
- Window/pane management
- Copy mode and clipboard

---

### 4. Kitty Terminal Configuration
**File:** [`kitty-terminal.md`](./skills/kitty-terminal.md)

**Focus:** GPU-accelerated terminal setup, theming, and advanced features

**Use when:**
- Configuring Kitty terminal
- Setting up fonts and colors
- Implementing clipboard integration
- Working with terminal features

**Topics covered:**
- Kitty configuration format
- Font setup and fallbacks
- Color scheme management
- Clipboard integration
- Keyboard shortcuts
- Advanced rendering options

---

### 5. Modern Makefile Patterns
**File:** [`modern-makefile.md`](./skills/modern-makefile.md)

**Focus:** Makefile best practices, idempotency, and advanced techniques

**Use when:**
- Writing or modifying Makefile targets
- Need idempotent installation
- Implementing complex build logic
- Optimizing Make performance

**Topics covered:**
- Idempotent target patterns
- Error handling in Make
- Variable usage and substitution
- Target dependency management
- Common Makefile pitfalls
- Cross-platform compatibility

---

### 6. Git & Pre-commit Hooks
**File:** [`git-precommit.md`](./skills/git-precommit.md)

**Focus:** Git workflow, pre-commit hook configuration, and code quality automation

**Use when:**
- Setting up pre-commit hooks
- Configuring linters and validators
- Implementing CI/CD checks locally
- Managing git workflow

**Topics covered:**
- Pre-commit framework setup
- Custom hook creation
- Linter integration
- YAML configuration
- Hook ordering and dependencies
- Performance considerations

---

## 🎯 Quick Reference

| Topic | When to Use | Key File |
|-------|-----------|----------|
| ZSH slow | Profile startup | shell-performance.md |
| Neovim config | Setup LSP, plugins | lua-neovim.md |
| Tmux settings | Keybindings, theme | tmux-modern.md |
| Kitty terminal | Colors, fonts | kitty-terminal.md |
| Makefile issues | Build targets, install | modern-makefile.md |
| Git workflow | Pre-commit, hooks | git-precommit.md |

---

## 📖 How to Use Skills

1. **Identify your topic** — Match your issue to a skill above
2. **Open the skill file** — Click the link or read the file directly
3. **Find relevant section** — Use Ctrl+F to search within the skill
4. **Apply patterns** — Copy examples and adapt to your use case
5. **Reference main docs** — Use README.copilot.md for overall context

---

## 🚀 Auto-Load Behavior

Skills are:
- ✅ **Always available** during Copilot sessions
- ✅ **Referenced in README.copilot.md** for context
- ✅ **Listed here** with quick descriptions
- ✅ **Organized by topic** for easy discovery

Copilot will automatically suggest relevant skills based on your question or code context.

---

**Last Updated:** 2026-02-17
**Status:** ✅ Auto-enabled for all sessions
**Standard:** GitHub Copilot 2026 Best Practices
