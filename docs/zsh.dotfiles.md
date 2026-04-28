# ZSH Configuration

> *"In the realm where mortals sleep and dream, chaos and order dance eternal."* — Morpheus, Dream of the Endless

This documentation describes the ZSH shell environment architecture — a modular, performance-optimized system designed for rapid startup and graceful degradation. Think of it as the Dream realm: organized layers, each serving a purpose, yet fluid and responsive.

**Entry point:** `zshrc` → modules in `zsh.d/` → Zinit plugins (async) → prompt.

**Target startup:** under 110ms.

```
        ╔════════════════════════════════════════════╗
        ║      Dream Realm Architecture              ║
        ║    (ZSH Shell Configuration)               ║
        ╠════════════════════════════════════════════╣
        ║  zshrc (Awakening)                         ║
        ║    ├─ config.zsh (Realm Setup)             ║
        ║    ├─ tools.zsh (Path to Destiny)          ║
        ║    ├─ toolbox.zsh (Sacred Artifacts)       ║
        ║    ├─ alias.zsh (Incantations)             ║
        ║    ├─ tmux.zsh (Portal Layer)              ║
        ║    ├─ autocomplete.zsh (Whispers)          ║
        ║    └─ Zinit (Async Summons)                ║
        ║       ├─ kubectl-prompt (Future Visions)   ║
        ║       ├─ autosuggestions (Echoes)          ║
        ║       ├─ completions (Knowledge Archive)   ║
        ║       └─ syntax-highlighting (Twilight)    ║
        ╚════════════════════════════════════════════╝
```

## Modules — The Seven Sanctums

Each module is independent and can be loaded, disabled, or replaced without affecting others.

| Module | Purpose | Performance |
|--------|---------|-------------|
| `config.zsh` | Environment variables: Tmux auto-start behavior, realm configuration | ~2ms |
| `tools.zsh` | PATH construction, editor selection, tool availability checks | ~5ms |
| `alias.zsh` | Command aliases and Docker incantations (security tool wrappers) | ~1ms |
| `autocomplete.zsh` | Lazy-loaded completions for kubectl/helm/kind (load on first use) | 0ms (deferred) |
| `tmux.zsh` | Tmux helper functions and portal aliases | ~1ms |
| `toolbox.zsh` | Docker-based development sandbox and utility functions | ~1ms |

**Total startup cost:** ~10ms (modules) + ~40ms (Zinit/compinit) + ~60ms (system overhead) = ~110ms target

## Environment Variables — Realm Configuration

All variables are defined in `zsh.d/config.zsh` and can be overridden in your shell environment at runtime. These control how the Dream realm awakens and whether Morpheus summons the portal (tmux).

| Variable | Default | Behavior | Context |
|----------|---------|----------|---------|
| `TMUX_AUTOSTART_ENABLED` | `true` | Start tmux on shell login | Enter the shared dream layer automatically |
| `TMUX_AUTOSTART_SESSION` | `default` | Session name to attach or create | Which dream chamber to enter |
| `TMUX_SKIP_SSH` | `false` | Skip auto-start in SSH sessions | Avoid nested multiplexers over remote |
| `TMUX_SKIP_IDE` | `true` | Skip in VSCode (`$VSCODE_PID`) and Emacs (`$INSIDE_EMACS`) | IDE tools manage their own multiplexing |
| `TMUX_SKIP_DESKTOP` | `true` | Skip in graphical desktop sessions | Graphical environments handle windowing |
| `TMUX_SKIP_DESKTOP_SESSIONS` | `bspwm,i3,gnome,kde,xfce` | Desktop environments to skip | Specific desktop managers listed |

**Override example:**

```bash
# Awaken without the portal (tmux)
export TMUX_AUTOSTART_ENABLED="false"
zsh

# Enter a specific dream chamber
export TMUX_AUTOSTART_SESSION="work"
zsh
```

## Prompt — The Veil Between Worlds

The prompt is your interface to the Dream realm. It shows your presence (left) and your current bindings (right).

**Left prompt:** Lavender border (realm marker) + icy blue hostname + yellow separator + red username.

```
┌──(hostname の user)
└─#
```

**Right prompt (RPROMPT):** Dynamic context—reveals what dream you inhabit:

| Context | Display | Meaning |
|---------|---------|---------|
| Git repository | Branch name (icy blue) | Version control awareness |
| Python virtualenv | Environment name (lavender) | Active Python realm |
| Kubernetes context | Cluster/namespace (drow green) | Container orchestration target |
| None active | "Klaatu Barada Nitko!" (yellow) | Awaiting direction |

**Example prompts:**

```
┌──(workstation の user)        (main) ~/.venv kube-prod
└─#

┌──(server の user)              (feat/auth)
└─#

┌──(client の user)              Klaatu Barada Nitko!
└─#
```

Colors use 256-color codes for ZSH compatibility. See [Color Scheme](./color-scheme.dotfiles.md) for hex values and WCAG AAA contrast verification.

## Zinit Plugins — Async Summons

Plugins are loaded asynchronously (turbo mode) with staggered `wait` delays. The prompt appears **before** plugins finish loading — you can start typing immediately.

| Plugin | Wait | Purpose | Realm Purpose |
|--------|------|---------|---------------|
| `superbrothers/zsh-kubectl-prompt` | 1s | Kubernetes cluster awareness | Reveals orchestration destiny |
| `zsh-users/zsh-autosuggestions` | 2s | Fish-style inline suggestions | Echoes from the knowledge archive |
| `zsh-users/zsh-completions` | 2s | Extended completion definitions | Extended path completion library |
| `zdharma-continuum/fast-syntax-highlighting` | 3s | Syntax coloring in prompt | Twilight illumination of commands |

**Timeline:**

```
t=0ms     Prompt appears (ready for input)
t=1s      kubectl-prompt loads (RPROMPT updates)
t=2s      autosuggestions + completions load (suggestions and tab-complete available)
t=3s      syntax-highlighting loads (colored input)
```

**Important:** Plugin loading does not block the prompt. You can start working immediately.

Zinit is managed via the [`zdharma-continuum/zinit`](https://github.com/zdharma-continuum/zinit) git repository and bootstrapped automatically on first run if git is available.

## Completions — The Knowledge Archive

ZSH completion is managed via `compinit` with intelligent caching. The system learns your tools and avoids redundant computation.

### Completion Cache Strategy

The compinit cache (`~/.zcompdump`) is regenerated when:

- Cache file doesn't exist (first run)
- Cache is older than 1 day (refresh strategy)
- `~/.local/share/zinit` directory is newer than cache (plugin changes detected)

This keeps completions fresh without checking tools on every startup.

### Lazy-Loaded Completions (Self-Removing Pattern)

External tool completions (kubectl, helm, kind) use a self-removing wrapper to avoid startup overhead:

```bash
_load_kubectl_completion() {
  # On first invocation: source the completion
  source <(kubectl completion zsh)
  # Remove this wrapper function (not needed again)
  unfunction _load_kubectl_completion
}
# Register the wrapper as the completion source
compdef _load_kubectl_completion kubectl
```

**Behavior:**

- **First tab at `kubectl`:** Loads tool's completion script, caches it, then completes
- **Subsequent tabs at `kubectl`:** Uses cached completion (instant)
- **Memory:** Wrapper function is deleted after first use (no bloat)

This pattern is used for tools that would otherwise block startup (kubectl, helm, kind, etc.).

## Docker Aliases — Ephemeral Sanctums

Security tools and specialized environments run in isolated Docker containers. No local installation cruft — pure sandbox execution.

| Alias | Purpose | Persistence | Network |
|-------|---------|-------------|---------|
| `kali` | Kali Linux penetration testing suite | Ephemeral | Bridged |
| `parrot` | Parrot Security OS (alternative pentest distro) | Ephemeral | Bridged |
| `debian` | Clean Debian base (minimal build environment) | Ephemeral | Bridged |
| `archlinux` | Arch Linux (rolling release testing) | Ephemeral | Bridged |
| `wpscan` | WordPress security scanner | Ephemeral | Bridged |
| `nikto` | Web server scanner | Ephemeral | Bridged |
| `nuclei` | Template-based vulnerability scanner | Ephemeral | Bridged |
| `metasploit` | Metasploit Framework exploitation suite | Persistent (`~/.msf4`) | Bridged |
| `zap` | OWASP ZAP GUI (web proxy + scanner) | Ephemeral | Port 8080 |
| `zap-cli` | OWASP ZAP command-line interface | Ephemeral | Port 8080 |

**Usage:**

```bash
kali whoami                # Run command in Kali container
nuclei -target example.com # Run Nuclei scan
metasploit                 # Interactive Metasploit shell (persistent data in ~/.msf4)
zap &                      # Start ZAP GUI on localhost:8080 (background)
```

## Editor Selection — The Scribe's Quill

The editor is chosen via a graceful fallback chain. The first available tool is used:

```
nvim (Neovim 0.11+)
  ↓ (if not found)
vim (Vi Improved)
  ↓ (if not found)
nano (GNU Nano)
```

**Exported as:**
- `$VISUAL` — Preferred editor for interactive use
- `$EDITOR` — Default editor for environment
- `vi` alias — Convenience shortcut

**Why this chain?** Neovim is modern and feature-rich. Vim is universally available. Nano is a fallback for minimal systems.

Each tool is checked with `command -v` before adding to the environment—if it doesn't exist, the next option is tried. This ensures the shell always has a working editor.

## Troubleshooting — Navigating the Dream

### Slow Startup

If the prompt takes longer than 110ms to appear:

```bash
# Measure startup and identify bottlenecks
zsh --startuptime /tmp/zsh.log -i -c exit
sort -k2 -n /tmp/zsh.log | tail -20
```

Look for any module taking >30ms. Common causes:

| Symptom | Cause | Fix |
|---------|-------|-----|
| One module >50ms | Heavy operation at startup | Check for `command -v` guards, lazy-load if possible |
| compinit >30ms | Cache corrupted or missing | `rm ~/.zcompdump && exec zsh` |
| Zinit >20ms | Turbo delays too short | Increase `wait` values in plugin definitions |
| Entire startup >120ms | System overhead | Normal on older hardware; target is achievable on 2020+ systems |

### Missing Command

Check where the command should be registered:

- **Docker aliases (kali, parrot, etc.)** → `zsh.d/alias.zsh`
- **PATH entries (custom bin directories)** → `zsh.d/tools.zsh`
- **Function definitions (helpers, tmux shortcuts)** → `zsh.d/tmux.zsh`
- **External tool completions** → `zsh.d/autocomplete.zsh` (lazy-loaded on first use)

### Completions Not Working

The completion system is cached. If completions are stale or missing:

```bash
# Regenerate completion cache
rm ~/.zcompdump

# Reload shell (applies new completions)
exec zsh

# Or test in a fresh subshell
zsh
```

After rebuilding, tab-complete should work immediately.

---

## Performance Reference

### Startup Timeline (Expected)

```
t=  0ms   Shell process starts (kernel)
t=  2ms   zshrc begins (config, tools, aliases loaded)
t= 10ms   Prompt appears (user can type)
t= 40ms   Compinit finishes
t=  1s    kubectl-prompt loads asynchronously
t=  2s    Autosuggestions + completions available
t=  3s    Syntax highlighting ready
```

**Total:** ~110ms to usable shell, all features ready by 3s.

### Measuring Your System

Standard measurement command:

```bash
time zsh -ic exit
```

Detailed profiling:

```bash
zsh --startuptime /tmp/zsh.log -i -c exit
cat /tmp/zsh.log | head -30       # First modules
sort -k2 -n /tmp/zsh.log | tail -20  # Slowest items
```

### What "Under 110ms" Means

- **0-50ms**: Exceptional (modern hardware, minimal config)
- **50-80ms**: Good (normal development machines)
- **80-110ms**: Acceptable (older systems, more plugins)
- **110-200ms**: Noticeable delay (investigate and optimize)
- **200ms+**: Sluggish (profile for bottlenecks)

### Optimization Strategies

**For startup >110ms:**

1. **Find the bottleneck:**
   ```bash
   zsh --startuptime /tmp/zsh.log -i -c exit
   sort -k2 -n /tmp/zsh.log | grep -v '^\s*0\.' | tail -10
   ```

2. **Lazy-load heavy operations:**
   ```bash
   # Instead of sourcing immediately:
   source ~/.heavy_tool.zsh

   # Defer to on-demand loading:
   lazy_heavy_tool() {
     source ~/.heavy_tool.zsh
     unfunction lazy_heavy_tool
     lazy_heavy_tool "$@"
   }
   ```

3. **Check tool availability once:**
   ```bash
   # Don't check on every startup:
   if command -v slow_tool >/dev/null; then
     # ... setup ...
   fi
   ```

4. **Profile plugin load times:**
   ```bash
   # Temporarily remove Zinit plugins and measure
   # If startup drops >20ms, investigate that plugin
   ```

---

## Reference Material

### File Structure

```
~/.dotfiles/
├── zshrc                 # Entry point (sourced by login shells)
├── zsh.d/
│   ├── config.zsh       # Environment variables
│   ├── tools.zsh        # PATH and editor setup
│   ├── alias.zsh        # Command aliases
│   ├── autocomplete.zsh  # Lazy completions
│   ├── tmux.zsh         # Tmux helpers
│   └── toolbox.zsh      # Docker utilities
├── config/
│   ├── tmux.conf        # Tmux multiplexer
│   ├── kitty.conf       # Kitty terminal
│   └── nvim/            # Neovim editor
└── docs/
    └── zsh.dotfiles.md  # This file
```

### Key Functions and Aliases

Query what's available:

```bash
# List all aliases
alias | grep -E '^(kali|parrot|debian)'

# Find functions
declare -F | grep -i tmux

# Check compdef settings
compdef -l
```

### External References

- [ZSH Manual](http://zsh.sourceforge.net/Doc/)
- [Zinit GitHub](https://github.com/zdharma-continuum/zinit)
- [Drizzt Do'Urden](https://forgottenrealms.fandom.com/wiki/Drizzt_Do%27Urden) (color scheme inspiration)
- [WCAG 2.1 AA/AAA](https://www.w3.org/WAI/WCAG21/quickref/) (accessibility standards)

### Plugin Load Issues

If Zinit plugins fail to load:

```bash
# Check if Zinit is installed
[[ -f ~/.local/share/zinit/zinit.git/zinit.zsh ]] && echo "OK" || echo "MISSING"

# Manually clone if missing (normally automatic)
git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git

# Reload shell
exec zsh
```

### Git Repository Detection Fails

If the RPROMPT doesn't show your git branch:

```bash
# Check if vcs_info is working
zsh -c 'autoload -Uz vcs_info; vcs_info; echo "$vcs_info_msg_0_"'

# If empty, you're not in a git repository or vcs_info isn't loaded
cd /path/to/git/repo && exec zsh
```
