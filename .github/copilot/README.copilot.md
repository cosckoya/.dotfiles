# GitHub Copilot - Project Guidelines

**Status:** ✅ COMPLETE & MANDATORY
**Updated:** 2026-02-17
**Scope:** All Copilot sessions and code changes
**Standard:** 2026 Best Practices

---

## 📖 Table of Contents

1. [Quick Start](#quick-start)
2. [Available Skills](#available-skills) ⭐ **Auto-Loaded**
3. [Five Mandatory Principles](#five-mandatory-principles)
4. [Architecture & Conventions](#architecture--conventions)
5. [Software Engineering Methodology](#software-engineering-methodology)
5. [Build & Test Commands](#build--test-commands)
6. [Copilot Integration](#copilot-integration)
7. [Implementation Checklist](#implementation-checklist)
8. [FAQ & Troubleshooting](#faq--troubleshooting)

---

## Quick Start

### For New Developers
1. **Read this file** (skip to relevant section)
2. **Reference examples** when coding
3. **Use implementation checklist** before submitting changes
4. **Ask Copilot**: "Does this follow Clean Code / YAGNI / SOLID?"

### Key Commands
| Task | Command |
|------|---------|
| Install everything | `make all` |
| View all targets | `make help` |
| Check ZSH startup | `time zsh -ic exit` |
| Run linters | `pre-commit run --all-files` |

---

## Available Skills ⭐ Auto-Loaded

**Skills are automatically available when Copilot initializes.**

Use these specialized guides for deep-diving into specific topics:

| Skill | Use When |
|-------|----------|
| [Shell Performance](./skills/shell-performance.md) | ZSH startup slow, profiling needed |
| [Lua & Neovim](./skills/lua-neovim.md) | Neovim config, LSP, plugins |
| [Tmux Modern](./skills/tmux-modern.md) | Tmux keybindings, status bar |
| [Kitty Terminal](./skills/kitty-terminal.md) | Terminal colors, fonts, clipboard |
| [Modern Makefile](./skills/modern-makefile.md) | Makefile targets, install logic |
| [Git & Pre-commit](./skills/git-precommit.md) | Pre-commit hooks, Git workflow |

**Full reference:** See [`SKILLS.md`](./SKILLS.md) for descriptions and when to use each skill.

---

## Six Mandatory Principles

**ALL code must follow these non-negotiable principles:**

### 1. KISS (Keep It Simple, Stupid)
**Simplicity is the highest virtue.**

- Choose simplest solution that solves the problem
- One function = one responsibility
- No over-engineered helpers or abstractions

**Shell/ZSH Example:**
```zsh
# ✅ GOOD: Clear, direct
export TMUX_AUTOSTART_ENABLED="${TMUX_AUTOSTART_ENABLED:-true}"

# ❌ BAD: Over-engineered
_init_config() { export TMUX_AUTOSTART_ENABLED="${TMUX_AUTOSTART_ENABLED:-true}"; }
```

#### 2. DRY (Don't Repeat Yourself)
**Every piece of knowledge lives in exactly one place.**

- Extract duplicated logic when pattern repeats >2x
- Centralize configurations to prevent inconsistencies
- Single source of truth for each setting

**Example:**
```zsh
# ✅ GOOD: Central definition
export TMUX_AUTOSTART_ENABLED="${TMUX_AUTOSTART_ENABLED:-true}"
# Used everywhere, not redefined

# ❌ BAD: Scattered definitions
# In config.zsh:
export TMUX_AUTOSTART_ENABLED="true"
# In tmux.zsh:
export TMUX_AUTOSTART_ENABLED="true"
```

#### 3. Clean Code
**Code is read more than written. Clarity is paramount.**

- Meaningful names that reveal intent
- Functions clear enough to eliminate comments explaining WHAT
- Comments explain WHY behind complex decisions
- Consistent formatting and naming conventions

**Example:**
```zsh
# ✅ GOOD: Names reveal intent, comment explains why
# Skip tmux in IDE terminals because editors manage windows
if [[ $TMUX_SKIP_IDE == "true" && -n $VSCODE_INJECTION ]]; then
  return 0
fi

# ❌ BAD: Cryptic naming, redundant comment
# Check if IDE
if [[ -n $VSCODE_INJECTION ]]; then
  skip_tmux=true
fi
```

### Advanced Engineering Principles (2)

#### 4. YAGNI (You Ain't Gonna Need It)
**Solve the current problem in the most direct way. Don't build for speculation.**

- Implement ONLY what's needed now
- Avoid "just in case" features
- Simplest solution beats theoretical perfection
- Prevents unnecessary abstraction layers that increase technical debt

**Makefile Example:**
```makefile
# ✅ GOOD: Direct, solves current problem
.PHONY: zsh
zsh: ## Install ZSH profile
	@ln -sf ${DOTFILES}/zshrc ${HOME}/.zshrc

# ❌ BAD: Over-abstracted (YAGNI violation)
define install_profile
	@mkdir -p $(2)
	@ln -sf ${DOTFILES}/$(1) $(2)
endef
zsh:
	$(call install_profile,zshrc,${HOME}/.zshrc)
```

#### 5. SOLID
**Write scalable, maintainable code that's easy to extend.**

- **Single Responsibility:** One reason to change per function
- **Open/Closed:** Open for extension, closed for modification
- **Liskov Substitution:** Correct abstraction usage
- **Interface Segregation:** Don't force unnecessary dependencies
- **Dependency Inversion:** Depend on abstractions, not implementations

**ZSH Example:**
```zsh
# ✅ GOOD: Each function has single responsibility
_is_in_ide() { [[ -n $VSCODE_INJECTION ]]; }
_is_in_ssh() { [[ -n $SSH_CONNECTION ]]; }
_should_skip_tmux() {
  _is_in_ide && return 0
  _is_in_ssh && return 0
  return 1
}

# ❌ BAD: Multiple responsibilities in one function
autostart_tmux() {
  if [[ -z $TMUX ]]; then
    if [[ -z $VSCODE_INJECTION ]] && [[ -z $SSH_CONNECTION ]]; then
      tmux attach || tmux new-session
    fi
  fi
}
```

---

## Architecture & Conventions

### Project Structure

**Modular, offline-capable dotfiles system** with four core components:

1. **ZSH Configuration** (`zshrc` + `zsh.d/`)
   - Entry: `zshrc` bootstraps modular config
   - Modules: 6 files in `zsh.d/` (config, tools, alias, autocomplete, tmux, toolbox)
   - Plugin manager: Zinit with turbo mode (async loading)
   - Startup: ~110ms (profile with `time zsh -ic exit`)

2. **Tmux Configuration** (`config/tmux.conf`)
   - Native 3.4+ syntax (no legacy support)
   - Vi-mode + clipboard integration
   - Drizzt Do'Urden theme

3. **Neovim Configuration** (`config/nvim/`)
   - Entry: `init.lua` (minimal, delegates to modules)
   - Structure: `lua/core/` + `lua/plugins/` (lazy.nvim)
   - LSP: Native LSP via Mason, completions via nvim-cmp
   - Startup: ~300ms (lazy plugins)

4. **Terminal + Desktop** (`config/kitty.conf`)
   - GPU-accelerated rendering
   - Drizzt Do'Urden theme (#100814, #b19cd9, #7ec8e3)

### Key Conventions

#### Makefile
- **Idempotent targets:** Safe to run multiple times
- **Conditional checks:** Verify tool existence before use
- **Quiet execution:** Use `@` prefix, clear status on completion
- **Variables:** Never hardcode paths (`$(HOME)`, `$(DOTFILES)`)

**Pattern:**
```makefile
.PHONY: target
target: ## Description
	@command -v tool >/dev/null || { echo "Error"; exit 1; }
	@mkdir -p $(DIR)
	@ln -sf source dest
	@echo "✓ Done"
```

#### ZSH Module Organization
- **2-space indentation** (consistency)
- **Guard all tool checks:** `if command -v X >/dev/null; then ... fi`
- **Lazy-load completions:** Don't load on startup
- **Comments explain WHY,** not WHAT

**Lazy-load pattern:**
```zsh
_load_tool_completion() {
  source <(tool --completion zsh)
  unfunction _load_tool_completion
  _load_tool_completion
}
compdef _load_tool_completion tool
```

#### Neovim Lua
- **Entry:** `init.lua` minimal (requires only)
- **Modules:** `core/` for options/keymaps/autocmds
- **Plugins:** `plugins/` with lazy.nvim specs
- **Plugin spec:** Always `lazy = true` unless needed at startup

**Plugin spec pattern:**
```lua
return {
  {
    "owner/plugin",
    lazy = true,
    cmd = "CommandName",
    dependencies = { "other/plugin" },
    config = function() ... end,
  },
}
```

#### Theme Consistency (Drizzt Do'Urden)
- **Background:** `#100814` (deep purple)
- **Lavender:** `#b19cd9` (Twinkle's eyes)
- **Blue:** `#7ec8e3` (icy dagger)
- Apply to: Kitty, Tmux, Neovim, ZSH prompt

### Core Constraints
- ✅ ~110ms ZSH startup (profile and validate)
- ✅ Offline-capable (no runtime external dependencies)
- ✅ Idempotent installation (`make X && make X` succeeds)
- ✅ Self-contained (minimal system dependencies)
- ✅ Linux-first (Ubuntu/Debian optimized)

---

## Software Engineering Methodology

### Real-World Example: Lazy-Load Completions

**Problem:** Add lazy-loading for tool completions (fzf, kubectl, helm)

**❌ BEFORE (Violates principles):**
```zsh
if command -v fzf >/dev/null; then
  source <(fzf --zsh)
fi
if command -v kubectl >/dev/null; then
  source <(kubectl completion zsh)
fi
if command -v helm >/dev/null; then
  source <(helm completion zsh)
fi
```

Issues:
- ✗ Duplicated logic (DRY violation)
- ✗ Not lazy-loaded (YAGNI: loads on startup)
- ✗ Hard to extend (SOLID violation)

**✅ AFTER (Follows all principles):**
```zsh
# config.zsh - Single source of truth (DRY)
declare -a LAZY_TOOLS=(fzf kubectl helm)

# tmux.zsh - Self-documenting, one responsibility (Clean Code)
_load_completion_lazy() {
  local tool=$1
  if command -v "$tool" >/dev/null; then
    source <($tool completion zsh)
  fi
}

# Extensible without modification (SOLID)
for tool in "${LAZY_TOOLS[@]}"; do
  _load_completion_lazy "$tool"
done

# NEW TOOLS: Just add to LAZY_TOOLS, no code change needed!
```

**Why better:**
- ✓ No duplication (DRY)
- ✓ Clear naming (Clean Code)
- ✓ Extensible (SOLID)
- ✓ Lazy-loaded (YAGNI)
- ✓ Simple (KISS)

### When Principles Conflict
1. **Clarity > Brevity** — Readable beats clever
2. **Simplicity > Perfection** — Working simple beats theoretical perfect
3. **Requirements > Assumptions** — Implement what's asked, not assumed
4. **Current Problem > Future Problems** — YAGNI wins

---

## Build & Test Commands

### Installation
```bash
make all              # Full setup
make help             # View all targets
make zsh              # ZSH only
make tmux             # Tmux only
make install-nvim     # Install Neovim (requires snap)
make neovim           # Neovim configuration
make kitty            # Kitty terminal
make asdf             # Universal version manager
```

### Validation
```bash
time zsh -ic exit            # Check ZSH startup (~110ms)
pre-commit run --all-files   # Run all linters
make -n help                 # Check Makefile syntax
nvim +Lazy                   # Inspect plugin loading
```

### Offline Verification
```bash
# Disconnect network, restart shell
exec zsh
# Completions should still work (cached)
# Plugins should still load (stored locally)
```

---

## Copilot Integration

### How GitHub Copilot Uses This

1. **On Session Start**
   - Loads this document + copilot-instructions.md
   - Extracts principles, conventions, constraints

2. **When You Ask for Help**
   - Applies all 6 principles to suggestions
   - References appropriate examples
   - Validates against constraints (110ms startup, offline, etc.)

3. **Code Review / Suggestion**
   - Checks implementation checklist
   - Suggests refactorings if principles violated
   - Explains WHY each suggestion follows principles

### What Copilot Will Do

✅ **Apply all principles** to every suggestion
✅ **Suggest refactorings** if code violates principles
✅ **Provide examples** for Shell, ZSH, Lua, Makefile
✅ **Explain WHY** each change follows methodology
✅ **Prevent over-engineering** (YAGNI enforcement)
✅ **Maintain standards** across all components

### Expected Response Style

**BEFORE (Generic):**
> "Here's a solution to your problem"

**AFTER (Methodology-Guided):**
> "Here's a solution following Clean Code (meaningful names), YAGNI (only what's needed), SOLID (single responsibility):
> - Names reveal intent → easier to understand
> - Functions do one thing → easier to test
> - Extensible without modification → easier to maintain
> - Avoids over-engineering → less technical debt"

---

## Implementation Checklist

**Before submitting ANY code, verify:**

### Clean Code ✓
- [ ] Names reveal intent (not abbreviated, not cryptic)
- [ ] Functions are <15 lines, do one thing
- [ ] Comments explain WHY, not WHAT
- [ ] Code reads like well-written prose

### DRY ✓
- [ ] No duplicated logic >2x
- [ ] Configuration centralized (single source of truth)
- [ ] Same values don't appear in multiple places

### YAGNI ✓
- [ ] Solves only the stated problem
- [ ] No "future-proofing" abstractions
- [ ] Fewest lines possible while remaining clear
- [ ] No unnecessary functions or indirection

### SOLID ✓
- [ ] One reason to change per function/module
- [ ] Open for extension without modification
- [ ] Abstractions instead of tight coupling
- [ ] Dependencies injected, not hardcoded

### KISS ✓
- [ ] Simple beats clever
- [ ] Fewest lines possible
- [ ] Clear to maintainers

---

## FAQ & Troubleshooting

### Q: Does YAGNI mean never prepare for future?
**A:** No. YAGNI means:
- Don't add features you think might be needed later
- DO solve the current problem well
- IF patterns repeat, refactor for reuse
- Prepare through clean code, not over-abstraction

### Q: Can Clean Code and KISS conflict?
**A:** No. Clean Code = meaningful names + small functions. KISS = simplicity. Both work together.
- Meaningful names make simple code clearer
- Small functions ARE simpler than large ones
- Simple abstraction (one task per function) is still simple

### Q: What if SOLID and YAGNI seem opposed?
**A:** SOLID is HOW to build. YAGNI is WHEN to build.
- Use SOLID when writing code (single responsibility, etc.)
- Use YAGNI for what code to write (don't build preemptively)
- Example: Design for extension (Open/Closed) but only when needed

### Q: How many lines is a "small function"?
**A:** Generally <15 lines. If you need nested ifs/loops or explaining complex logic, split it.

### Q: Do comments violate Clean Code?
**A:** No. Comments are required to explain WHY. Avoid comments that explain WHAT.

```zsh
# ✅ GOOD: Explains why
# Skip tmux in IDE because editors manage windows
if [[ $TMUX_SKIP_IDE == "true" ]]; then ...

# ❌ BAD: Explains what (code already shows)
# Check if IDE
if [[ $TMUX_SKIP_IDE == "true" ]]; then ...
```

### ZSH startup slow?
**Check:** Run `time zsh -ic exit`, profile with zprof
**Solutions:**
- Verify Zinit turbo mode enabled
- Check completions are lazy-loaded
- Remove unnecessary plugins
- Profile: Add `zmodload zsh/zprof` at top, `zprof` at bottom

### Makefile target fails?
**Check:** Run `make -n target` to see commands
**Solutions:**
- Verify conditional guards (`command -v`) work
- Test idempotence: `make target && make target`
- Check all required tools installed

### Plugin not loading in Neovim?
**Check:** Run `nvim +Lazy` to inspect state
**Solutions:**
- Verify lazy.nvim spec syntax
- Check plugin name is exactly `owner/repo`
- Verify dependencies are resolved
- Enable lazy = false if startup plugin

### Color theme inconsistent?
**Check:** Apply Drizzt palette consistently
**Solutions:**
- Verify all 16 colors defined in Kitty
- Use matching hex/xterm-256 codes in Tmux
- Confirm colorscheme active in Neovim
- Test in all three apps

---

## Key Files to Understand

| File | Purpose | When to Modify |
|------|---------|---|
| `zshrc` | Entry point | Rarely; core bootstrap |
| `Makefile` | Installation orchestrator | Adding install targets |
| `zsh.d/*.zsh` | ZSH modules | Adding aliases, completions |
| `config/tmux.conf` | Tmux settings | Keybindings, colors |
| `config/nvim/init.lua` | Neovim entry | Plugin manager setup |
| `config/nvim/lua/plugins/*.lua` | Neovim plugins | Adding/removing plugins |
| `config/nvim/lua/core/*.lua` | Neovim editor settings | Keymaps, options |
| `config/kitty.conf` | Terminal settings | Colors, fonts |

---

## Summary

**5 Mandatory Principles (NO EXCEPTIONS):**
1. KISS — Keep It Simple, Stupid
2. DRY — Don't Repeat Yourself
3. Clean Code — Meaningful names, small functions, self-documenting
4. YAGNI — No over-engineering
5. SOLID — Single Responsibility, Open/Closed, Liskov, Interface Segregation, Dependency Inversion

**For Every Copilot Session:**
- Read this file (reference relevant section)
- Check implementation checklist before submitting
- Ask Copilot: "Does this follow Clean Code / YAGNI / SOLID?"
- Reference examples when unsure

**For Code Review:**
- Verify all 6 principles applied
- Reference examples in this file
- Explain WHY principles matter
- Suggest refactorings if violated

---

**Status:** ✅ READY FOR PRODUCTION
**Updated:** 2026-02-17
**Standard:** GitHub Copilot 2026 Best Practices
**Enforcement:** MANDATORY (NO EXCEPTIONS)

All code in this repository follows these principles. There are no exceptions.
