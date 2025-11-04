# Tmux Integration with ZSH

This document explains the tmux auto-start integration in your ZSH configuration.

## Overview

Tmux is now configured to automatically start when you open a new terminal session. This provides a persistent terminal environment that survives disconnections and allows for easy window/pane management.

## Features

✅ **Auto-start on terminal launch**
✅ **Attach to existing sessions** - Reuses the same session instead of creating multiple ones
✅ **IDE-aware** - Skips auto-start in VSCode, Emacs, etc. (configurable)
✅ **SSH-aware** - Can skip auto-start in SSH sessions (configurable)
✅ **Desktop-aware** - Skips auto-start in graphical desktop environments (bspwm, i3, etc.)
✅ **Fully configurable** - Easy to enable/disable per environment

## Configuration

### Quick Toggle

To **disable** tmux auto-start globally, add to your `~/.zshenv`:

```bash
export TMUX_AUTOSTART_ENABLED=false
```

To **enable** it back:

```bash
export TMUX_AUTOSTART_ENABLED=true
```

### Advanced Configuration

Edit `~/.zsh.d/config.zsh` or set these environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `TMUX_AUTOSTART_ENABLED` | `true` | Enable/disable tmux auto-start |
| `TMUX_AUTOSTART_SESSION` | `default` | Default session name |
| `TMUX_SKIP_SSH` | `false` | Skip tmux in SSH sessions |
| `TMUX_SKIP_IDE` | `true` | Skip tmux in IDEs (VSCode, Emacs) |
| `TMUX_SKIP_DESKTOP` | `true` | Skip tmux in graphical desktop environments |
| `TMUX_SKIP_DESKTOP_SESSIONS` | `bspwm,i3,gnome,kde,xfce` | Desktop sessions to skip (comma-separated) |

### Per-Environment Configuration

Create a `~/.zshenv` file for machine-specific settings:

```bash
# Example: Disable tmux on your laptop but enable on servers
if [[ $(hostname) == "my-laptop" ]]; then
  export TMUX_AUTOSTART_ENABLED=false
else
  export TMUX_AUTOSTART_ENABLED=true
fi
```

## Helper Functions & Aliases

The configuration includes helpful tmux shortcuts:

### Functions

```bash
tmux-new [session-name]    # Create new session (default: current dir name)
tmux-list                  # List all sessions
tmux-attach [session-name] # Attach to session
tmux-kill <session-name>   # Kill a session
```

### Aliases

```bash
tl       # List sessions (tmux list-sessions)
ta       # Attach to session (tmux attach-session -t)
tn       # New session (tmux new-session -s)
tk       # Kill session (tmux kill-session -t)
```

## Usage Examples

### Basic Usage

```bash
# Auto-start happens automatically when you open a terminal
# To detach from tmux: Ctrl+b, then d

# List sessions
tl

# Create a new named session
tn work

# Attach to specific session
ta work

# Kill a session
tk work
```

### Multiple Sessions

```bash
# Create sessions for different projects
tn project1
tn project2
tn monitoring

# Switch between them
ta project1
ta project2
```

### Tmux Key Bindings (Default)

| Keybinding | Action |
|------------|--------|
| `Ctrl+b` then `d` | Detach from session |
| `Ctrl+b` then `c` | Create new window |
| `Ctrl+b` then `n` | Next window |
| `Ctrl+b` then `p` | Previous window |
| `Ctrl+b` then `%` | Split pane vertically |
| `Ctrl+b` then `"` | Split pane horizontally |
| `Ctrl+b` then `arrow` | Navigate between panes |

For more key bindings, see your `~/.tmux.conf` configuration.

## Troubleshooting

### Issue: Tmux doesn't auto-start

**Check if enabled:**
```bash
echo $TMUX_AUTOSTART_ENABLED
```

**Verify tmux is installed:**
```bash
command -v tmux
```

**Check for errors:**
```bash
zsh -x 2>&1 | grep -i tmux
```

### Issue: Too many nested tmux sessions

This is prevented by checking `$TMUX` variable. If you're in tmux, auto-start won't trigger.

### Issue: Tmux starts in IDE terminals

Set `TMUX_SKIP_IDE=true` (it's the default):
```bash
export TMUX_SKIP_IDE=true
```

### Issue: Tmux starts in graphical desktop terminals

By default, tmux is skipped in desktop environments like bspwm, i3, GNOME, KDE, XFCE.

To **enable** tmux in desktop terminals:
```bash
export TMUX_SKIP_DESKTOP=false
```

To **add/remove** desktop sessions from skip list:
```bash
export TMUX_SKIP_DESKTOP_SESSIONS="bspwm,i3,sway"
```

### Issue: Want to temporarily skip tmux

Launch zsh with:
```bash
TMUX_AUTOSTART_ENABLED=false zsh
```

Or set in your current session:
```bash
export TMUX_AUTOSTART_ENABLED=false
exec zsh
```

## Disabling Auto-Start Permanently

### Option 1: Environment Variable

Add to `~/.zshenv`:
```bash
export TMUX_AUTOSTART_ENABLED=false
```

### Option 2: Comment Out in .zshrc

Edit `~/.zshrc` and comment out the tmux auto-start block:

```bash
# Tmux auto-start (disabled)
# if command -v tmux >/dev/null 2>&1 ...
```

### Option 3: Remove from Configuration

Remove or rename `~/.zsh.d/tmux.zsh` and `~/.zsh.d/config.zsh`

## Integration with Profile Makefile

The tmux configuration is set up via:

```bash
make tmux -C profile
```

This:
1. Downloads the Oh My Tmux configuration
2. Symlinks your custom `tmux.local` configuration
3. Sets up ZSH integration

## Further Customization

### Custom tmux.local

Edit `~/.dotfiles/profile/tmux.local` to customize:
- Status bar theme
- Key bindings
- Window/pane behavior
- Colors and appearance

### Custom session names

Use different session names for different workflows:

```bash
export TMUX_AUTOSTART_SESSION="work"    # For work laptop
export TMUX_AUTOSTART_SESSION="home"    # For home desktop
export TMUX_AUTOSTART_SESSION="dev"     # For development servers
```

## Resources

- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Oh My Tmux](https://github.com/gpakosz/.tmux)
- [Tmux Book](https://leanpub.com/the-tao-of-tmux/read)

## Quick Reference

```bash
# Enable/Disable
export TMUX_AUTOSTART_ENABLED=true|false

# Session management
tl                          # List
tn <name>                   # New
ta <name>                   # Attach
tk <name>                   # Kill

# Inside tmux
Ctrl+b d                    # Detach
Ctrl+b c                    # New window
Ctrl+b [0-9]                # Switch window
Ctrl+b %                    # Split vertically
Ctrl+b "                    # Split horizontally
```
