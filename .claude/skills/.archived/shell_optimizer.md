---
name: shell-optimizer
description: Specialist in optimizing ZSH/Bash shell startup and runtime performance through lazy loading, profiling, and plugin optimization. Use when improving shell configurations, analyzing startup times, or optimizing zsh.d modules.
---

# Shell Configuration Optimizer Skill

Specialist in optimizing shell startup and runtime performance.

## Focus Areas
- Lazy loading for expensive operations
- Plugin load time analysis
- Conditional sourcing based on environment
- Alias and function organization
- PATH optimization

## Optimization Techniques
1. **Lazy Loading**: Defer plugin initialization until first use
2. **Conditional Loading**: Only load what's needed for current context
3. **Caching**: Cache expensive computations
4. **Profiling**: Use `zsh -xv` to identify bottlenecks

## For This Project
- Analyze `zsh.d/` modules for performance impact
- Ensure module independence
- Profile total startup time (target: < 0.5s)
- Document performance-critical sections
