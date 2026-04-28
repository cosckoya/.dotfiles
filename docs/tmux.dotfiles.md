# Tmux Configuration

Native tmux 3.4+ syntax. No external plugins or TPM. 238 lines. Symlinked from `config/tmux.conf` to `~/.tmux.conf`.

Reload config live without restarting:

```bash
tmux source ~/.tmux.conf
```

Or from inside tmux: `prefix + r`

## General Settings

| Setting | Value | Purpose |
|---------|-------|---------|
| `default-terminal` | `tmux-256color` | 256-color base |
| `escape-time` | `10ms` | Faster key sequences |
| `base-index` | `1` | Windows start at 1, not 0 |
| `aggressive-resize` | `on` | Resize to smallest active client |
| `status-interval` | `10s` | Status bar refresh rate |
| `mouse` | `on` | Full mouse support (click, select, scroll) |

## Key Bindings

Prefix is `Ctrl+b` (default).

| Binding | Action |
|---------|--------|
| `prefix + r` | Reload config |
| `prefix + e` | Edit config in `$EDITOR` |
| `prefix + -` | Split horizontal (retain path) |
| `prefix + _` | Split vertical (retain path) |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + >` / `<` | Swap panes down/up |
| `prefix + C-h/l` | Previous/next window |
| `prefix + Tab` | Last window |
| `prefix + m` | Toggle mouse |
| `prefix + Enter` | Enter copy mode |

### No-prefix pane navigation

Quick pane switching without pressing prefix:

```
Ctrl+h   left pane
Ctrl+j   down pane
Ctrl+k   up pane
Ctrl+l   right pane
```

## Copy Mode (Vi-style)

Enter copy mode: `prefix + Enter`

| Binding | Action |
|---------|--------|
| `v` | Begin selection |
| `y` | Copy and exit copy mode |
| `Escape` | Cancel |
| `C-u` / `C-d` | Half-page up/down |
| `/` / `?` | Search forward/backward |

Copied text goes to system clipboard automatically (detected: `xclip`, `xsel`, `wl-copy`, `pbcopy`).

## Color Scheme

Base colors map to Drizzt Do'Urden palette. See [Color Scheme](./color-scheme.dotfiles.md) for hex values and lore.

| Element | Color | Use |
|---------|-------|-----|
| Active pane border | Lavender | Current pane |
| Inactive pane border | Cavern stone | Other panes |
| Active window | Lavender background | Current window in status bar |
| Status bar | Deep cavern background | Bottom bar |

## Status Bar

Left: Fox icon + session name (hidden if named `default`)

Right: `PREFIX` indicator (yellow when active) + time (`HH:MM`) + user (yellow) + hostname (lavender)

## Session Management

```bash
tmux list-sessions              # list all sessions
tmux new-session -s dev         # create new session
tmux attach-session -t dev      # attach to session
tmux kill-session -t dev        # kill session

# From inside tmux:
prefix + C-c                    # new session
prefix + C-f                    # find session
prefix + BTab                   # switch to last session
```

## Buffer Management

```bash
prefix + b          list buffers
prefix + p          paste buffer
prefix + P          choose buffer
```

## Troubleshooting

**Clipboard not working?**
Install one of: `xclip`, `xsel` (X11), `wl-copy` (Wayland), `pbcopy` (macOS).

**Colors look wrong?**
Ensure `$TERM` is set correctly:
```bash
echo $TERM                      # should output tmux-256color
```

**Keys not working?**
Enable extended keys (tmux 3.2+):
```
set -g extended-keys on
```
