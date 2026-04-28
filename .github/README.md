# GitHub Copilot Configuration

This directory contains GitHub Copilot configuration for the Modern Linux Dotfiles project.

## 📚 Documentation

**All Copilot guidance is in a single, comprehensive file:**

### [`copilot/README.copilot.md`](./copilot/README.copilot.md) ⭐ **START HERE**
Complete reference covering:
- Quick start guide
- 6 mandatory principles (KISS, DRY, Clean Code, YAGNI, SOLID)
- Architecture & conventions
- Software engineering methodology with examples
- Build & test commands
- Copilot integration guidelines
- Implementation checklist
- FAQ & troubleshooting

### [`copilot-instructions.md`](./copilot-instructions.md)
Project-specific quick reference with:
- Core principles overview
- High-level architecture
- Key conventions for Makefile, ZSH, Neovim, Lua
- Project constraints (110ms startup, offline-capable, idempotent)
- When to ask for user input

---

## 🎯 Quick Navigation

**Just getting started?**  
→ Read [`copilot/README.copilot.md`](./copilot/README.copilot.md#quick-start)

**Need specific examples?**  
→ See relevant section in [`copilot/README.copilot.md`](./copilot/README.copilot.md#architecture--conventions)

**About to submit code?**  
→ Check [`copilot/README.copilot.md`](./copilot/README.copilot.md#implementation-checklist)

**Have a question?**  
→ Check [`copilot/README.copilot.md`](./copilot/README.copilot.md#faq--troubleshooting)

---

## 📋 Six Mandatory Principles

1. **KISS** — Keep It Simple, Stupid
2. **DRY** — Don't Repeat Yourself
3. **Clean Code** — Meaningful names, small functions, self-documenting
4. **YAGNI** — You Ain't Gonna Need It (no over-engineering)
5. **SOLID** — Single Responsibility, Open/Closed, Liskov, Interface Segregation, Dependency Inversion

All are **mandatory**. No exceptions.

---

## 📁 Structure

```
.github/
├── README.md                    (this file)
├── copilot-instructions.md      (quick reference)
└── copilot/
    ├── README.copilot.md        (comprehensive guide)
    ├── agents.yaml              (custom agent definitions)
    └── skills/                  (deep-dive guides)
        ├── shell-performance.md
        ├── lua-neovim.md
        ├── tmux-modern.md
        ├── kitty-terminal.md
        ├── modern-makefile.md
        └── git-precommit.md
```

---

## ✨ Key Points

- ✅ **One comprehensive file** (`copilot/README.copilot.md`) covers all guidance
- ✅ **Table of contents** for easy navigation
- ✅ **Real-world examples** for Shell, ZSH, Lua, Makefile
- ✅ **Implementation checklist** before submitting code
- ✅ **FAQ section** for common questions
- ✅ **Skill guides** in `copilot/skills/` for deep dives by topic

---

## 🚀 For Copilot Sessions

When working on this project:

1. **Reference** [`copilot/README.copilot.md`](./copilot/README.copilot.md) for all guidance
2. **Apply** all 6 principles to your code
3. **Check** implementation checklist before submitting
4. **Ask:** "Does this follow Clean Code / YAGNI / SOLID?"

---

**Status:** ✅ READY FOR PRODUCTION  
**Updated:** 2026-02-17  
**Standard:** GitHub Copilot 2026 Best Practices
