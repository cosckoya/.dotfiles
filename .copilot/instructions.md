# GitHub Copilot Instructions for Dotfiles Project (2026)

This document provides authoritative guidance for GitHub Copilot when working with the cosckoya/.dotfiles repository.

## Quick Reference

| Aspect | Standard | Notes |
|--------|----------|-------|
| **Startup Time** | ~110ms | Measured with `time zsh -ic exit` |
| **Model Default** | claude-sonnet-4-1 | Fast, token-efficient |
| **Max Response** | 3 sentences | Concise > elaborate |
| **File Creation** | Ask first | Never create without approval |
| **Token Budget** | 6000/response | Conservative estimate |
| **ZSH Indentation** | 2 spaces | Consistency matters |

## Agent Selection Matrix (2026)

### When to Use Each Agent

**dotfiles-optimizer** (Primary, Priority 100)
- Makefile changes
- ZSH configuration
- Cross-component changes
- Performance analysis
- File structure decisions

**shell-performance-expert** (Priority 85)
- Startup time issues
- Lazy-loading improvements
- Zinit configuration
- Completion optimization

**neovim-architect** (Priority 80)
- Lua configuration
- Plugin management
- LSP setup
- Keymap changes

**makefile-master** (Priority 75)
- Make target creation
- Installation logic
- Build system changes
- Dependency orchestration

## Token Optimization Rules (2026)

### Conservation Strategies
1. **Suppress verbose output**: Use `--quiet`, `--no-pager`, pipe to `grep`
2. **Batch operations**: Chain commands with `&&` instead of separate calls
3. **File size awareness**: Large files summarized, not fully read
4. **Tool efficiency**: Use `grep` for search, `glob` for patterns
5. **Context window**: Reserve 4000 tokens for response

### Response Style
- Maximum 3 sentences explanation
- One sentence per tool call explanation
- Code-first, explanation-second
- No redundant detail

## Code Quality Standards

### Shell (ZSH/Bash)
```zsh
# Use 2-space indentation
if [[ condition ]]; then
  command arg1 arg2
fi

# Guard all tool checks
if command -v tool >/dev/null; then
  # tool-specific code
fi

# Path checks faster than command checks
if [[ -d $path ]]; then
  export PATH="$path:$PATH"
fi
```

### Lua (Neovim)
```lua
-- Minimal init.lua (entry point only)
require("config.lazy")
require("core.options")

-- Plugin specs: explicit dependencies
return {
  {
    "owner/plugin",
    lazy = true,
    dependencies = { "other/plugin" },
    config = function() end,
  },
}
```

### Makefile
```makefile
# Idempotent targets
.PHONY: target
target: ## Description
	@mkdir -p $(DIR)
	@cp source dest || true
	@echo "$(GREEN)✓$(NC) Done"

# Use variables, not hardcoded paths
INSTALL_DIR := $(HOME)/.config
```

## Absolute Rules

### ✅ DO

1. **Read existing code first** - Understand patterns before suggesting changes
2. **Maintain 110ms startup** - Every ZSH change must be profiled
3. **Use conditional guards** - Check for tool existence with `command -v`
4. **Provide fallbacks** - Graceful degradation if tools missing
5. **Keep simple** - KISS principle: simplest solution wins
6. **Ask for approval** - File creation requires explicit user consent
7. **Batch edits** - Max 5 edits per response for same file
8. **Test offline** - No runtime external dependencies
9. **Document decisions** - Comment "why", not "what"
10. **Follow conventions** - Consistency across project

### ❌ DON'T

1. **Create files without asking** - Always propose first
2. **Add unnecessary complexity** - Every addition must justify itself
3. **Over-engineer** - Resist abstraction for single-use cases
4. **Ignore startup impact** - Profile after ZSH changes
5. **Remove working code** - Fix bugs, don't refactor unless asked
6. **Use external dependencies** - Self-contained is core principle
7. **Leave commented code** - Delete it
8. **Make breaking changes** - Maintain backward compatibility
9. **Hardcode paths** - Always use variables
10. **Propose untested solutions** - Verify locally first

## File Organization

### Critical Files (Touch Carefully)
```
zshrc              # Main entry point
Makefile           # Installation orchestrator
.pre-commit-config.yaml  # Code quality
```

### Modular Safe Files (Easy to Extend)
```
zsh.d/*.zsh        # Individual modules
config/nvim/lua/plugins/*.lua  # Plugin specs
config/nvim/lua/core/*.lua     # Core settings
```

### Config Files (Non-Breaking Changes)
```
config/tmux.conf
config/kitty.conf
config/nvim/init.lua
vimrc
```

## Testing Checklist

Before suggesting any change:

- [ ] Read related files first
- [ ] Identify simplest approach
- [ ] Check startup time impact (ZSH)
- [ ] Verify idempotency (Makefile)
- [ ] Test offline functionality
- [ ] Validate backward compatibility
- [ ] Check for side effects
- [ ] Consider whole system impact

## Documentation

### When to Update
- Architecture changes → Update CLAUDE.md
- New skills added → Document in .copilot/skills/
- Agent changes → Update agents.yaml
- Breaking changes → Explain in commit message

### What to Document
- **Why**: Design decisions
- **What**: Feature overview
- **How**: Implementation patterns
- **Where**: File locations

## 2026 Context Window Best Practices

### Model Selection by Task
- **Opus (200k tokens)**: Complex refactoring, architecture redesign
- **Sonnet (100k tokens)**: Default for all tasks (balanced)
- **Haiku (90k tokens)**: Quick fixes, file review, code search

### Context Management
- **Multi-turn history**: Preserved across turns
- **Exponential decay**: Older turns weighted less
- **Auto-summarization**: Above 80k tokens
- **File size limits**: Respected per agent config

### Efficient Prompting
```
Good: "Add lazy-loading to completion.zsh, keeping startup under 110ms"
Bad: "Can you help me optimize my ZSH config? It's slow and I'm not sure where to start..."

Good: "Create a new plugin spec for telescope with lazy-loading"
Bad: "Should I create a new file for telescope or add it to init.lua?"
```

## Integration with GitHub Copilot CLI

This project is optimized for `gh copilot` tool interaction:

```bash
# Ask about shell optimization
gh copilot explain 'zsh startup time'

# Get help with Makefile
gh copilot suggest 'create idempotent install target'

# Debug issue
gh copilot explain 'why does this lazy-loading pattern work'
```

## Performance Metrics (Target State)

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| ZSH startup | <110ms | ~110ms | ✅ |
| Tmux startup | <100ms | ~50ms | ✅ |
| Neovim startup | <500ms | ~300ms | ✅ |
| Token per response | <6000 | Variable | 🟡 |
| File creation requests | 0/change | 100% ask | ✅ |

## Common Patterns (Use These)

### Lazy-Load Completion
```zsh
_load_tool() {
  source <(tool completion zsh)
  unfunction _load_tool
  _load_tool
}
compdef _load_tool tool
```

### Conditional PATH Addition
```zsh
[[ -d ~/.local/bin ]] && PATH="~/.local/bin:$PATH"
```

### Safe Makefile Target
```makefile
.PHONY: target
target: ## Description
	@command -v git >/dev/null || (echo "git required"; exit 1)
	@mkdir -p $(DIR)
	@cp src dst || true
	@echo "$(GREEN)✓$(NC) Done"
```

### Plugin Spec (Lazy.nvim)
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

## Troubleshooting Guide

### Issue: ZSH Startup Slow
**Check**: Run `time zsh -ic exit`, profile with zprof
**Solution**: Look for heavy plugin, use lazy-loading, remove unnecessary completions

### Issue: Makefile Target Fails Idempotently
**Check**: Run target twice, should succeed both times
**Solution**: Add guards (`if ! grep -q`), use `mkdir -p`, add `|| true` for harmless errors

### Issue: Plugin Not Loading
**Check**: Lazy.nvim config, plugin spec syntax
**Solution**: Add explicit `lazy = false`, check dependencies, verify plugin name

### Issue: Color Scheme Mismatched
**Check**: Kitty, Tmux, Neovim configs
**Solution**: Use hex values #100814 (bg), #b19cd9 (lavender), #7ec8e3 (blue)

## When in Doubt

1. **Ask the user** - Better to clarify than assume
2. **Keep it simple** - Simplest solution wins
3. **Test locally** - Don't propose untested changes
4. **Read existing code** - Understand patterns first
5. **Respect constraints** - 110ms startup, offline, minimal deps
6. **Get approval** - For new files or major changes

---

**Last Updated**: February 17, 2026
**Standard**: GitHub Copilot 2026 Best Practices
**Model**: Claude Sonnet 4.1 (default)
