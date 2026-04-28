# Troubleshooting

## ZSH Startup Slow

**Problem:** Shell takes >150ms to show prompt.

**Diagnosis:**
```bash
zsh --startuptime /tmp/zsh.log -i -c exit
sort -k2 -n /tmp/zsh.log | tail -20
```

Look for sources taking >10ms.

**Common causes:**

- **Heavy plugin loading:** Check `zshrc` for plugins without `wait` delays
  - Solution: Add `wait"N"` to Zinit ice parameters
- **Compinit cache stale:** Cache older than 1 day triggers regeneration
  - Solution: `rm ~/.zcompdump && exec zsh`
- **PATH too long:** Many directories in `$PATH` slow shell startup
  - Solution: Remove unused paths from `zsh.d/tools.zsh`

## Missing Commands

**Problem:** Command not found when trying to use tool alias (e.g., `kali`, `wpscan`).

**Diagnosis:**
```bash
which kali                  # check if alias is defined
echo $PATH                  # verify PATH is correct
docker images kalilinux     # verify image exists locally
```

**Solutions:**

- **Docker not installed:** `sudo apt install docker.io`
- **Docker image missing:** `docker pull kalilinux/kali-rolling`
- **Alias not loaded:** `exec zsh` to reload shell
- **Docker daemon not running:** `sudo systemctl start docker`

## Tmux Not Auto-starting

**Problem:** Shell starts but Tmux doesn't attach.

**Diagnosis:**
```bash
echo $TMUX_AUTOSTART_ENABLED
echo $TMUX_SKIP_IDE
echo $TMUX_SKIP_SSH
echo $INSIDE_EMACS              # if in Emacs
echo $VSCODE_PID                # if in VSCode
```

**Solutions:**

- **Auto-start is disabled:** `export TMUX_AUTOSTART_ENABLED="true"` and `exec zsh`
- **Inside IDE:** Set `TMUX_SKIP_IDE="false"` in `zsh.d/config.zsh`
- **Inside SSH:** Set `TMUX_SKIP_SSH="false"` in `zsh.d/config.zsh`
- **Tmux not installed:** `sudo apt install tmux`

## Tmux Colors Wrong

**Problem:** Colors appear muted or wrong in Tmux.

**Diagnosis:**
```bash
echo $TERM                          # should be tmux-256color
tmux -L test-session new           # test with fresh session
```

**Solutions:**

- **Terminal not 256-color:** Set `export TERM=xterm-256color` before launching tmux
- **Kitty not recognized:** Ensure `config/tmux.conf` includes Kitty terminal-features
- **Neovim colors differ:** This is expected — Neovim uses tokyonight theme, not tmux palette

## Neovim LSP Not Working

**Problem:** Autocomplete doesn't trigger, hover doesn't show documentation.

**Diagnosis:**
```bash
nvim test.py
:LspInfo                            # check LSP status
:MasonToolsInstall                  # verify servers installed
:checkhealth                        # full health check
```

**Solutions:**

- **Neovim version wrong:** `nvim --version` should show 0.11+. If not, `make install-nvim`
- **Language server not installed:** `:MasonInstall pyright` (or relevant server)
- **Filetype not recognized:** `:set filetype=python` manually
- **Plugin cache stale:** `rm -rf ~/.local/share/nvim/lazy && nvim`

## Completions Not Working

**Problem:** No autocomplete suggestions when typing ZSH commands.

**Diagnosis:**
```bash
rm ~/.zcompdump
exec zsh
echo $fpath                         # verify completion paths
```

**Solutions:**

- **Compinit cache corrupted:** Delete and regenerate: `rm ~/.zcompdump && exec zsh`
- **Completions not installed:** Run `compinit` manually
- **Tool completions missing:** Check `zsh.d/autocomplete.zsh` for kubectl/helm/kind support

## Kitty Font Issues

**Problem:** Special characters or Nerd Font icons don't render.

**Solutions:**

- **Font not installed:** `sudo apt install fonts-jetbrains-mono fonts-nerd-font-jetbrains-mono`
- **Font name wrong in config:** Edit `config/kitty.conf`:
  ```
  font_family JetBrains Mono Nerd Font
  ```
- **Ligatures disabled:** Edit `config/kitty.conf`:
  ```
  disable_ligatures never
  ```

## Symlinks Not Working

**Problem:** After running `make zsh`, changes to `zshrc` don't take effect.

**Diagnosis:**
```bash
ls -l ~/.zshrc                      # verify it's a symlink
readlink ~/.zshrc                   # see where it points
cat ~/.zshrc | head -5              # verify content
```

**Solutions:**

- **Symlink broken:** `make zsh` again (idempotent, replaces broken links)
- **Shell cached old config:** `exec zsh` to reload
- **File permissions:** `chmod 644 ~/.zshrc`

## Git Hooks Failing

**Problem:** Commit blocked by pre-commit hooks with syntax errors.

**Solutions:**

- **Install hooks:** `pre-commit install` (one-time setup)
- **Bypass hooks (emergency):** `git commit --no-verify` (not recommended)
- **Fix manually:** Check error message and fix the file
- **See which hooks failed:** `git commit -v` shows verbose output

Common failures:

- **YAML syntax:** Fix YAML indentation in `.github/` files
- **Makefile syntax:** Check for tabs (not spaces) in Makefile targets
- **Trailing whitespace:** `sed -i 's/[[:space:]]*$//' <file>`
- **Mixed line endings:** `dos2unix <file>`

## Getting Help

1. Check [Getting Started](./getting-started.dotfiles.md) — most issues are answered there
2. Check [Architecture Overview](./architecture.dotfiles.md) — understand how components interact
3. Run diagnostics:
   ```bash
   zsh --version
   tmux -V
   nvim --version
   kitty --version
   ```
4. Verify after each fix:
   ```bash
   exec zsh                           # reload shell
   time zsh -ic exit                  # check startup time
   ```
