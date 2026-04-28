# Kitty Terminal Configuration

GPU-accelerated terminal emulator configuration. Optimized for the Drizzt Do'Urden color scheme with JetBrains Mono Nerd Font and Wayland/X11 compatibility.

**File:** `config/kitty.conf` → symlinked to `~/.config/kitty/kitty.conf`

**Requires:** Kitty 0.32+

---

## Font

| Setting | Value |
|---------|-------|
| Family | JetBrains Mono Nerd Font |
| Size | 12.0pt |
| Ligatures | Enabled (`disable_ligatures never`) |
| Line height adjustment | +2 |

---

## Color Scheme: Drizzt Do'Urden

| Role | Hex |
|------|-----|
| Background | `#100814` |
| Foreground | `#e0dfe8` |
| Selection bg | `#6b4f9e` |
| Cursor | `#b19cd9` (lavender) |
| Cursor text | `#100814` |
| Background opacity | 0.88 (glass effect) |
| Dim opacity (unfocused) | 0.70 |

### 16-color palette

| Index | Name | Hex |
|-------|------|-----|
| 0 | Black | `#0f1119` |
| 1 | Red | `#d35d6e` |
| 2 | Green | `#5ab897` |
| 3 | Yellow | `#f0c987` |
| 4 | Blue | `#7ec8e3` |
| 5 | Magenta | `#b19cd9` |
| 6 | Cyan | `#66d9ef` |
| 7 | White | `#c0bfcc` |
| 8–15 | Bright variants | Lighter/more saturated |

---

## Cursor

| Setting | Value |
|---------|-------|
| Shape | `beam` |
| Beam thickness | 1.5px |
| Blink interval | 0.5s |
| Trail | Enabled (`decay 0.1 0.4`) |

---

## Window

| Setting | Value |
|---------|-------|
| Initial size | 140 × 40 |
| Padding | 4px all sides |
| Border width | 0 (borderless) |
| Decorations | None (Wayland compatible) |
| Active border | `#b19cd9` |
| Inactive border | `#3d4466` |
| Remember size | Yes |

---

## Tab Bar

Hidden until 999 tabs are open (effectively never shown). When visible: powerline slanted style, top edge.

---

## Scrollback

50,000 lines. Pager: `less --chop-long-lines --raw-control-chars`.

---

## Performance

| Setting | Value |
|---------|-------|
| `repaint_delay` | 8ms |
| `input_delay` | 2ms |
| `sync_to_monitor` | yes |

---

## Layouts

`tall`, `fat`, `grid`, `splits`

---

## Key Bindings

### Copy / Paste

| Binding | Action |
|---------|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |

### Window management

| Binding | Action |
|---------|--------|
| `F5` | Split horizontal (current dir) |
| `F6` | Split vertical (current dir) |
| `Ctrl+Shift+W` | Close window |
| `Ctrl+Shift+]` / `[` | Next/previous window |
| `Ctrl+Arrow` | Navigate to neighboring window |
| `Ctrl+Shift+Arrow` | Resize window |
| `Ctrl+Shift+L` | Next layout |
| `Ctrl+Shift+Enter` | New window (current dir) |

### Tabs

| Binding | Action |
|---------|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Q` | Close tab |
| `Alt+Left/Right` | Previous/next tab |
| `Ctrl+Shift+.` / `,` | Move tab forward/backward |
| `Ctrl+Shift+Alt+T` | Rename tab |

### Scrollback

| Binding | Action |
|---------|--------|
| `Ctrl+Shift+Up/Down` | Scroll line up/down |
| `Ctrl+Shift+PageUp/Down` | Scroll page up/down |
| `Ctrl+Shift+Home/End` | Scroll to top/bottom |

### System

| Binding | Action |
|---------|--------|
| `Ctrl+Shift+F5` | Reload config (no restart) |
| `Ctrl+Shift+F2` | Edit config in `$EDITOR` |
| `Ctrl+Shift+Escape` | Kitty shell |
| `Ctrl+Shift+U` | Unicode input |
| `Ctrl+Shift+E` | Open URL hints |
| `Ctrl+Shift+F11` | Toggle fullscreen |
| `Ctrl+Shift+=` / `-` / `0` | Font size up/down/reset |

---

## Remote control

`allow_remote_control yes` — Kitty can be controlled via `kitty @` commands from other processes.

## Shell integration

`shell_integration enabled` — marks prompt lines, enables `kitty +kitten ssh` and OSC integrations.
