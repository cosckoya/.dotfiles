---
name: kitty-expert
description: Expert in Kitty terminal emulator configuration including keybindings, layouts, fonts, GPU acceleration, and advanced features like tabs, windows, and kittens. Use when configuring kitty.conf, optimizing terminal performance, or setting up terminal themes.
---

# Kitty Terminal Expert Skill

Specialist in Kitty terminal emulator configuration and optimization.

## Core Capabilities

### Configuration Mastery
- Complete `kitty.conf` setup and optimization
- Font configuration and rendering
- Color schemes and themes
- Window management and layouts
- Tab and window styling
- Keyboard shortcuts and mappings
- GPU acceleration tuning

### Advanced Features
- Kittens (terminal extensions)
- Remote control via socket
- Session management
- Unicode and ligature support
- Image display protocol
- Scrollback management
- Multiplexing with tmux integration

## Key Configuration Areas

### Fonts and Typography
```conf
# Font configuration
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        12.0

# Font features
disable_ligatures never
font_features    JetBrainsMonoNF-Regular +cv02 +cv03 +cv04 +ss02

# Adjustments
adjust_line_height  0
adjust_column_width 0
adjust_baseline     0

# Symbol mappings for better icon rendering
symbol_map U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols
```

### Color Schemes
```conf
# Theme: Gruvbox Dark
foreground            #ebdbb2
background            #282828
selection_foreground  #928374
selection_background  #ebdbb2
cursor                #ebdbb2
cursor_text_color     #282828

# Black
color0  #282828
color8  #928374

# Red
color1  #cc241d
color9  #fb4934

# Green
color2  #98971a
color10 #b8bb26

# Yellow
color3  #d79921
color11 #fabd2f

# Blue
color4  #458588
color12 #83a598

# Magenta
color5  #b16286
color13 #d3869b

# Cyan
color6  #689d6a
color14 #8ec07c

# White
color7  #a89984
color15 #ebdbb2

# Background opacity
background_opacity 0.95
dynamic_background_opacity yes
```

### Window Management
```conf
# Window layout
remember_window_size  yes
initial_window_width  640
initial_window_height 400

# Window padding
window_padding_width 4
window_margin_width  0
window_border_width  1pt

# Window styling
active_border_color     #83a598
inactive_border_color   #928374
bell_border_color       #fabd2f

# Window layouts
enabled_layouts splits,stack,tall,grid

# Hide window decorations
hide_window_decorations no
```

### Tab Bar Configuration
```conf
# Tab bar style
tab_bar_style powerline
tab_powerline_style slanted

# Tab bar positioning
tab_bar_edge top
tab_bar_margin_width 0.0
tab_bar_margin_height 0.0 0.0

# Tab colors
active_tab_foreground   #282828
active_tab_background   #83a598
active_tab_font_style   bold
inactive_tab_foreground #ebdbb2
inactive_tab_background #504945
inactive_tab_font_style normal

# Tab title template
tab_title_template "{index}: {title}"
```

### Keyboard Shortcuts
```conf
# Clipboard
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard
map ctrl+shift+s paste_from_selection

# Scrollback
map ctrl+shift+up        scroll_line_up
map ctrl+shift+down      scroll_line_down
map ctrl+shift+page_up   scroll_page_up
map ctrl+shift+page_down scroll_page_down
map ctrl+shift+home      scroll_home
map ctrl+shift+end       scroll_end
map ctrl+shift+h         show_scrollback

# Window management
map ctrl+shift+enter new_window_with_cwd
map ctrl+shift+w     close_window
map ctrl+shift+]     next_window
map ctrl+shift+[     previous_window
map ctrl+shift+f     move_window_forward
map ctrl+shift+b     move_window_backward

# Tab management
map ctrl+shift+t     new_tab_with_cwd
map ctrl+shift+q     close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left  previous_tab
map ctrl+shift+.     move_tab_forward
map ctrl+shift+,     move_tab_backward

# Layout management
map ctrl+shift+l next_layout
map ctrl+shift+z toggle_layout stack

# Font size
map ctrl+shift+equal  change_font_size all +2.0
map ctrl+shift+minus  change_font_size all -2.0
map ctrl+shift+0      change_font_size all 0
```

### Performance Optimization
```conf
# Rendering
repaint_delay 10
input_delay   3
sync_to_monitor yes

# GPU rendering
enable_audio_bell no
visual_bell_duration 0.0

# Scrollback
scrollback_lines 10000
scrollback_pager less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER

# Performance
update_check_interval 0
```

### Advanced Features
```conf
# Shell integration
shell_integration enabled

# Mouse
mouse_hide_wait 3.0
url_color #83a598
url_style curly
open_url_with default
detect_urls yes
copy_on_select no

# Cursor
cursor_shape block
cursor_blink_interval -1
cursor_stop_blinking_after 15.0

# Bell
enable_audio_bell no
visual_bell_duration 0.0
window_alert_on_bell yes

# Advanced
allow_remote_control yes
listen_on unix:/tmp/kitty
clipboard_control write-clipboard write-primary
term xterm-kitty
```

## Kittens (Extensions)

### Useful Kittens
```conf
# Diff kitten for side-by-side diffs
map ctrl+shift+d launch --type=overlay --stdin-source=@screen_scrollback diff

# Unicode input
map ctrl+shift+u kitten unicode_input

# Hints kitten for opening URLs/paths
map ctrl+shift+e kitten hints

# icat for displaying images
# Use from command line: kitty +kitten icat image.png
```

### Custom Kitten Scripts
```python
# ~/.config/kitty/custom-kitten.py
from kittens.tui.handler import result_handler

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        w.paste('custom text')
```

## Integration with Tmux

### Optimal Settings for Tmux + Kitty
```conf
# In kitty.conf
# Allow tmux to use clipboard
clipboard_control write-clipboard write-primary

# Better tmux rendering
term xterm-kitty

# Pass keys through to tmux
map ctrl+a>c new_window_with_cwd
map ctrl+a>% new_window_with_cwd --location=vsplit
map ctrl+a>" new_window_with_cwd --location=hsplit
```

```conf
# In tmux.conf
# Use kitty's terminfo
set -g default-terminal "xterm-kitty"
set -as terminal-overrides ',xterm-kitty:RGB'

# Enable mouse
set -g mouse on

# Fix escape delay
set -sg escape-time 0
```

## Theme Management

### Popular Kitty Themes
- **Gruvbox**: Warm, retro colors
- **Nord**: Cool, arctic-inspired palette
- **Dracula**: Dark with vibrant accents
- **Tokyo Night**: Modern dark theme
- **Catppuccin**: Pastel colors
- **Monokai**: Classic code editor theme
- **Solarized**: Light and dark variants
- **One Dark**: Atom-inspired

### Theme Switching
```bash
# Clone themes repository
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/themes

# Link theme in kitty.conf
include ./themes/gruvbox-dark.conf

# Or use kitten themes
kitty +kitten themes
```

## Advanced Techniques

### Dynamic Color Switching
```bash
#!/bin/bash
# switch-kitty-theme.sh
THEME=$1
kitty @ set-colors --all --configured ~/.config/kitty/themes/${THEME}.conf
```

### Remote Control
```bash
# Send text to kitty window
kitty @ send-text "echo hello\n"

# Create new tab
kitty @ launch --type=tab

# Change colors dynamically
kitty @ set-colors background=#000000

# List windows
kitty @ ls
```

### Session Management
```bash
# Save session
kitty @ ls > ~/.config/kitty/session.json

# Restore session (use startup script)
```

### Custom Layouts
```python
# ~/.config/kitty/layouts/custom.py
from kitty.layout import Layout

class MyLayout(Layout):
    name = 'custom'

    def do_layout(self, windows):
        # Custom layout logic
        pass
```

## Font Recommendations

### Best Programming Fonts for Kitty
- **JetBrains Mono**: Excellent ligatures, clear distinction
- **Fira Code**: Popular ligature support
- **Cascadia Code**: Microsoft's programming font
- **Iosevka**: Highly customizable, narrow
- **Hack**: Clear and readable
- **Source Code Pro**: Adobe's monospace font
- **Victor Mono**: Cursive italics

### Nerd Fonts for Icons
```bash
# Install nerd fonts for icon support
curl -fLo "JetBrains Mono Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip

# Unzip and install to ~/.local/share/fonts/
```

## Performance Tuning

### GPU Acceleration
```conf
# Force GPU rendering
enable_audio_bell no
visual_bell_duration 0.0

# Reduce latency
repaint_delay 5
input_delay 1
sync_to_monitor yes
```

### Memory Management
```conf
# Limit scrollback to save memory
scrollback_lines 5000

# Clear scrollback on full screen apps
scrollback_pager_history_size 0
```

## Best Practices

### Configuration Organization
```conf
# kitty.conf - main configuration
include ./fonts.conf
include ./colors.conf
include ./keybindings.conf
include ./local.conf
```

### OS-Specific Settings
```conf
# macos_option_as_alt yes
# linux_display_server x11
```

### Debugging
```bash
# Run kitty with debug output
kitty --debug-config

# Test configuration
kitty --config=/path/to/test.conf

# Check for errors
kitty --debug-keyboard
```

## For This Project

### Recommended Setup for Dotfiles Repo
```conf
# ~/.config/kitty/kitty.conf
# Font
font_family      JetBrainsMono Nerd Font
font_size        11.0
disable_ligatures never

# Theme matching tmux/zsh colors
include ./colors-dotfiles.conf

# Performance
repaint_delay 10
input_delay   3
sync_to_monitor yes

# Window
remember_window_size  yes
window_padding_width 2
enabled_layouts splits,stack

# Tab bar
tab_bar_style powerline
tab_bar_edge top

# Scrollback
scrollback_lines 10000

# Shell integration
shell_integration enabled

# Allow remote control for scripting
allow_remote_control yes

# Clipboard
clipboard_control write-clipboard write-primary

# Include local overrides
include ./local.conf
```

### Custom Color Scheme Matching Project
```conf
# colors-dotfiles.conf - matching tmux/zsh theme
foreground #ebdbb2
background #282828

# Match tmux status bar colors
color0  #442E59  # Purple dark
color1  #79658C  # Purple mid
color2  #27403B  # Green dark
color3  #5D736D  # Green mid
color4  #83a598  # Blue (git branch)
color5  #d3869b  # Magenta (virtualenv)
color6  #b8bb26  # Lime green (kubectl)
color7  #ebdbb2  # White

# Bright colors
color8  #928374
color9  #fb4934
color10 #b8bb26
color11 #fabd2f
color12 #83a598
color13 #d3869b
color14 #8ec07c
color15 #ebdbb2

# UI colors
selection_foreground #282828
selection_background #83a598
url_color #83a598
```

## Resources

- Official docs: https://sw.kovidgoyal.net/kitty/
- Kitty themes: https://github.com/dexpota/kitty-themes
- Remote control: https://sw.kovidgoyal.net/kitty/remote-control/
- Kittens: https://sw.kovidgoyal.net/kitty/kittens_intro/
