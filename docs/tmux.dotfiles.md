# Tmux Configuration

Native tmux 3.4+ configuration. No external plugins or TPM. 238 lines. Unified Drizzt Do'Urden color scheme.

**File:** `config/tmux.conf` → symlinked to `~/.tmux.conf`

---

## General Settings

| Setting | Value | Effect |
|---------|-------|--------|
| `default-terminal` | `tmux-256color` | 256-color base |
| `terminal-features` | `xterm-256color:RGB`, `kitty*:RGB:hyperlinks` | True color + Kitty hyperlinks |
| `extended-keys` | `on` | Modifier keys (C-Up, M-PageUp, etc.) |
| `set-clipboard` | `on` | OSC 52 clipboard in SSH sessions |
| `allow-passthrough` | `on` | Kitty protocols and OSC 8 hyperlinks |
| `escape-time` | `10ms` | Faster key sequence resolution |
| `repeat-time` | `600ms` | Repeat timeout for `-r` bindings |
| `aggressive-resize` | `on` | Resize to smallest active client |

---

## Window and Pane Display

| Setting | Value |
|---------|-------|
| `base-index` | 1 (windows start at 1, not 0) |
| `pane-base-index` | 1 |
| `automatic-rename` | on (uses `#{b:pane_current_path}`) |
| `renumber-windows` | on |
| `pane-border-status` | top (pane title visible) |
| `pane-border-indicators` | both |
| `status-interval` | 10 seconds |

---

## Color Scheme

| Element | Hex | Role |
|---------|-----|------|
| Background / status bar bg | `#100814` | Deep drow cavern |
| Active pane border | `#b19cd9` | Lavender (violet eyes) |
| Inactive pane border | `#4a5273` | Cavern stone |
| Active window tab | `#b19cd9` bg, `#100814` fg | Lavender glow |
| Inactive window tab | `#100814` bg, `#8b8c99` fg | Shadow |
| Message bar | `#b19cd9` bg, `#100814` fg | Bold lavender |
| Copy mode highlight | `#b19cd9` bg, `#100814` fg | |
| Clock | `#7ec8e3` | Icy blue |
| Activity indicator | `#7ec8e3` underline | |
| Bell indicator | `#d35d6e` blink bold | |

---

## Status Bar

**Left:** Session name (fox indicator). Hidden if session is named `default`.

**Right:** `PREFIX` indicator (yellow when prefix active) + time (`%H:%M`) + `whoami` (yellow) + hostname (lavender).

```
#{?client_prefix,PREFIX ,}HH:MM | user @ host
```

---

## Key Bindings

### Prefix: `Ctrl+b` (default)

| Binding | Action |
|---------|--------|
| `prefix + r` | Reload `~/.tmux.conf` |
| `prefix + e` | Edit `~/.tmux.conf` in `$EDITOR` |
| `prefix + C-c` | New session |
| `prefix + C-f` | Find session by name |
| `prefix + BTab` | Switch to last session |
| `prefix + -` | Split horizontal (retain path) |
| `prefix + _` | Split vertical (retain path) |
| `prefix + h/j/k/l` | Navigate panes (vim-style, repeatable) |
| `prefix + H/J/K/L` | Resize panes (repeatable) |
| `prefix + >` / `<` | Swap pane down/up |
| `prefix + C-h` / `C-l` | Previous/next window |
| `prefix + Tab` | Last window |
| `prefix + m` | Toggle mouse on/off |
| `prefix + Enter` | Enter copy mode |
| `prefix + b` | List buffers |
| `prefix + p` | Paste buffer |
| `prefix + P` | Choose buffer |

### No-prefix pane navigation

| Binding | Action |
|---------|--------|
| `C-h` | Select pane left |
| `C-j` | Select pane down |
| `C-k` | Select pane up |
| `C-l` | Select pane right |

---

## Copy Mode (vi)

`mode-keys vi` — all bindings follow vim conventions.

| Binding | Action |
|---------|--------|
| `v` | Begin selection |
| `C-v` | Rectangle toggle |
| `y` | Copy selection and cancel |
| `Escape` | Cancel |
| `H` | Start of line |
| `L` | End of line |
| `C-u` / `C-d` | Half-page up/down |
| `/` / `?` | Search forward/backward |

### Clipboard integration

Detected at runtime in order of preference:

1. `xclip` — X11 clipboard
2. `xsel` — X11 clipboard (alternative)
3. `wl-copy` — Wayland clipboard
4. `pbcopy` — macOS (fallback)

`y` and `MouseDragEnd1Pane` both pipe to whichever is found.

---

## Reload

```bash
tmux source ~/.tmux.conf        # live reload without restart
# or use prefix + r inside tmux
```
