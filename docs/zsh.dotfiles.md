# ZSH Configuration

ZSH interactive shell configuration split across a main entry point and six single-purpose modules. Startup target: under 110ms.

---

## Entry Point: `zshrc`

Loading order:

1. `zsh.d/config.zsh` — environment variables
2. Tmux auto-start logic
3. Zinit bootstrap
4. History and shell options
5. `zsh.d/tools.zsh`, `toolbox.zsh`, `alias.zsh`, `tmux.zsh`
6. Prompt + vcs_info setup
7. `compinit` with daily cache invalidation
8. Zinit plugins (async, turbo mode)
9. `zsh.d/autocomplete.zsh`
10. `mise` activation

---

## Modules

### `zsh.d/config.zsh` — Tmux variables

All Tmux auto-start behavior is controlled here. Override any variable in the environment before launching a shell.

| Variable | Default | Effect |
|----------|---------|--------|
| `TMUX_AUTOSTART_ENABLED` | `true` | Master switch |
| `TMUX_AUTOSTART_SESSION` | `default` | Session name to attach or create |
| `TMUX_SKIP_SSH` | `false` | Skip auto-start in SSH sessions |
| `TMUX_SKIP_IDE` | `true` | Skip inside VSCode (`$VSCODE_PID`) and Emacs (`$INSIDE_EMACS`) |
| `TMUX_SKIP_DESKTOP` | `true` | Skip in graphical desktop sessions |
| `TMUX_SKIP_DESKTOP_SESSIONS` | `bspwm,i3,gnome,kde,xfce` | Comma-separated list of `$DESKTOP_SESSION` values to skip |

---

### `zsh.d/tools.zsh` — PATH and editor chain

Editor selection (in order of availability):

```zsh
nvim → vim → nano
```

Exported as `$VISUAL` and `$EDITOR`. `vi` is aliased to whichever is found.

PATH additions (only if directory exists, using `typeset -U path` to deduplicate):

```
$HOME/.local/bin   → highest priority
$HOME/.asdf/shims  → ASDF managed runtimes
$HOME/bin          → local binaries (asdf binary lives here)
$GOPATH/bin        → Go tools
```

NPM completions use a self-removing wrapper — the function undefines itself after first invocation to avoid repeat overhead:

```zsh
function npm() {
  unfunction npm
  source <(command npm completion zsh 2>/dev/null || true)
  command npm "$@"
}
```

---

### `zsh.d/alias.zsh` — Aliases and Docker wrappers

Security tools are Docker-based: no local installation required, containers are ephemeral (`--rm`).

| Alias | Image | Notes |
|-------|-------|-------|
| `kali` | `kalilinux/kali-rolling` | Interactive Kali shell |
| `parrot` | `parrotsec/core` | Parrot OS shell |
| `debian` | `debian:latest` | Clean Debian shell |
| `archlinux` | `archlinux:latest` | Arch shell |
| `wpscan` | `wpscanteam/wpscan` | WordPress scanner |
| `nikto` | `secfigo/nikto` | Web server scanner |
| `nuclei` | `projectdiscovery/nuclei` | Template-based scanner |
| `metasploit` | `metasploitframework/metasploit-framework` | Persists `~/.msf4` |
| `zap` | `zaproxy/zap-stable` | OWASP ZAP GUI (port 8080) |
| `zap-cli` | `zaproxy/zap-stable` | OWASP ZAP CLI |

`batcat` replaces `cat` if present (`--theme=TwoDark`).

---

### `zsh.d/autocomplete.zsh` — Lazy completions

Uses `$+commands[]` (faster than `command -v`) to check for tool presence. Each completion uses the self-removing pattern:

```zsh
_load_kubectl_completion() {
  source <(kubectl completion zsh)
  unfunction _load_kubectl_completion
}
compdef _load_kubectl_completion kubectl
```

Tools covered: `kubectl`, `helm`, `kind`, `asdf`.

---

### `zsh.d/tmux.zsh` — Tmux helpers

Functions and short aliases for session management:

| Command | Action |
|---------|--------|
| `tmux-new [name]` | Create session (defaults to current directory name) |
| `tmux-list` / `tl` | List all sessions |
| `tmux-attach [name]` / `ta` | Attach to session |
| `tmux-kill <name>` / `tk` | Kill named session |
| `tn <name>` | New session shorthand |

---

### `zsh.d/toolbox.zsh` — Toolbox function

Downloads the latest Dockerfile from `github.com/cosckoya/toolbox`, builds an image once, and runs an ephemeral container mounting `~/hack` as `/hack`.

```bash
toolbox               # interactive shell, reuses existing image
toolbox --force       # force rebuild
toolbox --no-cache    # rebuild without Docker cache
toolbox ls -la        # run single command
```

The container is removed on exit (`--rm`). The image persists across sessions.

---

## Prompt: Drizzt Do'Urden

### Left prompt

```
┌──(hostname の username)
└─#
```

| Element | Color | 256-code |
|---------|-------|----------|
| Border `┌──` `└─#` | Lavender | 141 |
| Hostname | Icy Blue | 117 |
| Separator `の` | Magical Yellow | 222 |
| Username | Red | 167 |

### Right prompt (RPROMPT)

Built dynamically by `_build_rprompt()` on every `precmd`. Shows only what is active:

| Context | Color | 256-code | Condition |
|---------|-------|----------|-----------|
| Git branch | Icy Blue | 117 | Inside a git repo (`vcs_info`) |
| Python venv | Lavender | 141 | `$VIRTUAL_ENV` is set |
| Kubernetes context | Drow Green | 78 | `$ZSH_KUBECTL_PROMPT` is set |
| `Klaatu Barada Nitko!` | Magical Yellow | 222 | None of the above |

---

## Zinit Plugins

Loaded with turbo mode (async, non-blocking). Startup is not blocked by plugin load.

| Plugin | Wait | Purpose |
|--------|------|---------|
| `superbrothers/zsh-kubectl-prompt` | `wait"1"` | Populates `$ZSH_KUBECTL_PROMPT` |
| `zsh-users/zsh-autosuggestions` | `wait"2"` | Fish-style inline suggestions |
| `zsh-users/zsh-completions` | `wait"2"` | Extended completion definitions |
| `zdharma-continuum/fast-syntax-highlighting` | `wait"3"` | Syntax coloring in the prompt |

---

## Compinit caching

Cache at `~/.zcompdump` is regenerated when any of these conditions are true:

- File does not exist
- File is older than 1 day (`-mtime +1`)
- `~/.local/share/zinit` directory is newer than the dump

When cache is valid, `compinit -C` skips the slow regeneration step.

---

## Startup verification

```bash
time zsh -ic exit                                                    # measure total startup
zsh --startuptime /tmp/zsh.log -i -c exit && sort -k2 -n /tmp/zsh.log | tail -20   # find slow sources
exec zsh                                                             # reload current shell
```
