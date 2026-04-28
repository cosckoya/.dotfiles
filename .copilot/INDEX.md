# GitHub Copilot Configuration Index
## Quick Navigation & Search

**Created**: February 17, 2026 | **Status**: ✅ Production Ready  
**Total Files**: 10 | **Total Lines**: 2,288 | **Backup**: `.claude/` directory

---

## 📍 START HERE

1. **New to this config?** → `instructions.md` (Master Guide)
2. **Quick reference?** → `README.md` 
3. **Want examples?** → `skills/` (by domain)
4. **Technical details?** → `agents.yaml`

---

## 📚 File Directory (Alphabetical)

### Core Configuration
| File | Lines | Purpose | Read Time |
|------|-------|---------|-----------|
| **agents.yaml** | 129 | Agent definitions with priorities | 3 min |
| **instructions.md** | 306 | ⭐ Master guide & rules | 10 min |
| **README.md** | 366 | Quick start & reference | 12 min |
| **IMPLEMENTATION_SUMMARY.md** | 387 | This project summary | 8 min |

### Domain Skills
| Skill | Lines | Focus | Token Cost |
|-------|-------|-------|------------|
| shell-performance.md | 89 | ZSH 110ms startup | ~3k |
| modern-makefile.md | 153 | Idempotent Make targets | ~2.5k |
| lua-neovim.md | 194 | Neovim 0.11+ Lua setup | ~4k |
| tmux-modern.md | 217 | Tmux 3.4+ native config | ~2.8k |
| git-precommit.md | 214 | Pre-commit hooks & git workflow | ~2.2k |
| kitty-terminal.md | 233 | GPU-accelerated terminal | ~1.8k |

---

## 🎯 By Use Case

### "I need to optimize ZSH startup"
1. Read: `instructions.md` (Performance section)
2. Reference: `skills/shell-performance.md`
3. Check: Common patterns in `README.md`
4. Validate: Profile with `time zsh -ic exit`

### "I'm creating a Makefile target"
1. Review: `instructions.md` (Code Quality section)
2. Study: `skills/modern-makefile.md`
3. Follow: Common patterns section
4. Test: Run target twice for idempotency

### "I'm configuring Neovim"
1. Check: Agent in `agents.yaml` (neovim-architect)
2. Learn: `skills/lua-neovim.md`
3. Reference: Pattern examples
4. Validate: Startup performance

### "I'm fixing colors/theme"
1. Find: Drizzt Do'Urden color spec in `README.md`
2. Check: Integration points (ZSH/Tmux/Kitty/Neovim)
3. Reference: `skills/kitty-terminal.md` & `skills/tmux-modern.md`
4. Verify: Consistency across all components

### "I need git/quality guidelines"
1. Review: `skills/git-precommit.md`
2. Check: Pre-commit rules in `instructions.md`
3. Reference: Integration section in `README.md`
4. Validate: `pre-commit run --all-files`

### "I'm working on terminal config"
1. Reference: `skills/kitty-terminal.md`
2. Check: Color scheme in `README.md`
3. Review: Integration points
4. Test: Font rendering, colors

---

## 🤖 By Agent

### dotfiles-optimizer (Priority 100)
- **When to use**: Full-stack changes, Makefile, ZSH config
- **Documentation**: `instructions.md` + all skills
- **Default model**: Claude Sonnet 4.1
- **Context**: 200k tokens, up to 50KB files

**Learn more**: `agents.yaml` (lines 4-34)

### shell-performance-expert (Priority 85)
- **When to use**: ZSH startup issues, lazy-loading
- **Documentation**: `skills/shell-performance.md`
- **Default model**: Claude Sonnet 4.1
- **Context**: 120k tokens, up to 20KB files

**Learn more**: `agents.yaml` (lines 37-61)

### neovim-architect (Priority 80)
- **When to use**: Lua config, plugins, LSP
- **Documentation**: `skills/lua-neovim.md`
- **Default model**: Claude Sonnet 4.1
- **Context**: 150k tokens, up to 30KB files

**Learn more**: `agents.yaml` (lines 64-84)

### makefile-master (Priority 75)
- **When to use**: Build targets, installation
- **Documentation**: `skills/modern-makefile.md`
- **Default model**: Claude Sonnet 4.1
- **Context**: 100k tokens

**Learn more**: `agents.yaml` (lines 87-102)

---

## 🎨 Color Reference

### Drizzt Do'Urden Palette
```
Primary   #100814  Deep Cavern (background)
Light     #e0dfe8  Elf White (foreground)
Lavender  #b19cd9  Violet Eyes (accent 1) - 256: 141
IceBlue   #7ec8e3  Twinkle (accent 2) - 256: 117
Green     #5ab897  Drow Magic (accent 3) - 256: 78
Yellow    #f0c987  Magical (accent 4) - 256: 222
Red       #c23b40  Crimson (alert) - 256: 167
Border    #4a5273  Cavern Stone (inactive)
```

Used in: ZSH • Tmux • Kitty • Neovim

---

## ✅ Quick Validation

After **any** change, verify:

```bash
# ZSH startup (target: ~110ms)
time zsh -ic exit

# Makefile idempotency (run twice, same result)
make target
make target

# Pre-commit hooks
pre-commit run --all-files

# No hardcoded paths, guards for tools
grep -r "command -v\|if \[\[\|mkdir -p" <modified-file>
```

---

## 🔗 Integration Checklist

- [ ] ZSH config references `shell-performance.md` patterns
- [ ] Makefile follows `modern-makefile.md` standards
- [ ] Neovim uses `lua-neovim.md` architecture
- [ ] Tmux config matches `tmux-modern.md` patterns
- [ ] Pre-commit configured per `git-precommit.md`
- [ ] Terminal colors unified (Drizzt Do'Urden)
- [ ] All tools guarded with `command -v`
- [ ] Startup time profiled & meets targets

---

## 📊 By Line Count (Largest First)

1. **IMPLEMENTATION_SUMMARY.md** (387 lines) - Project overview
2. **README.md** (366 lines) - Quick reference & usage
3. **instructions.md** (306 lines) - Master guide
4. **kitty-terminal.md** (233 lines) - Terminal GPU acceleration
5. **tmux-modern.md** (217 lines) - Tmux 3.4+ config
6. **git-precommit.md** (214 lines) - Pre-commit hooks
7. **lua-neovim.md** (194 lines) - Neovim Lua patterns
8. **modern-makefile.md** (153 lines) - GNU Make patterns
9. **agents.yaml** (129 lines) - Agent configuration
10. **shell-performance.md** (89 lines) - ZSH optimization

**Total**: 2,288 lines

---

## 🚀 Common Commands

```bash
# View master guide
cat .copilot/instructions.md

# View quick reference
cat .copilot/README.md

# Search for pattern
grep -r "lazy-load" .copilot/skills/

# Check agent config
cat .copilot/agents.yaml | grep -A 15 "dotfiles-optimizer"

# Find color references
grep -r "#100814\|#b19cd9\|#7ec8e3" .copilot/

# View specific skill
cat .copilot/skills/shell-performance.md
```

---

## 📝 Key Concepts

### Token Budget
- Per response: 6,000 tokens
- Context: 100k tokens
- Model: Sonnet 4.1 (default)

### Core Philosophy
- KISS: Simplest solution wins
- Offline: No runtime external deps
- Idempotent: Safe to run multiple times
- Profile: Measure after changes

### Code Quality
- ZSH: 2-space indents, guard tools
- Lua: Minimal init.lua, declarative
- Make: Idempotent, no hardcoded paths
- Git: Pre-commit hooks, atomic commits

### Performance Targets
- ZSH: ~110ms startup
- Tmux: <100ms startup
- Neovim: <500ms startup
- Makefile: <5s for slow targets

---

## 🆘 Troubleshooting

**"Where do I start?"**
→ Read `instructions.md` (Master Guide)

**"How do I use this with Copilot?"**
→ See "By Use Case" section above

**"Which agent handles X?"**
→ Check "By Agent" section or `agents.yaml`

**"I need code examples"**
→ Check "Common Patterns" in `instructions.md` or relevant skill

**"ZSH is slow"**
→ Follow steps in `skills/shell-performance.md`

**"Makefile won't work twice"**
→ Add idempotency patterns from `skills/modern-makefile.md`

**"Colors don't match"**
→ Use Drizzt Do'Urden palette from `README.md`

---

## 📞 File Purposes (One-Liners)

| File | Purpose |
|------|---------|
| agents.yaml | Define agents, priorities, models, contexts |
| instructions.md | Authoritative master guide with absolute rules |
| README.md | Overview, quick reference, examples |
| IMPLEMENTATION_SUMMARY.md | Project summary & file breakdown |
| skills/shell-performance.md | ZSH optimization patterns & profiling |
| skills/modern-makefile.md | GNU Make idempotency & best practices |
| skills/lua-neovim.md | Neovim 0.11+ Lua architecture patterns |
| skills/tmux-modern.md | Tmux 3.4+ native feature configuration |
| skills/git-precommit.md | Pre-commit hooks & git workflows |
| skills/kitty-terminal.md | Kitty GPU-accelerated terminal setup |

---

## 🎓 Recommended Reading Order

**First time?** (45 minutes total)
1. This file (5 min) ← You are here
2. `README.md` (12 min)
3. `instructions.md` (10 min)
4. `skills/shell-performance.md` (3 min)
5. `skills/modern-makefile.md` (5 min)

**Deep dive?** (2+ hours)
- Read all files in order
- Study relevant skills for your focus area
- Reference `agents.yaml` for agent logic

**Quick lookup?**
- Use "By Use Case" section above
- Jump to specific skill file

---

## 🏆 Best Practices Snapshot

✅ Ask before creating files  
✅ Profile ZSH after changes  
✅ Guard all tool checks  
✅ Keep Makefile targets idempotent  
✅ Use Drizzt Do'Urden theme  
✅ Batch edits (max 5 per response)  
✅ Keep responses concise (3 sentences)  
✅ Check for command existence  

---

**Last Updated**: February 17, 2026  
**Config Status**: Production Ready ✅  
**Backward Compatibility**: Maintained ✅  

---

## 🔗 Related Files in Repository

- `CLAUDE.md` - Original documentation (still valid)
- `.claude/` - Previous Claude configuration (reference)
- `Makefile` - Installation orchestrator
- `zshrc` - ZSH entry point
- `config/` - Configuration directory

---

**Questions?** Check `instructions.md` (Master Guide)  
**Examples?** Check relevant skill file in `skills/`  
**Configuration?** Check `agents.yaml`
