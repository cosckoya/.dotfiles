# Tmux Configuration

This directory contains the tmux configuration files for self-contained setup.

## Files

### `tmux.conf`
The base tmux configuration from [Oh my tmux!](https://github.com/gpakosz/.tmux)

**Source:** https://github.com/gpakosz/.tmux
**License:** Dual-licensed under WTFPL v2 and MIT
**Author:** Gregory Pakosz (@gpakosz)
**Version:** Master branch (snapshot taken: 2025-11-04)

**Features:**
- 🎨 Powerline-like theme
- ⌨️ Vim-like bindings
- 📋 Enhanced copy mode
- 🖥️ Status bar with system info
- 🔋 Battery indicator
- ⏱️ Uptime display
- 🎯 Mouse support

### `tmux.local`
Your local customizations and overrides.

This file contains:
- Custom color scheme
- Status bar configuration
- Window/pane styling
- Keybindings preferences
- Battery and system indicators

## Installation

The Makefile handles installation automatically:

```bash
make tmux -C profile
```

This will:
1. Symlink `tmux.conf` to `~/.tmux.conf`
2. Symlink `tmux.local` to `~/.tmux.conf.local`

## Self-Contained Design

✅ **No internet required** - All files are in the repository
✅ **Version controlled** - Track changes to configuration
✅ **Offline friendly** - Works without network access
✅ **Reproducible** - Same config on all machines

## Customization

To customize your tmux setup:

1. **Edit** `tmux.local` for personal preferences
2. **Don't modify** `tmux.conf` (it's upstream config)
3. **Reload** tmux: `Ctrl+b` then `r`

## Upstream Updates

To update the base configuration from upstream:

```bash
# Download latest version
curl -o profile/tmux.conf https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf

# Commit the update
git add profile/tmux.conf
git commit -m "Update tmux.conf from upstream"
```

## Key Bindings

See the [Oh my tmux! documentation](https://github.com/gpakosz/.tmux#bindings) for complete keybindings.

### Quick Reference

| Keybinding | Action |
|------------|--------|
| `Ctrl+b` or `Ctrl+a` | Prefix |
| `Prefix` + `r` | Reload config |
| `Prefix` + `e` | Edit local config |
| `Prefix` + `c` | New window |
| `Prefix` + `-` | Split pane horizontally |
| `Prefix` + `_` | Split pane vertically |
| `Prefix` + `h/j/k/l` | Navigate panes (vim-style) |
| `Prefix` + `<` / `>` | Move window left/right |
| `Prefix` + `C-c` | New session |
| `Prefix` + `C-f` | Find session |

## Troubleshooting

### Colors not working
Make sure your terminal supports 256 colors:
```bash
echo $TERM
# Should be: screen-256color or tmux-256color
```

### Config not loading
Reload tmux configuration:
```bash
tmux source-file ~/.tmux.conf
```

Or within tmux: `Prefix` + `r`

### Powerline symbols not showing
Install a [Nerd Font](https://www.nerdfonts.com/) or [Powerline fonts](https://github.com/powerline/fonts).

## Integration

This tmux configuration is integrated with:
- ✅ ZSH (auto-start via `profile/zshrc`)
- ✅ Profile Makefile (automated setup)
- ✅ Configuration system (`profile/zsh.d/config.zsh`)

See `TMUX_INTEGRATION.md` for ZSH integration details.

## License

### tmux.conf
Dual-licensed under:
- WTFPL v2 License
- MIT License

Copyright 2012— Gregory Pakosz (@gpakosz)

### tmux.local
Your customizations - Your license choice

## Resources

- [Oh my tmux! GitHub](https://github.com/gpakosz/.tmux)
- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [TMUX_INTEGRATION.md](./TMUX_INTEGRATION.md) - Auto-start integration
