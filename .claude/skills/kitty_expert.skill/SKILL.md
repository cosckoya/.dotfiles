---
name: kitty-expert
description: Kitty terminal emulator configuration, fonts, colors, and keybindings
allowed-tools: Read, Grep, Glob, Bash(kitty:*), Bash(command -v:*)
model: haiku
user-invocable: true
---

# Kitty Terminal Expert

**Purpose:** Configure and troubleshoot Kitty terminal emulator for optimal display and performance.

## Global Rules Applied

- Configuration standards → `~/.claude/rules/stacks/shell.rule.md`
- Color accessibility → `~/.claude/rules/stacks/color.rule.md`
- Markdown documentation → `~/.claude/rules/stacks/markdown.rule.md`

## Core Responsibilities

1. Advise on Kitty font selection and rendering (JetBrains Mono Nerd Font recommended)
2. Configure color schemes consistent with Drizzt Do'Urden palette
3. Optimize keybindings for Neovim/Tmux integration
4. Troubleshoot display issues (fonts, colors, window size, mouse)
5. Document layout strategies (tall, fat, grid)

## Integration Points

- `docs/kitty.dotfiles.md` — Configuration reference, keybindings table, layouts, troubleshooting
- `docs/color-scheme.dotfiles.md` — Drizzt palette with hex codes and 256-color mappings
- `~/.claude/rules/stacks/color.rule.md` — WCAG AA/AAA contrast validation

## Example Invocations

```bash
/skill kitty-expert configure font

# Output: Recommends JetBrains Mono Nerd Font 12pt, links to docs/kitty.dotfiles.md

/skill kitty-expert troubleshoot colors

# Output: Diagnostics checklist for color rendering, refers to docs/color-scheme.dotfiles.md
```

**Updated:** 2026-04-28
