# Shell Rule — Mandatory Conventions

Applied to all ZSH/Bash work in this project. Never violated.

## ZSH Startup Performance
- Hard target: under 110ms (`time zsh -ic exit`)
- Profile every change: `zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20`

## Tool Checks
- Always use `command -v`, never `which`
```zsh
if command -v tool >/dev/null 2>&1; then
  # tool-specific code
else
  # fallback
fi
```

## PATH Additions
- Use directory existence checks, not tool lookups
```zsh
[[ -d ~/bin ]] && path=(~/bin $path)
```

## Lazy-Loading
- Self-removing completion wrapper functions
```zsh
_load_tool_completion() {
  source <(tool completion zsh)
  unfunction _load_tool_completion
}
compdef _load_tool_completion tool
```

## Indentation
- 2-space, no tabs

## Comments
- One-line only for non-obvious logic. Explain *why*, not *what*.
- No commented-out code (delete it; git preserves history)

## Testing
- Profile every ZSH change
- Validate Makefile: `make -n help`
- Run pre-commit: `pre-commit run --all-files`
