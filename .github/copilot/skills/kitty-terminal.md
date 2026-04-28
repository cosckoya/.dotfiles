---
name: kitty-terminal-mastery
description: "Kitty 0.35+ configuration expert. Modern GPU-accelerated terminal, font management, color schemes, and productivity features."
category: terminal-configuration
priority: 75
token_cost_estimate: 1800
---

# Kitty Terminal Configuration (2026)

## Kitty 0.35+ Architecture

### 1. Core Philosophy
- **GPU-accelerated rendering**: True color, true transparency
- **Ligatures support**: Modern font rendering
- **Native image protocol**: Display images in terminal
- **Configurable via config**: No external themes needed
- **Cross-platform**: macOS, Linux (primary), Windows (WSL)

### 2. Essential Configuration
```ini
# kitty.conf

# Fonts (Nerd Font recommended)
font_family      FiraCode Nerd Font
bold_font        FiraCode Nerd Font Bold
italic_font      FiraCode Nerd Font Italic
bold_italic_font FiraCode Nerd Font Bold Italic
font_size        12

# Enable ligatures
disable_ligatures never

# Window
remember_window_size  yes
initial_window_width  120
initial_window_height 40
```

### 3. Drizzt Do'Urden Color Scheme
```ini
# Background & Foreground (unified with ZSH/Tmux)
background  #100814
foreground  #e0dfe8

# Standard colors (256-color palette equivalent)
color0      #3d4466  # Black (inactive border)
color1      #d16b6b  # Red
color2      #5ab897  # Green (drow magic)
color3      #f0c987  # Yellow
color4      #7ec8e3  # Blue (icy blue - Twinkle)
color5      #b19cd9  # Magenta (lavender)
color6      #7dd3c0  # Cyan
color7      #e0dfe8  # White

# Bright colors
color8      #4a5273  # Bright Black
color9      #e88a8a  # Bright Red
color10     #78d4a8  # Bright Green
color11     #f5d4a0  # Bright Yellow
color12     #9ad4e7  # Bright Blue
color13     #c9a0d4  # Bright Magenta
color14     #a0dcd4  # Bright Cyan
color15     #ffffff  # Bright White

# Cursor & Selection
cursor          #b19cd9
cursor_text_color background
selection_background #b19cd9
selection_foreground #100814
```

### 4. Keybindings (Productivity)
```ini
# Kitty-specific bindings (not using Tmux equivalents)
# Map to unused keys to avoid conflicts

# Window management
map ctrl+alt+n new_window
map ctrl+alt+t new_tab
map ctrl+alt+h previous_window
map ctrl+alt+l next_window

# Copy-paste (already Ctrl+Shift+C/V by default)
# Can customize if needed:
# map ctrl+shift+c copy_to_clipboard
# map ctrl+shift+v paste_from_clipboard

# Scrollback
map ctrl+shift+page_up scroll_page_up
map ctrl+shift+page_down scroll_page_down

# Font size
map ctrl+equal change_font_size all +1.0
map ctrl+minus change_font_size all -1.0
map ctrl+0 change_font_size all 0
```

### 5. Advanced Features
```ini
# Tab configuration
tab_bar_edge bottom
tab_bar_style powerline
tab_powerline_style angled
tab_title_template "{title}{' :pane_count' if pane_count > 1 else ''}"

# Mouse behavior
mouse_hide_wait 3.0
focus_follows_mouse yes

# Scrollback
scrollback_lines 10000
scrollback_pager less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER

# Image protocol (for previews in neovim)
allow_remote_control yes
listen_on unix:/run/user/1000/kitty
```

### 6. Terminal Bell & Notifications
```ini
# Visual bell instead of audio
visual_bell_duration 0.0  # Disable visual bell
enable_audio_bell no

# OS notifications
notify_on_cmd_finish always
```

### 7. Performance Optimization
```ini
# Rendering
sync_to_monitor yes
repaint_delay 10
input_delay 3

# Disable expensive features if not needed
disable_ligatures never  # But can be 'cursor' for performance
```

## 2026 Best Practices

### Font Selection
- **Nerd Fonts**: Full icon support
- **Monospace only**: No proportional fonts
- **Testing**: `kitty @ list-fonts` to see installed fonts
- **Fallback chain**: Primary font → Nerd Font → Monospace

### Color Management
- **24-bit true color**: Kitty supports full RGB
- **Consistent scheme**: Match with ZSH, Tmux, Neovim
- **Contrast ratios**: WCAG AAA for accessibility
- **Light/Dark mode**: Define both for flexibility

### Productivity Features
- **Tab organization**: Use tabs for related tasks
- **Window splitting**: Less important (use Tmux instead)
- **Copy/paste**: Native system clipboard integration
- **Scrollback**: 10000 lines balances speed and history

### Performance
- **GPU acceleration**: Enabled by default (fast)
- **Sync to monitor**: Best experience (smooth scrolling)
- **Repaint delay**: 10ms optimal balance
- **Remote control**: Optional, can be disabled

## Integration with Dotfiles

### Unified Theme (Drizzt Do'Urden)
```
ZSH (colors 256)     → Kitty (24-bit RGB)
Tmux (colors 256)    → Kitty (24-bit RGB)
Neovim (colors 256)  → Kitty (24-bit RGB)
```

All components use same base colors:
- Background: #100814
- Foreground: #e0dfe8
- Primary accent: #b19cd9 (lavender)

### Configuration Path
- Location: `config/kitty.conf`
- Symlinked to: `~/.config/kitty/kitty.conf`
- Installation via: `make kitty` target

### Testing
```bash
# View current kitty configuration
kitty @ get-config

# Test color rendering
kitty @ set-colors -a /path/to/color-scheme

# List available fonts
kitty @ list-fonts

# Reload configuration
kitty @ load-config-file
```

## Anti-Patterns to Avoid

- ❌ Using proportional fonts (causes alignment issues)
- ❌ Disabling GPU acceleration (defeats purpose)
- ❌ Inconsistent colors with shell/editor
- ❌ Excessive font size changes
- ❌ Remote control exposed on network
- ❌ Scrollback too large (memory impact)
- ❌ Audio bell enabled (annoying in dev environments)

## Migration from Other Terminals

### From iTerm2
```bash
# iTerm profiles → Kitty config
# Colors: Similar format but RGB values needed
# Fonts: Must be monospace Nerd Fonts
# Keybindings: May differ, requires remapping
```

### From Alacritty
```bash
# Alacritty YAML → Kitty config
# Colors: RGB values compatible
# Fonts: Same Nerd Font setup
# Keybindings: Similar model
```

### Performance Comparison
- **Kitty**: Fastest (GPU-accelerated)
- **Alacritty**: Fast (OpenGL)
- **iTerm2**: Moderate (limited GPU)
- **GNOME Terminal**: Slowest (CPU-only)
