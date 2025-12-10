# Tmux auto-start configuration
# This file is kept for reference but auto-start is now in .zshrc
#
# To enable tmux auto-start, the code has been moved to the beginning of ~/.zshrc
# To disable tmux auto-start, comment out the tmux block in ~/.zshrc
#
# Configuration options:
# - TMUX_AUTOSTART_ENABLED=false in your environment to disable
# - TMUX_AUTOSTART_SESSION="default" to set default session name
# - Skip SSH: uncomment the SSH_CONNECTION check in .zshrc

# Optional: Tmux helper functions
function tmux-new() {
  local session_name="${1:-$(basename $(pwd))}"
  tmux new-session -s "$session_name"
}

function tmux-list() {
  tmux list-sessions
}

function tmux-attach() {
  if [[ -n "$1" ]]; then
    tmux attach-session -t "$1"
  else
    tmux attach-session
  fi
}

function tmux-kill() {
  if [[ -n "$1" ]]; then
    tmux kill-session -t "$1"
  else
    echo "Usage: tmux-kill <session-name>"
  fi
}

# Aliases
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
