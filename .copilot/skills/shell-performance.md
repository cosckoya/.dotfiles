---
name: shell-performance-optimization
description: "ZSH startup optimization from ~400ms to 110ms. Master lazy-loading, Zinit turbo mode, and startup profiling."
category: shell-optimization
priority: 90
token_cost_estimate: 3000  # Average tokens per skill invocation
---

# Shell Performance Optimization Skill

## Problem Domain
Optimizing shell startup from 400ms+ baseline to 110ms target while maintaining feature parity.

## 2026 Best Practices

### 1. Startup Profiling
```bash
# Profile with zsh built-in timing
time zsh -i -c exit

# Deep analysis with zprof
zsh -c 'zmodule load zsh/zprof; zprof' -i -c exit
```

### 2. Lazy-Loading Strategy (Modern)
- **Zinit turbo mode**: `wait"1"`, `wait"2"`, `wait"3"` for staggered loading
- **Self-removing wrappers**: Load completions on first use, then undefine wrapper
- **Command-specific loading**: Only load when tool is invoked

### 3. Compinit Optimization
```zsh
# Cache with -C flag (skip security check in trusted environments)
autoload -Uz compinit
if [[ -f ~/.zcompdump(Nmh+24) ]]; then
  compinit -C
else
  compinit
fi
```

### 4. Plugin Architecture
- **Minimum viable plugins**: Only essential plugins (syntax-highlight, autosuggest)
- **Conditional loading**: Check `command -v` before loading heavy plugins
- **Batch loading**: Use Zinit's batch syntax for related plugins

### 5. Path & Environment
- Use `[[ -d $path ]]` for path checks (faster than `test -d`)
- Initialize PATH conditionally (only if directories exist)
- Use typeset for variable caching

## Implementation Patterns

### Self-Removing Completion Loader
```zsh
_lazy_kubectl() {
  source <(kubectl completion zsh)
  compdef _kubectl kubectl
  unfunction _lazy_kubectl
}
compdef _lazy_kubectl kubectl
```

### Batch Plugin Loading (Zinit)
```zsh
zinit wait"1" lucid \
  atload"HIST_STAMPS='yyyy-mm-dd'" \
  for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting
```

## Verification
- Target: 110ms startup (measured with `time zsh -ic exit`)
- Baseline: <50ms for non-interactive shell
- Interactive: <150ms acceptable for dev work
- Production: <100ms ideal for CI/CD

## Anti-Patterns
- Loading all completions at startup
- Multiple compinit runs
- Synchronous plugin loading for non-essential tools
- Checking for tools that don't exist in PATH
- Hardcoding paths instead of checking existence

## Integration Points
- Works with `.zsh.d/` modular structure
- Compatible with `zshrc` orchestration
- Supports both Zinit and Oh-My-Zsh frameworks
- Backward compatible with system zsh
