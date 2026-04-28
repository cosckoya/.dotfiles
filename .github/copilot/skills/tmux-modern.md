---
name: tmux-modern-configuration
description: "Tmux 3.4+ expert. Native features only, no external dependencies. Vi-bindings, clipboard integration, color schemes."
category: terminal-multiplexing
priority: 80
token_cost_estimate: 2800
---

# Modern Tmux Configuration (2026)

## Tmux 3.4+ Architecture

### 1. Configuration Philosophy
**Native Tmux Only**: No external dependencies (tpm, plugins, bash scripts)
- Faster startup
- Simpler troubleshooting
- Self-contained configuration
- Better portability

### 2. Core Settings
```tmux
# General options
set -g default-terminal "xterm-256color"
set -g mouse on
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on

# Vi-style keybindings
setw -g mode-keys vi
set -g status-keys vi

# Scrollback
set -g history-limit 50000
```

### 3. Key Bindings (2026 Standard)
```tmux
# Prefix key (C-a is modern convention)
unbind C-b
set -g prefix C-a

# Vi-style copy mode (native, no copy-pipe needed)
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi C-v send -X rectangle-toggle
bind -T copy-mode-vi y send -X copy-selection-no-clear

# Smart pane navigation
bind C-h select-pane -L
bind C-j select-pane -D
bind C-k select-pane -U
bind C-l select-pane -R

# Resize panes
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Window management
bind -n C-S-Left swap-window -t -1
bind -n C-S-Right swap-window -t +1
```

### 4. Color Scheme (Drizzt Do'Urden - Unified)
```tmux
# Colors: 256-color palette
# Lavender: 141, Icy Blue: 117, Green: 78, Yellow: 222, Red: 167
# Background: #100814, Foreground: #e0dfe8

# Status bar
set -g status-style "bg=#100814,fg=#e0dfe8"
set -g status-left-length 20
set -g status-right-length 30

# Pane borders
set -g pane-border-style "fg=#4a5273"
set -g pane-active-border-style "fg=#b19cd9"

# Status bar format
set -g status-left "#[bg=#b19cd9,fg=#100814] #S #[default] "
set -g status-right "#[fg=#7ec8e3]%H:%M #[fg=#e0dfe8]%a %b %d"

# Window status
setw -g window-status-format "#I:#W"
setw -g window-status-current-format "#[bold,fg=#b19cd9]#I:#W#[default]"
```

### 5. Platform-Specific Clipboard
```tmux
# Auto-detect and use available clipboard
if-shell "command -v pbcopy" {
  bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"
}
if-shell "command -v xclip" {
  bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -selection clipboard"
}
if-shell "command -v xsel" {
  bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xsel --clipboard"
}
if-shell "command -v wl-copy" {
  bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy"
}
```

### 6. Smart Pane & Window Management
```tmux
# Automatic pane numbering
set -g pane-border-status bottom
set -g pane-border-format "#{pane_index}: #{pane_current_command}"

# Auto-create windows with names
bind c new-window -c "#{pane_current_path}"
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"

# Session management
bind S command-prompt -p "New session:" "new-session -s '%%'"
bind T command-prompt -p "Rename session:" "rename-session '%%'"
```

### 7. Performance Optimization
```tmux
# Aggressive resize (multi-client scenarios)
setw -g aggressive-resize on

# Disable status updates if not needed
set -g status-interval 15  # Update every 15s instead of 1s

# Reduce visual indicators (no flashing)
set -g visual-bell off
set -g bell-action other
```

### 8. Advanced: Session Management Hook
```tmux
# Auto-start tmux session on new shell (in zsh.d/tmux.zsh)
# Configured via environment variables:
# TMUX_AUTOSTART_ENABLED, TMUX_SKIP_SSH, TMUX_SKIP_IDE, etc.
```

## 2026 Configuration Patterns

### Conditional Settings (tmux 3.3+)
```tmux
# Check for command availability
if-shell "command -v fzf" {
  bind '/' run-shell 'fzf-tmux -p 40%'
}

# OS-specific settings
if-shell "uname | grep -q Linux" {
  set -g default-shell /bin/zsh
}
```

### Dynamic Status Bar
```tmux
# Show sudo warning if needed
set -g status-right "#{?pane_in_mode,#[fg=red](COPY),} %H:%M"

# Highlight when prefix is pressed
set -g status-left "#{?client_prefix,#[bg=red] #[default],} #S "
```

### Window-Specific Settings
```tmux
# Different options per window type
# Can be set via send-keys commands
# Example: tmux send-keys -t mywindow "vim" Enter
```

## Best Practices (2026)

### Configuration Organization
- Keep main config under 240 lines
- Comment complex bindings
- Group related settings (colors, keybinds, etc.)
- Use if-shell for conditionals
- No external dependencies (no tpm, no shell scripts)

### Keyboard Efficiency
- Vim-style navigation (hjkl)
- Prefix-free window switching (C-h/j/k/l)
- Prefix-less pane resizing (-r H/J/K/L)
- Intuitive split commands (v/s)

### Performance
- Limit status bar updates (interval > 5s)
- Use native features only
- Aggressive resize for multi-client
- History limit 50000 (good balance)

### Compatibility
- Support multiple clipboard managers
- Check command availability with if-shell
- Platform detection (Linux vs macOS)
- Fall back gracefully when tools missing

## Anti-Patterns to Avoid

- External plugins (use native tmux 3.4+ instead)
- Shell scripts for simple tasks
- Complex shell commands in keybindings
- Hardcoded terminal names
- Unquoted variables
- Missing if-shell guards for optional commands
- Status bar updates every 1s (too frequent)
- Complex nested conditionals

## Integration with Dotfiles Project

- Primary multiplexer for development sessions
- Auto-start from ZSH (configurable via zsh.d/config.zsh)
- Unified Drizzt Do'Urden color scheme with ZSH/Kitty/Neovim
- Smart session name management
- IDE/SSH detection for auto-start toggling
