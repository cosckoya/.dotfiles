# Kitty Configuration

GPU-accelerated terminal emulator. Requires Kitty 0.32+. Symlinked from `config/kitty.conf` to `~/.config/kitty/kitty.conf`.

Reload config live: `Ctrl+Shift+F5`

## Display Settings

| Setting | Value |
|---------|-------|
| Font | JetBrains Mono Nerd Font, 12pt |
| Ligatures | Enabled |
| Cursor shape | Beam |
| Cursor blink | 0.5s interval |
| Window size | 140x40 characters |
| Window padding | 4px |
| Scrollback | 50,000 lines |
| Background opacity | 0.88 (glass effect) |

## Color Scheme

Drizzt Do'Urden dark palette. See [Color Scheme](./color-scheme.dotfiles.md) for hex values and contrast ratios.

Background: `#100814` (deep drow cavern)
Foreground: `#e0dfe8` (moonlit stone)

## Key Bindings

Mostly standard Ctrl+Shift combinations. Below are common customizations.

| Binding | Action |
|---------|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `F5` | Split horizontal |
| `F6` | Split vertical |
| `Ctrl+Shift+W` | Close window |
| `Ctrl+Arrow` | Navigate to neighboring window |
| `Ctrl+Shift+L` | Next layout |
| `Ctrl+Shift+T` | New tab |
| `Alt+Left/Right` | Previous/next tab |
| `Ctrl+Shift+F5` | Reload config |
| `Ctrl+Shift+F2` | Edit config in `$EDITOR` |
| `Ctrl+Shift+=` / `-` | Font size up/down |

## Layouts

Available layouts: `tall`, `fat`, `grid`, `splits`

Switch between layouts: `Ctrl+Shift+L`

## URL Handling

URLs are highlighted and clickable. Scheme detection is automatic.

```bash
Ctrl+Shift+E    # Open URL hints (select URL to open)
```

## Shell Integration

Enabled by default. Marks prompt lines and enables shell-specific features like `kitty +kitten ssh`.

## Troubleshooting

**Font not rendering correctly?**
Install JetBrains Mono Nerd Font:
```bash
sudo apt install fonts-jetbrains-mono fonts-nerd-font-jetbrains-mono
```

**Colors not showing?**
Verify true color support:
```bash
echo $COLORTERM           # should output truecolor or 24bit
```

**Mouse not working?**
Check if mouse support is enabled:
```
# In kitty.conf
mouse on
```

**Window too small/large?**
Edit `config/kitty.conf`:
```
initial_window_width  140
initial_window_height 40
```
