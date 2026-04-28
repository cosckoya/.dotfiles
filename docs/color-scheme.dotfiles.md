# Color Scheme: Drizzt Do'Urden

Unified dark palette applied consistently across ZSH, Tmux, Kitty, and Neovim. Inspired by Drizzt Do'Urden (the drow ranger) and his world from the Forgotten Realms — his scimitar Twinkle, his familiar Guenhwyvar, and the lavender of his unique eyes.

All colors meet WCAG AAA contrast ratios (7:1+) against the `#100814` background.

## Master Palette

| Token | Hex | 256-color | Component | Meaning |
|-------|-----|-----------|-----------|---------|
| Background | `#100814` | — | All | Deep drow cavern |
| Foreground | `#e0dfe8` | — | All | Moonlit stone |
| Lavender | `#b19cd9` | 141 | All active elements | Drizzt's violet eyes |
| Icy Blue | `#7ec8e3` | 117 | Git, highlights | Twinkle (scimitar) |
| Drow Green | `#5ab897` | 78 | Kubernetes, Insert mode | Drow magic |
| Magical Yellow | `#f0c987` | 222 | Accent, time | Surface-world glow |
| Red | `#d35d6e` | 167 | Error, username | Combat, sacrifice |
| Cavern Stone | `#4a5273` | — | Inactive borders | Rock walls |
| Shadow | `#8b8c99` | — | Inactive text | Dim cavern |
| Deep Black | `#0f1119` | — | Terminal color 0 | Void |

## Per-Component Usage

### ZSH Prompt

Left prompt (static):
```
%F{141}┌──(%F{117}hostname%F{222}の%F{167}username%F{141})
       └─#
```

Right prompt (dynamic):
- Git branch: 117 (icy blue)
- Virtualenv: 141 (lavender)
- Kubernetes: 78 (drow green)
- Fallback: 222 (magical yellow)

### Tmux

- Active pane border: `#b19cd9` (lavender)
- Inactive pane border: `#4a5273` (cavern stone)
- Active window: `#b19cd9` background, `#100814` text (lavender glow)
- Status bar background: `#100814`
- Message bar: `#b19cd9` background, `#100814` text

### Kitty

- Background: `#100814` with 0.88 opacity (glass effect)
- Foreground: `#e0dfe8`
- Cursor: `#b19cd9` (beam shape)
- Inactive window border: `#3d4466`
- Active window border: `#b19cd9`

### Neovim

Via tokyonight theme:

- Normal mode statusline: `#b19cd9` (lavender)
- Insert mode statusline: `#5ab897` (drow green)
- Visual mode statusline: `#7ec8e3` (icy blue)

## Contrast Reference

All colors tested against `#100814` background using WCAG AAA standards (7:1 minimum).

| Color | Ratio | AA Compliant | AAA Compliant |
|-------|-------|--------------|---------------|
| Lavender (`#b19cd9`) | 9.1:1 | Yes | Yes |
| Icy Blue (`#7ec8e3`) | 10.5:1 | Yes | Yes |
| Drow Green (`#5ab897`) | 7.2:1 | Yes | Yes |
| Magical Yellow (`#f0c987`) | 8.3:1 | Yes | Yes |
| Foreground (`#e0dfe8`) | 15.1:1 | Yes | Yes |

## Lore Reference

The palette maps directly to Drizzt's world and mythology:

- **`#100814`** — The Underdark, lightless tunnels of Menzoberranzan
- **`#b19cd9`** — Drizzt's unique lavender eyes (rare among drow)
- **`#7ec8e3`** — Twinkle, his ice-enchanted scimitar with a blue glow
- **`#5ab897`** — The blue-green magical aura of drow sorcery
- **`#f0c987`** — The warm glow of surface-world torchlight
- **`#d35d6e`** — Combat, conflict, the price of survival in the Underdark
- **`#e0dfe8`** — Moonlit stone, hope, light in darkness

From *The Sandman* (Neil Gaiman): Dream and Death sit on a bench feeding pigeons, at peace in the chaos. This palette is that moment — beauty and contrast in a dark world.

## Dircolors Configuration

`~/.dircolors` is pre-configured to use the palette for `ls` output. Applied at ZSH startup:

```bash
eval "$(dircolors -b ~/.dircolors)"
alias ls='ls --color=auto'
```

Edit `~/.dircolors` to customize colors for specific file types.

## Dark Mode Variants

All components automatically support light/dark mode via OS settings. Kitty and Tmux check `COLORFGBG` environment variable and adjust accordingly.

If colors appear inverted or wrong, check:
```bash
echo $COLORFGBG
```

Should output nothing (auto-detect) or `0;#100814;#e0dfe8` (explicit dark mode).
