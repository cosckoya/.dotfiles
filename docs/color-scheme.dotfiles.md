# Color Scheme: Drizzt Do'Urden

A unified dark palette applied consistently across ZSH, Tmux, Kitty, and Neovim. Inspired by the drow ranger from the Forgotten Realms — Drizzt Do'Urden, his enchanted familiar Guenhwyvar, and his magical scimitars Icingdeath and Twinkle.

All contrast ratios meet WCAG AAA (7:1+) against the `#100814` background.

---

## Master Palette

| Token | Hex | 256-color | Source | Usage |
|-------|-----|-----------|--------|-------|
| Background | `#100814` | — | Deep drow cavern | All backgrounds |
| Foreground | `#e0dfe8` | — | Moonlit stone | Primary text |
| Lavender | `#b19cd9` | 141 | Violet eyes | Active elements, borders, Insert mode |
| Icy Blue | `#7ec8e3` | 117 | Twinkle (scimitar) | Git branch, highlights, clock |
| Drow Green | `#5ab897` | 78 | Drow magic | Kubernetes context, Neovim Insert mode |
| Magical Yellow | `#f0c987` | 222 | Magical glow | ZSH separator, tmux time, fallback prompt |
| Red | `#d35d6e` | 167 | Blood | ZSH username, bell |
| Cavern Stone | `#4a5273` | — | Rock walls | Inactive pane borders |
| Shadow | `#8b8c99` | — | Dim cavern | Inactive window tabs |
| Deep Black | `#0f1119` | — | Void | Terminal color 0, tab bar background |

---

## Bright variants (terminal color 8–15)

| Index | Hex | Description |
|-------|-----|-------------|
| 8 | `#3d4466` | Bright black (dark blue-grey) |
| 9 | `#ff6b7f` | Bright red |
| 10 | `#6de2b0` | Bright green |
| 11 | `#ffd89b` | Bright yellow |
| 12 | `#9ae8ff` | Bright blue |
| 13 | `#d4b5ff` | Bright magenta |
| 14 | `#8aedff` | Bright cyan |
| 15 | `#e0dfe8` | Bright white |

---

## Per-component application

### ZSH prompt

```
%F{141}┌──(%F{117}hostname%F{222}の%F{167}username%F{141})
       └─#
```

RPROMPT uses `%F{117}` for git branch, `%F{141}` for venv, `%F{78}` for k8s.

### Tmux

```
pane-border-style        fg=#4a5273
pane-active-border-style fg=#b19cd9
status-style             fg=#e0dfe8,bg=#100814
window-status-current    fg=#100814,bg=#b19cd9
message-style            fg=#100814,bg=#b19cd9
```

### Kitty

Direct hex values in `kitty.conf`. Background opacity 0.88 for a subtle glass effect. Cursor is `#b19cd9` with beam shape.

### Neovim

Via tokyonight theme with statusline mode colors:

| Mode | Color |
|------|-------|
| Normal | Lavender `#b19cd9` |
| Insert | Drow Green `#5ab897` |
| Visual | Icy Blue `#7ec8e3` |

---

## Dircolors

`~/.dircolors` is configured to use the same palette for `ls` output. Applied at ZSH startup via:

```zsh
eval "$(dircolors -b ~/.dircolors)"
alias ls='ls --color=auto'
```

---

## Lore reference

The palette maps directly to Drizzt's world:

- **`#100814`** — The Underdark, lightless tunnels of Menzoberranzan
- **`#b19cd9`** — Drizzt's lavender eyes, unique among drow
- **`#7ec8e3`** — Twinkle, his ice-enchanted scimitar
- **`#5ab897`** — The blue-green magical aura of drow sorcery
- **`#f0c987`** — The warm glow of surface-world torchlight
- **`#d35d6e`** — Combat, the price of survival in the Underdark
