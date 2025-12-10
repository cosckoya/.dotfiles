# Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Makefile](https://img.shields.io/badge/Built%20with-Make-blue)](Makefile)
[![tmux](https://img.shields.io/badge/tmux-3.2+-green)](https://github.com/tmux/tmux)
[![ZSH](https://img.shields.io/badge/shell-zsh-blue)](https://www.zsh.org/)

```
                  ,     ,  ._  ,
                _.MMmm.mMm_Mm.MMm_:mMMmmm.._  .
            _ .-mmMMMMMMMMMMMMm:MMm:MMMMMMMMMm._
             `-.mm.MMMMMMM:MMMMMMMmmMMMMMMMMMmm._
          _.mMMMMMmMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"~.
           .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm._
          _.MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm._
       ..mMMMMMMMMMMMMMMMMF"""`:MMMMMMMMMMMMMMMMMMMMmmm.
      _.mmMMMMMMMMMMMMM'    /^  )MMMMMMMMMMMMMMMMMMMMm.
       _.MMMMMMMMMMMM/       JMMMMMMMMMMMMMMMMMMMMMMMMm_
   .mmMMMMMMMMMMMMME/       J,  MMMMMMMMMMMMMMMMMMMMMMMm,
  _.-' _.mMMMMMMMMM/        |:  '::M:MMMMMMMMMMMMMMMM""`
   _,MMMmMMMMMMMMMJ         |_   `:MmmMMMMMMMMMMMMMMMmm.
     _.-'MMMMMMMMF         /M.    .MMmMMMMMMMMMMMMMMMMMM.
    .mmMMMMMMMMMMJ        /MMn:.   `MMMMMMMMMMMMMMMMMMMm.
       .MMMMMMMMJ        /M'        `:::'MMMMMMMMMMMMMMM:
    ,MMMmMMMMMMF         |:   _.._    '   MMMMMMMMMMMMmm.
   ,ME:MMMMMMMM|         J               7_MMMMMMMMM:Mm_
   !M:MmmMMMMMM|        /     _____     _JMMMMMMMMMm:MMm.
   '':mMMMMMMMMJ        |    `"==="`    /dMMMMMMMMMMM:'Mm.
    ':MMM:MMMMF        J\              /MMMMMM:MMMMMMm: `
   .M:MMM:MMMM|        |E`.   .   .  ,'MMMMMMM:MMMMMMMm
     .Mm:mMMMMJ        |M| `.      .' |MMMMMMm:.MMMMM.
    .Mm:mMMMM/         |M|   `----':: |MMMMMMMmm`MMMMMm.
      !:mMMM/          /M|      ::::. |MMMMMMMMMMM``mMm.
        !MMJ          |MM|      .:::. |MMMMMMMMMMMMM.._
        MMF           /M/       ::::'  \MMMMMMMMMMMMMMm,
       .mM|          /MMm.       '     .`".MMMMMMMMMMMMm.
        !!J         / b:.:..     ,  ,   .. M.".MMMMMMMMm.
         F         .:`.m,  ..           ..`M.   `"".MMMmm.
         |          .`  b.   ..         ..  `M        `.M!
         |         .:   `b    ..        ..   M           \
         `       ..:     M,   ..         ..  M.           |
          |     :::,     `M,   ..        ..  `M           \
          |      .'       `M    ..       ..   M.           |
          `                M.    ..      ..   `M    ,      \
           |               .M.    ..     ..    M   Y        |
           `              .dMb.    ..   ..     M.  |        |
            \            dMMMMMMb.  ':. ::     M.  |        \
             Y        .dMMMMMMMMMMMb.::_::___.dMMb |         |
             |      .dMMMMMMMMMMMMMMMMM::MMMMMMMMMb/         |
             :.....dMMMMMMMMMMMMMMMMMMM::MMMMMMMMMMM\        |
              MMMMMMMMMMMMMMMMMMMMMMMMp""qMMMMMMMMMM \       `
              `MMMMMMMMMMMMMMMMMMMMMMM:QD:MMMMMMMMMM  \       |
               `MMMMMMMMMMMMMMMMMMMMMMb.:dMMMMMMMMMP  |       |
                `MMMMMMMMMMMMMMMMMMM::::::::MMMMMMF   |       `
                 MMMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM    |        `
                 `MMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM    :         |
                  MMMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM     \        |
                  `MMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM      |       `
                   MMMMMMMMMMMMMMMMMMMM.:MMMMMMMMM      `        .
                   `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                   .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       |        |
                   dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM       `        |
                 .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        .       |
                .dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        |       |
```

<p align="center"><em>Self-contained Linux development environment</em></p>

---

## About

Production-ready dotfiles for Linux development environments. Self-contained, offline-capable, and optimized for performance.

**Key Features:**
- One-command setup via Makefile
- Works completely offline (no internet required)
- Optimized tmux config (93% smaller, 10x faster)
- Modular ZSH configuration
- Beautiful terminal with Powerline theming
- Smart tmux auto-start (IDE, SSH, and desktop-aware)

---

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install everything
make all

# Or install specific components
make profile    # ZSH, Tmux, Neovim configs
make asdf       # ASDF version manager
make tools      # Development tools (pre-commit, checkmake, cheat)
```

View all available targets:
```bash
make help
```

---

## What's Included

### Core Configuration
- **ZSH** - Modern shell with Zinit plugin manager, auto-completion, syntax highlighting
- **Tmux** - Terminal multiplexer with optimized config (129 lines vs 1889 original)
- **Neovim** - Enhanced Vim configuration
- **Kitty** - GPU-accelerated terminal emulator config

### Tools & Utilities
- **ASDF** - Version manager for multiple languages
- **pre-commit** - Git hooks for code quality
- **checkmake** - Makefile linter
- **cheat** - Command-line cheat sheets

### Configuration Structure
```
.dotfiles/
├── Makefile              # Main installer
├── zshrc                 # ZSH entry point
├── zsh.d/                # Modular ZSH configs
│   ├── alias.zsh         # Command aliases
│   ├── autocomplete.zsh  # Auto-completion
│   ├── config.zsh        # User settings
│   ├── tmux.zsh          # Tmux integration
│   ├── toolbox.zsh       # Utility functions
│   └── tools.zsh         # Tool initialization
├── tmux.conf             # Optimized tmux config
├── tmux.local            # Personal tmux overrides
├── vimrc                 # Neovim configuration
├── kitty/                # Kitty terminal config
└── tools/                # Development tools
    ├── Makefile          # Tools installer
    └── cheats/           # Cheat sheets
```

---

## Technologies

**Shell & Terminal:**
- [ZSH](https://www.zsh.org/) - Modern shell
- [Zinit](https://github.com/zdharma-continuum/zinit) - Fast plugin manager
- [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer
- [Kitty](https://sw.kovidgoyal.net/kitty/) - GPU terminal emulator

**Version Management:**
- [ASDF](https://asdf-vm.com/) - Universal version manager

**Development Tools:**
- [pre-commit](https://pre-commit.com/) - Git hooks framework
- [cheat](https://github.com/cheat/cheat) - Command cheat sheets

**Build System:**
- [GNU Make](https://www.gnu.org/software/make/) - Build automation
