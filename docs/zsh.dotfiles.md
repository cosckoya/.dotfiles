# ZSH Configuration

Entry point: `zshrc` → modules in `zsh.d/` → Zinit plugins (async) → prompt.

Target startup: under 110ms.

## Modules

| Module | Purpose |
|--------|---------|
| `config.zsh` | Environment variables: Tmux auto-start behavior |
| `tools.zsh` | PATH, editor selection, npm lazy-loading |
| `alias.zsh` | Command aliases and Docker wrappers |
| `autocomplete.zsh` | Lazy-loaded completions for kubectl/helm/kind |
| `tmux.zsh` | Tmux helper functions and aliases |
| `toolbox.zsh` | Download and run Docker-based development environment |

## Environment Variables

All variables are defined in `zsh.d/config.zsh` and can be overridden in your shell environment.

| Variable | Default | Behavior |
|----------|---------|----------|
| `TMUX_AUTOSTART_ENABLED` | `true` | Start tmux on shell login |
| `TMUX_AUTOSTART_SESSION` | `default` | Session name to attach or create |
| `TMUX_SKIP_SSH` | `false` | Skip auto-start in SSH sessions |
| `TMUX_SKIP_IDE` | `true` | Skip in VSCode (`$VSCODE_PID`) and Emacs (`$INSIDE_EMACS`) |
| `TMUX_SKIP_DESKTOP` | `true` | Skip in graphical desktop sessions |
| `TMUX_SKIP_DESKTOP_SESSIONS` | `bspwm,i3,gnome,kde,xfce` | Desktop environments to skip |

Override example:

```bash
# Start a new shell without tmux
export TMUX_AUTOSTART_ENABLED="false"
zsh
```

## Prompt

Left prompt shows hostname and username. Right prompt (RPROMPT) is dynamic:

- Git branch (from `vcs_info`, only in repos)
- Python virtualenv (if `$VIRTUAL_ENV` is set)
- Kubernetes context (if `$ZSH_KUBECTL_PROMPT` is set)
- Fallback message if none are active

Colors use 256-color codes for ZSH compatibility. See [Color Scheme](./color-scheme.dotfiles.md) for hex values.

## Zinit Plugins

Loaded asynchronously (turbo mode) with `wait` delays. Startup is not blocked by plugin loading.

| Plugin | Wait | Purpose |
|--------|------|---------|
| `superbrothers/zsh-kubectl-prompt` | 1s | Populates `$ZSH_KUBECTL_PROMPT` |
| `zsh-users/zsh-autosuggestions` | 2s | Fish-style inline suggestions |
| `zsh-users/zsh-completions` | 2s | Extended completion definitions |
| `zdharma-continuum/fast-syntax-highlighting` | 3s | Syntax coloring in prompt |

Plugin loading does not block the prompt from appearing.

## Completions

Compinit cache (`~/.zcompdump`) is regenerated when:

- File does not exist
- File is older than 1 day
- `~/.local/share/zinit` directory is newer than the cache

Lazy-loaded completions use a self-removing wrapper pattern:

```bash
_load_kubectl_completion() {
  source <(kubectl completion zsh)
  unfunction _load_kubectl_completion
}
compdef _load_kubectl_completion kubectl
```

The function undefines itself after first invocation. Subsequent invocations use the cached completion.

## Docker Aliases

Security tools run in ephemeral containers. No local installation required.

```bash
kali                # Kali Linux container
parrot              # Parrot OS container
debian              # Clean Debian container
archlinux           # Arch Linux container
wpscan              # WordPress scanner
nikto               # Web server scanner
nuclei              # Template-based scanner
metasploit          # Metasploit Framework (persists ~/.msf4)
zap                 # OWASP ZAP GUI (port 8080)
zap-cli             # OWASP ZAP CLI
```

## Editor Selection

Fallback chain (first available):

```
nvim → vim → nano
```

Exported as `$VISUAL` and `$EDITOR`. `vi` alias points to whichever is selected.

## Troubleshooting

**Slow startup?**
```bash
zsh --startuptime /tmp/zsh.log -i -c exit
sort -k2 -n /tmp/zsh.log | tail -20
```

**Missing command?**
Check `zsh.d/alias.zsh` for Docker wrappers. Check `zsh.d/tools.zsh` for PATH configuration.

**Completions not working?**
```bash
rm ~/.zcompdump
exec zsh
```
