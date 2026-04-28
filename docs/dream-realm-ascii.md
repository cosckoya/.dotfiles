# The Dream Realm — Visual Architecture

> *"Some people think the physical world is the only true reality. But actually, as any neuroscientist will tell you, the world we experience is nothing more than a perceptual model created by the brain."* — Morpheus, The Matrix

This document provides visual ASCII diagrams of the ZSH shell architecture, inspired by the Dream realm from Neil Gaiman's *Sandman*.

---

## The Seven Sanctums (Modular Architecture)

```
╔══════════════════════════════════════════════════════════════════╗
║                    REALM CORE: zshrc                             ║
║         (Entry point orchestrating all sanctums)                 ║
╚══════════════════════════════════════════════════════════════════╝
                                 │
                 ┌───────────────┼───────────────┐
                 │               │               │
        ┌────────▼─────┐ ┌──────▼──────┐ ┌─────▼────────┐
        │ SANCTUM ONE   │ │ SANCTUM TWO │ │ SANCTUM THREE│
        │   config.zsh  │ │  tools.zsh  │ │  alias.zsh   │
        │ (Setup Realm) │ │ (Pathfinding)│ │(Incantations)│
        └───────────────┘ └─────────────┘ └──────────────┘
                 │               │               │
        ┌────────▼─────┐ ┌──────▼──────┐ ┌─────▼────────┐
        │ SANCTUM FOUR  │ │ SANCTUM FIVE │ │ SANCTUM SIX  │
        │  alias.zsh    │ │  tmux.zsh    │ │ toolbox.zsh  │
        │ (Wrappers)    │ │(Portal Layer)│ │(Artifacts)   │
        └───────────────┘ └──────────────┘ └──────────────┘
                 │               │               │
                 └───────────────┼───────────────┘
                                 │
                                 ▼
        ┌────────────────────────────────────────┐
        │ SANCTUM SEVEN: autocomplete.zsh        │
        │        (Whispers of Knowledge)         │
        │    (Lazy-loaded on first invocation)   │
        └────────────────────────────────────────┘
                                 │
                 ┌───────────────┴───────────────┐
                 │                               │
        ┌────────▼─────┐              ┌────────▼────────┐
        │ COMPINIT      │              │   ZINIT PLUGINS │
        │  (Archive)    │              │ (Async Summons) │
        └───────────────┘              └────────────────┘
                 │                            │  │  │  │
                 │                    ┌───────┘  │  │  └─────────┐
                 │                    │          │  │            │
                 │         ┌──────────┴──┐   ┌──┴──▼──┐   ┌──────┴──┐
                 │         │ kubectl-   │   │ auto-  │   │ syntax- │
                 │         │ prompt (1s)│   │suggest │   │highlight│
                 │         │            │   │(2s)    │   │(3s)     │
                 │         └────────────┘   └────────┘   └─────────┘
                 │
                 ▼
        ┌────────────────────────────────────┐
        │ PROMPT RENDERED                    │
        │ ┌──(hostname の user)              │
        │ └─#                                │
        │          [git/k8s/venv info RPMT]  │
        └────────────────────────────────────┘
```

---

## Timeline: From Darkness to Awakening

```
The Journey from Sleep to Consciousness (Startup Timeline)

     t = 0ms
     ║
     ║ Shell kernel starts
     ║
     ▼ t = ~2ms
     zshrc loads (entry point begins)
       │
       ├─ config.zsh loads    (~2ms, realm setup)
       ├─ tools.zsh loads     (~5ms, PATH/editor)
       ├─ alias.zsh loads     (~1ms, incantations)
       ├─ tmux.zsh loads      (~1ms, portal)
       ├─ toolbox.zsh loads   (~1ms, artifacts)
       │
       ▼ t = ~10ms
     PROMPT APPEARS ◄─── YOU CAN START TYPING
       ├─ compinit caches    (~30ms, background)
       └─ autocomplete ready  (~5ms, background)

       │
       ├─ t = 1s  : kubectl-prompt async loads
       │           (RPROMPT shows k8s context)
       │
       ├─ t = 2s  : autosuggestions + completions ready
       │           (fish-style suggestions available)
       │
       └─ t = 3s  : syntax-highlighting loaded
                   (colored input enabled)

TOTAL TIME: ~110ms to usable prompt
            + 2.9s more for all features ready
```

---

## The Prompt: Bridge Between Realms

```
Left Side (Identity)               Right Side (Context)
┌──(hostname の user)               (main) ~/.venv kube-prod
└─#                                 [Git] [Python] [Kubernetes]

Breaking it down:

┌─────────────────────────────────┐ ┌─────────────────────┐
│ LPROMPT (Left Prompt)           │ │ RPROMPT             │
├─────────────────────────────────┤ ├─────────────────────┤
│ ┌── = lavender top border       │ │ (main) = git branch │
│ │  = lavender corner             │ │        (icy blue)   │
│ (hostname = icy blue             │ │ ~/.venv = py venv   │
│  の = yellow separator           │ │ kube-prod = k8s     │
│  user = red                      │ │ [or fallback msg]   │
│ ──┐ = lavender bottom-right      │ │                     │
│ └─# = lavender bottom-left + #  │ │ Updates every 300ms │
└─────────────────────────────────┘ └─────────────────────┘

COLORS USED (Drizzt Do'Urden Palette):
  Lavender (141) = Borders, realm markers
  Icy Blue (117) = Git branch, hostname (trust)
  Red (167)      = Username (energy)
  Yellow (222)   = Separator, fallback (attention)
  Green (78)     = Kubernetes context (drow magic)
```

---

## The Sacred Tools (Docker Aliases)

```
┌─────────────────────────────────────────────────────────────┐
│ EPHEMERAL SANCTUMS (Docker Containers)                     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Isolation Layer                                             │
│  ┌────────────────────────────────────────────────────┐    │
│  │ kali            (Kali Linux pentest suite)         │    │
│  │ parrot          (Parrot Security OS)               │    │
│  │ debian          (Clean Debian minimal)             │    │
│  │ archlinux       (Arch rolling release)             │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  Security Tools Layer                                        │
│  ┌────────────────────────────────────────────────────┐    │
│  │ wpscan          (WordPress scanner)                │    │
│  │ nikto           (Web server scanner)               │    │
│  │ nuclei          (Template-based scanner)           │    │
│  │ metasploit      (Exploitation framework)           │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  Web Security Layer                                          │
│  ┌────────────────────────────────────────────────────┐    │
│  │ zap             (OWASP ZAP GUI on :8080)           │    │
│  │ zap-cli         (OWASP ZAP CLI)                    │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│ All containers:                                              │
│   • Ephemeral (no lingering state)                          │
│   • Bridged networking (access to host)                     │
│   • Mount current directory as /hack                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘

EXAMPLE USAGE:

  kali whoami                    # Run inside Kali
  nuclei -target example.com     # Run Nuclei scan
  metasploit                     # Interactive exploit framework
  zap &                          # GUI proxy on localhost:8080
  nikto -h example.com           # Nikto web scan
```

---

## Knowledge Architecture: Rules → Docs → Skills → Code

```
┌────────────────────────────────────────────────────────────────┐
│ THE KNOWLEDGE PYRAMID                                          │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│                          ▲                                      │
│                         ╱ ╲                                     │
│                        ╱   ╲  RULES (Universal, Authoritative) │
│                       ╱     ╲ ~/.claude/rules/                 │
│                      ╱───────╲                                  │
│                     ╱         ╲                                 │
│                    ╱           ╲ DOCUMENTATION (This)           │
│                   ╱             ╲ docs/ (Technical Reference)   │
│                  ╱───────────────╲                              │
│                 ╱                 ╲                             │
│                ╱                   ╲ SKILLS (Domain Expertise)  │
│               ╱                     ╲ .claude/skills/           │
│              ╱───────────────────────╲                          │
│             ╱                         ╲                         │
│            ╱                           ╲ CODE (Implementation)   │
│           ╱────────────────────────────╲ zsh.d/ config/         │
│          ╱                               ╱                      │
│         ╱_____________________________╱                         │
│                                                                 │
│ Direction of Authority:  Rules ──> Docs ──> Skills ──> Code   │
│                          (most abstract to most specific)       │
│                                                                 │
│ Examples:                                                       │
│   Rules        : "2-space indents in shell scripts"            │
│   Docs         : "See zsh.dotfiles.md for module details"      │
│   Skills       : /shell-optimizer identifies indent violations │
│   Code         : zsh.d/*.zsh files use 2-space indents         │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## Flow: When You Type a Command

```
USER TYPES: nuclei -target example.com
                   │
                   ▼
        ┌──────────────────────┐
        │ ZSH Parser           │
        │ - checks aliases     │ ──► Found: nuclei alias
        │ - checks functions   │
        │ - checks commands    │
        └──────────────────────┘
                   │
                   ▼
        ┌──────────────────────────────────┐
        │ alias.zsh: nuclei               │
        │ → docker run -it nuclei          │
        │ → container name: nuclei-123456  │
        └──────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────────────────┐
        │ Docker Container Spawns          │
        │ - name: nuclei-{timestamp}       │
        │ - mount: $PWD :/hack             │
        │ - network: bridged               │
        │ - remove: on exit                │
        └──────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────────────────┐
        │ Nuclei Scanner Runs              │
        │ -target example.com              │
        │ → templates scan website         │
        │ → returns vulnerabilities        │
        └──────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────────────────┐
        │ Container Exits & Cleans Up      │
        │ - stdout → terminal              │
        │ - no local filesystem cruft      │
        │ - memory freed                   │
        └──────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────────────────┐
        │ Prompt Returns (LPROMPT + RPMT)  │
        │ ┌──(hostname の user) (main)     │
        │ └─#                              │
        └──────────────────────────────────┘
```

---

## Performance Budget Allocation

```
ZSH Startup Performance Budget (110ms Target)

┌────────────────────────────────────────────────────────┐
│                    110ms Total                          │
├────────────────────────────────────────────────────────┤
│                                                         │
│  config.zsh         [██]      ~2ms    (1.8%)          │
│  tools.zsh          [██████]  ~5ms    (4.5%)          │
│  alias.zsh          [█]       ~1ms    (0.9%)          │
│  tmux.zsh           [█]       ~1ms    (0.9%)          │
│  toolbox.zsh        [█]       ~1ms    (0.9%)          │
│  autocomplete.zsh   [█]       ~1ms    (0.9%)          │
│  ─────────────────────────────────────────             │
│  Module Subtotal    [████████] ~11ms  (10%)           │
│                                                         │
│  compinit caching   [███████████████] ~30ms  (27%)    │
│  System overhead    [█████████████████████████]        │
│                     ~60ms                 (54%)        │
│  ─────────────────────────────────────────             │
│  TOTAL              [████████████████████] 110ms       │
│                                                         │
│ Async (don't block):                                   │
│   kubectl-prompt    (1s later)                         │
│   autosuggestions   (2s later)                         │
│   syntax-highlight  (3s later)                         │
│                                                         │
└────────────────────────────────────────────────────────┘

If any module exceeds 30ms:
  1. Identify the slow module
  2. Check for external command invocations
  3. Move expensive operations to lazy-loading
  4. Re-measure: zsh --startuptime /tmp/z.log && sort -k2 -n /tmp/z.log
```

---

## The Drizzt Do'Urden Aesthetic

```
The color scheme derives from the Drow ranger's palette:

┌──────────────────────────────────────────────────────┐
│ DRIZZT DO'URDEN COLOR PALETTE                       │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Lavender #b19cd9       (Underdark mystique)        │
│  ███████████████████████                            │
│   └─ ZSH Code: 141                                  │
│   └─ Used: Borders, realm markers, LPROMPT         │
│                                                      │
│  Icy Blue #7ec8e3       (Twinkle's winter gaze)     │
│  ███████████████████████                            │
│   └─ ZSH Code: 117                                  │
│   └─ Used: Git branch (RPROMPT), hostname          │
│                                                      │
│  Drow Green #5ab897      (Drow magic)               │
│  ███████████████████████                            │
│   └─ ZSH Code: 78                                   │
│   └─ Used: Kubernetes context (RPROMPT)            │
│                                                      │
│  Yellow #f0c987         (Warning/attention)         │
│  ███████████████████████                            │
│   └─ ZSH Code: 222                                  │
│   └─ Used: Separator (の), fallback message         │
│                                                      │
│  Red #d35d6e            (Guenhwyvar's collar)       │
│  ███████████████████████                            │
│   └─ ZSH Code: 167                                  │
│   └─ Used: Username (LPROMPT), errors              │
│                                                      │
│ ACCESSIBILITY: All colors meet WCAG AAA 7:1         │
│ contrast minimum against #100814 background.        │
│                                                      │
└──────────────────────────────────────────────────────┘
```

---

## File Organization at a Glance

```
~/.dotfiles/
│
├─ zshrc                           Entry point (bootstrap)
│  └─ loads all modules in sequence
│
├─ zsh.d/                          Seven sanctums
│  ├─ config.zsh                   (Realm setup)
│  ├─ tools.zsh                    (Path/editor)
│  ├─ alias.zsh                    (Docker incantations)
│  ├─ autocomplete.zsh             (Lazy completions)
│  ├─ tmux.zsh                     (Portal helpers)
│  └─ toolbox.zsh                  (Docker utilities)
│
├─ config/                         System configs
│  ├─ tmux.conf                    (Multiplexer)
│  ├─ kitty.conf                   (Terminal)
│  └─ nvim/                        (Editor)
│      ├─ init.lua                 (Entry)
│      ├─ lazy-lock.json           (Plugins locked)
│      └─ lua/                     (Config modules)
│
├─ docs/                           Technical reference
│  ├─ README.md                    (Start here)
│  ├─ zsh.dotfiles.md              (This topic)
│  ├─ tmux.dotfiles.md             (Multiplexer)
│  ├─ color-scheme.dotfiles.md     (WCAG compliance)
│  └─ architecture.dotfiles.md     (Design decisions)
│
├─ Makefile                        Installation script
├─ .pre-commit-config.yaml         Git hooks
└─ mise.toml                       Runtime versions
```

---

## Summary: The Dream, Understood

```
THE CORE PRINCIPLES:

1. MODULAR         Each module is independent. Load what you need.
2. FAST            Prompt in 110ms, all features by 3s.
3. GRACEFUL        Missing tools don't break the shell.
4. BEAUTIFUL       Drizzt palette with WCAG AAA accessibility.
5. ISOLATED        Docker aliases = no local installation mess.
6. LAZY            Completions and plugins load on-demand.
7. DOCUMENTED      Every decision recorded and explained.

"The realm of Dream is a place of infinite possibility,
 where chaos and order dance in eternal balance."

This shell architecture embodies that principle:
   - Structured yet flexible (order + chaos)
   - Fast yet feature-rich (responsiveness + capability)
   - Isolated yet integrated (safety + connectivity)
   - Beautiful yet practical (aesthetics + function)
```

---

**Last Updated:** 2026-04-28
**Theme Inspiration:** Drizzt Do'Urden, Sandman by Neil Gaiman
**Reference:** [zsh.dotfiles.md](./zsh.dotfiles.md)
