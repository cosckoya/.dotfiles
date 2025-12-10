# ZSH Configuration Options
# This file contains optional configuration variables

# Tmux auto-start configuration
# Set to "false" to disable tmux auto-start
export TMUX_AUTOSTART_ENABLED="${TMUX_AUTOSTART_ENABLED:-true}"

# Default tmux session name
export TMUX_AUTOSTART_SESSION="${TMUX_AUTOSTART_SESSION:-default}"

# Skip tmux auto-start in SSH sessions
# Set to "true" to disable tmux in SSH sessions
export TMUX_SKIP_SSH="${TMUX_SKIP_SSH:-false}"

# Skip tmux auto-start in specific terminals
# Set to "true" to skip tmux in VSCode and similar
export TMUX_SKIP_IDE="${TMUX_SKIP_IDE:-true}"

# Skip tmux auto-start in desktop environments
# Set to "true" to skip tmux in graphical desktop sessions (bspwm, i3, etc.)
export TMUX_SKIP_DESKTOP="${TMUX_SKIP_DESKTOP:-true}"

# Desktop sessions to skip (comma-separated)
export TMUX_SKIP_DESKTOP_SESSIONS="${TMUX_SKIP_DESKTOP_SESSIONS:-bspwm,i3,gnome,kde,xfce}"
