# GitHub Copilot Configuration for Dotfiles (2026)

This directory contains the authoritative GitHub Copilot configuration for the cosckoya/.dotfiles project, optimized for 2026 best practices with token-efficient multi-agent setup.

## Structure

```
.copilot/
├── README.md                    # This file
├── agents.yaml                  # Agent definitions & configuration
├── instructions.md              # Comprehensive Copilot instructions
└── skills/                      # Domain expertise modules
    ├── shell-performance.md     # ZSH optimization (110ms target)
    ├── modern-makefile.md       # GNU Make 4.3+ patterns
    ├── lua-neovim.md           # Neovim 0.11+ Lua architecture
    ├── tmux-modern.md          # Tmux 3.4+ native features
    ├── git-precommit.md        # Pre-commit hooks & git workflow
    └── kitty-terminal.md       # Kitty 0.35+ configuration
```

## Quick Start

1. **Review** `instructions.md` - Master guide for Copilot behavior
2. **Check agents** in `agents.yaml` - See which agent handles what
3. **Reference skills** for implementation patterns by domain
4. **Validate** with project metrics (see below)

## Key Configurations

### Multi-Agent Setup

| Agent | Priority | Specialty | Default Model |
|-------|----------|-----------|---|
| **dotfiles-optimizer** | 100 | Full-stack dotfiles, Makefile, ZSH | Sonnet 4.1 |
| **shell-performance-expert** | 85 | ZSH startup, lazy-loading | Sonnet 4.1 |
| **neovim-architect** | 80 | Lua config, plugins, LSP | Sonnet 4.1 |
| **makefile-master** | 75 | Build automation, installation | Sonnet 4.1 |

### Model Strategy (Token-Optimized)

```
Complex task    → Opus 4.1   (200k context, most capable)
Standard task   → Sonnet 4.1 (100k context, balanced)
Quick fix       → Haiku 4.1  (90k context, lowest tokens)
```

### Token Budget (2026 Standards)

- **Per response**: 6,000 tokens (conservative estimate)
- **Context window**: 100,000 tokens (Sonnet default)
- **Reserved for response**: 4,000 tokens
- **Available for context**: 96,000 tokens

## Skills Documentation

### 1. Shell Performance Optimization (`shell-performance.md`)
**Purpose**: Maintain 110ms ZSH startup time

Key patterns:
- Lazy-loading with Zinit turbo mode
- Self-removing completion wrappers
- Conditional path initialization
- Profile with `time zsh -ic exit`

Token cost: ~3,000 per invocation

### 2. Modern Makefile Design (`modern-makefile.md`)
**Purpose**: Idempotent, maintainable installation targets

Key patterns:
- Safe directory creation (`mkdir -p`)
- Conditional checks (`if ! grep -q`)
- Color-coded output (GREEN, YELLOW, RED)
- Variable-based configuration

Token cost: ~2,500 per invocation

### 3. Lua Neovim Architecture (`lua-neovim.md`)
**Purpose**: Modern Neovim 0.11+ configuration

Key patterns:
- Minimal init.lua (entry point only)
- lazy.nvim bootstrap with performance optimization
- Declarative plugin specs
- Native LSP integration

Token cost: ~4,000 per invocation

### 4. Tmux Modern Configuration (`tmux-modern.md`)
**Purpose**: Native Tmux 3.4+ without external dependencies

Key patterns:
- Platform-specific clipboard detection
- Vi-style keybindings
- Color scheme unification (Drizzt Do'Urden)
- Performance optimization (aggressive resize)

Token cost: ~2,800 per invocation

### 5. Git & Pre-Commit Expertise (`git-precommit.md`)
**Purpose**: Code quality automation and git workflow

Key patterns:
- Pre-commit hook configuration
- Graceful fallbacks for optional tools
- Security validation (private keys)
- File integrity checks

Token cost: ~2,200 per invocation

### 6. Kitty Terminal Mastery (`kitty-terminal.md`)
**Purpose**: GPU-accelerated terminal configuration

Key patterns:
- Nerd Font setup with ligatures
- 24-bit true color scheme
- Unified theme with ZSH/Tmux/Neovim
- Performance tuning (sync_to_monitor, repaint_delay)

Token cost: ~1,800 per invocation

## Unified Theme: Drizzt Do'Urden

All components use consistent color scheme inspired by the legendary drow ranger:

| Component | Color | Hex | 256 Code |
|-----------|-------|-----|----------|
| Background | Deep Cavern | #100814 | - |
| Foreground | Elf White | #e0dfe8 | - |
| Lavender (eyes) | Lavender | #b19cd9 | 141 |
| Icy Blue (Twinkle) | Ice Blue | #7ec8e3 | 117 |
| Drow Magic | Forest Green | #5ab897 | 78 |
| Magical Yellow | Golden | #f0c987 | 222 |
| Dark Red | Crimson | #c23b40 | 167 |
| Inactive Border | Cavern Stone | #4a5273 | - |

## Integration Points

### With ZSH (`zshrc` & `zsh.d/`)
- Colors for RPROMPT and left prompt
- Lazy-loading patterns for plugins
- Startup time profiling
- Completion optimization

### With Makefile
- Installation orchestration
- Color-coded output
- Idempotent targets
- Platform detection

### With Neovim (`config/nvim/`)
- Lua plugin management
- LSP configuration
- Statusline colors
- Keybinding organization

### With Tmux (`config/tmux.conf`)
- Color scheme matching
- Native clipboard integration
- Smart pane navigation
- Auto-start configuration

### With Pre-commit (`.pre-commit-config.yaml`)
- Security validation
- File integrity checks
- Optional hooks (checkmake)

## Usage Examples

### Ask Copilot About ZSH Optimization
```bash
gh copilot explain 'how to improve zsh startup time to 110ms'
```
→ Uses **shell-performance-expert** agent

### Create New Makefile Target
```bash
gh copilot suggest 'add idempotent target for installing kitty terminal'
```
→ Uses **makefile-master** agent

### Configure New Neovim Plugin
```bash
gh copilot explain 'how to add a new plugin to neovim with lazy.nvim'
```
→ Uses **neovim-architect** agent

### Troubleshoot Tmux Color
```bash
gh copilot suggest 'fix tmux status bar color to match zsh theme'
```
→ Uses **dotfiles-optimizer** agent

## Best Practices (2026 Standards)

### ✅ DO
- Ask Copilot before creating new files
- Profile ZSH startup after changes: `time zsh -ic exit`
- Use lazy-loading for non-essential plugins
- Guard all tool checks with `command -v`
- Maintain idempotent Makefile targets
- Keep responses concise (max 3 sentences explanation)

### ❌ DON'T
- Create files without Copilot approval
- Break 110ms ZSH startup target
- Add external dependencies without justification
- Ignore backward compatibility
- Leave commented-out code
- Use verbose tool output (pipe to `grep`, use `--quiet`)

## Validation Checklist

After any change, verify:

- [ ] ZSH startup still ~110ms: `time zsh -ic exit`
- [ ] Makefile targets are idempotent: run twice, same result
- [ ] All tools guarded with `command -v` (or path checks)
- [ ] No hardcoded paths (use variables)
- [ ] Color scheme consistent across ZSH/Tmux/Kitty/Neovim
- [ ] No verbose output in scripts
- [ ] Pre-commit hooks pass: `pre-commit run --all-files`
- [ ] No external runtime dependencies

## Token Optimization Tips

### Reducing Token Usage

1. **Suppress verbose output**
   ```bash
   # Good: quiet output
   command --quiet

   # Bad: verbose default
   command  # outputs many lines
   ```

2. **Use efficient tools**
   ```bash
   # Good: ripgrep (faster, smaller output)
   grep pattern file

   # Bad: shell globbing (slow, verbose)
   for file in *; do grep pattern "$file"; done
   ```

3. **Batch operations**
   ```bash
   # Good: chain with &&
   cmd1 && cmd2 && cmd3

   # Bad: separate calls
   cmd1; cmd2; cmd3
   ```

4. **Concise responses**
   ```
   # Good: 1-3 sentence explanation + code
   "Added lazy-loading to kubectl completion using self-removing wrapper pattern."

   # Bad: verbose explanation with examples
   "I've analyzed the ZSH configuration and I think we should..."
   ```

## Common Patterns (Reference)

### ZSH Lazy-Load
```zsh
_lazy_tool() {
  source <(tool completion zsh)
  unfunction _lazy_tool
}
compdef _lazy_tool tool
```

### Makefile Idempotent Target
```makefile
.PHONY: install
install: ## Install everything
	@mkdir -p $(INSTALL_DIR)
	@cp config/* $(INSTALL_DIR)/ || true
	@echo "$(GREEN)✓$(NC) Installed"
```

### Neovim Plugin Spec
```lua
return {
  {
    "owner/plugin",
    lazy = true,
    cmd = "Command",
    config = function() end,
  },
}
```

### Tmux Binding (Safe)
```tmux
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
```

## Troubleshooting

### Copilot Creating Files Unexpectedly
**Solution**: Review instructions.md, agents have `max_file_creation: 0`

### Token Usage Too High
**Solution**: Use `--quiet` flags, batch commands, keep context minimal

### ZSH Startup Slow After Change
**Solution**: Profile with `time zsh -ic exit`, check for synchronous loading

### Color Mismatch Across Tools
**Solution**: Reference Drizzt Do'Urden table above, verify hex values

### Makefile Target Not Idempotent
**Solution**: Add guards (`if ! grep -q`), use `mkdir -p`, `|| true`

## Documentation References

- **Main**: `../CLAUDE.md` - Original architecture documentation
- **Instructions**: `instructions.md` - Authoritative Copilot behavior guide
- **Skills**: Each skill document has examples and best practices
- **Agents**: `agents.yaml` - Agent configuration and model selection

## Version & Standards

- **Date**: February 17, 2026
- **Copilot Version**: 2026 Standards (Claude Sonnet 4.1 default)
- **ZSH Target**: ~110ms startup (92% faster than baseline)
- **Tmux Version**: 3.4+
- **Neovim Version**: 0.11+
- **Kitty Version**: 0.35+

## Support & Maintenance

### Updating Skills
Edit skill files in `skills/` directory, add examples, update best practices as they evolve.

### Adding New Agents
Extend `agents.yaml` following existing agent pattern:
1. Define agent with priority and models
2. Set capabilities and tools
3. Configure context window and token budget
4. Document in instructions.md

### Validating Configuration
```bash
# Check YAML syntax
yamllint .copilot/agents.yaml

# Verify markdown links
# (manual check for now)

# Test Copilot invocation
gh copilot explain 'show me the current agents'
```

---

**Created**: February 17, 2026
**Purpose**: Token-optimized GitHub Copilot configuration for production dotfiles
**Status**: Production Ready
