# Architecture Overview

Design decisions, performance targets, and module interactions.

## Design Principles

**Offline-first:** All tools and plugins are installed locally. No runtime external dependencies.

**Modular:** Each component (ZSH, Tmux, Kitty, Neovim) can be installed independently via `make [target]`.

**Symlink-based:** Dotfiles are symlinked from the repository, not copied. Changes take effect immediately.

**Startup performance:** Target is under 110ms for ZSH prompt appearance. Achieved through:
- Async plugin loading (Zinit turbo mode)
- Lazy-loaded completions (self-removing wrappers)
- Compinit cache invalidation (daily)
- Aggressive tool checks (early exit if tool missing)

**Graceful fallbacks:** Every tool check uses `command -v` before use. Missing tools do not block shell startup.

## Directory Layout

```
~/.dotfiles/
├── Makefile                 # symlink installer
├── zshrc                    # ZSH entry point
├── zsh.d/                   # modular ZSH configs
│   ├── config.zsh           # user variables
│   ├── tools.zsh            # PATH, editor
│   ├── alias.zsh            # aliases and Docker
│   ├── autocomplete.zsh     # lazy completions
│   ├── tmux.zsh             # tmux helpers
│   └── toolbox.zsh          # Docker dev environment
├── config/
│   ├── tmux.conf            # Tmux 3.4+ config
│   ├── kitty.conf           # Kitty terminal config
│   └── nvim/
│       ├── init.lua         # Neovim bootstrap
│       └── lua/
│           ├── core/        # options, keymaps, autocmds
│           └── plugins/     # LSP, completion, UI, editor
├── docs/                    # technical documentation
├── .github/                 # GitHub config and CI
├── pre-commit-config.yaml   # git hooks
└── img/                     # visual assets
```

## Installation Mechanics

`make [target]` creates symlinks:

```
Repo file              → Symlink
──────────────────────────────────
zshrc                  → ~/.zshrc
zsh.d/                 → ~/.zsh.d
config/tmux.conf       → ~/.tmux.conf
config/kitty.conf      → ~/.config/kitty/kitty.conf
config/nvim/           → ~/.config/nvim
vimrc                  → ~/.vimrc
```

All targets are idempotent — safe to re-run. Symlinks are replaced if they point elsewhere.

## ZSH Startup Flow

1. Load `zsh.d/config.zsh` (env vars, ~1ms)
2. Tmux auto-start logic (if enabled, ~5ms)
3. Zinit bootstrap (if git available, ~10ms)
4. History and shell options (~2ms)
5. Load tool modules (`tools.zsh`, `alias.zsh`, etc., ~15ms)
6. Setup prompt and vcs_info (~5ms)
7. Compinit cache check and load (~20ms)
8. Async Zinit plugins start loading (non-blocking, ~30ms later)
9. Final setup and ready for prompt (~5ms)

Total: ~60–70ms synchronous + ~30–40ms async = ~110ms visible startup.

## Tmux Auto-start Context

Smart conditional logic in `zshrc` checks:

- Is tmux available?
- Is `TMUX_AUTOSTART_ENABLED` true?
- Are we in an SSH session? (skip if `TMUX_SKIP_SSH=true`)
- Are we in an IDE terminal? (skip if `TMUX_SKIP_IDE=true`)
- Are we in a desktop environment? (skip if `TMUX_SKIP_DESKTOP=true`)

If all checks pass, attach to named session or create it.

## Neovim Plugin Management

lazy.nvim lazy-loads plugins on command/filetype/key. Startup sequence:

1. Bootstrap lazy.nvim (if not installed, ~2s first launch)
2. Load core options/keymaps (~10ms)
3. lazy.setup() scans `lua/plugins/` (~20ms)
4. Plugins remain dormant until triggered (~0ms)
5. On first Lua file: Mason detects missing servers and installs (~30s first time, then cached)
6. LSP activates via `FileType` autocommand

## Performance Targets

| Component | Target | Current | Status |
|-----------|--------|---------|--------|
| ZSH startup | <110ms | ~110ms | ✓ |
| Tmux startup | <100ms | ~50ms | ✓ |
| Neovim startup | <500ms | ~300ms | ✓ |
| Compinit cache | daily | yes | ✓ |
| Pre-commit hooks | <5s | <2s avg | ✓ |

## Color Scheme Integration

Single Drizzt Do'Urden palette applied consistently across all components. See [Color Scheme](./color-scheme.dotfiles.md) for full specs and lore.

Tools define colors at startup via:
- ZSH: 256-color codes (`%F{141}` for lavender)
- Tmux: Hex codes (`#b19cd9`)
- Kitty: Hex codes
- Neovim: Hex codes via tokyonight theme

## Security

Pre-commit hooks validate on every commit:

- No private keys (`detect-private-key`)
- No merge conflicts
- Valid YAML and Makefile syntax
- LF line endings (no mixed CRLF)
- Trailing whitespace removed

Hooks are installed automatically via `pre-commit install` (not yet automated in Makefile — manual step).

## Extensibility

**Add a ZSH alias:**
Edit `zsh.d/alias.zsh`, add function or alias. Sourced automatically.

**Add a language server:**
Edit `config/nvim/lua/plugins/lsp.lua`, add to `servers` list. Mason installs on next launch.

**Add a Tmux binding:**
Edit `config/tmux.conf`, add bind command. Live reload with `tmux source ~/.tmux.conf`.

**Add a Kitty keybinding:**
Edit `config/kitty.conf`, add map command. Live reload with `Ctrl+Shift+F5`.
