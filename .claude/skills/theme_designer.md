---
name: theme-designer
description: Expert in color theory, theme coherence, and design systems for terminal environments. Analyzes color consistency across ZSH, tmux, Kitty, and Neovim. Applies color psychology principles and searches for color schemes online. Use when reviewing theme coherence, selecting color palettes, or designing unified visual experiences.
---

# Theme Designer & Color Coherence Expert Skill

Specialist in color theory, theme design, and visual coherence across terminal environments.

## Core Competencies

### Color Theory & Psychology
- Color harmony and complementary palettes
- Psychology and emotional impact of colors
- Accessibility and contrast ratios (WCAG compliance)
- Color blindness considerations (protanopia, deuteranopia, tritanopia)
- Cultural color associations
- Semantic color usage (success, warning, error, info)

### Theme Design
- Creating cohesive color schemes across tools
- Adapting existing themes to terminal environments
- Balancing aesthetics with readability
- Dark and light theme variants
- Accent color selection and usage
- Brand consistency in personal environments

### Technical Implementation
- Terminal color codes (16-color, 256-color, true color/RGB)
- ANSI escape sequences
- Hex, RGB, and HSL color formats
- Color conversion between formats
- Theme file formats (JSON, YAML, conf)
- Dynamic theme switching

## Color Psychology Principles

### Emotional Associations

**Warm Colors:**
- **Red** (#CC241D, #FB4934): Energy, urgency, errors, danger, passion
  - Use for: Error messages, alerts, destructive actions
  - Avoid: Large backgrounds, long reading sessions

- **Orange** (#D65D0E, #FE8019): Enthusiasm, creativity, warnings
  - Use for: Warnings, highlights, notifications
  - Avoid: Overuse can be distracting

- **Yellow** (#D79921, #FABD2F): Optimism, attention, caution
  - Use for: Warnings, search highlights, current selection
  - Avoid: Pure yellow on white (low contrast)

**Cool Colors:**
- **Green** (#98971A, #B8BB26): Success, growth, nature, stability
  - Use for: Success messages, git additions, active states
  - Avoid: Yellow-green on blue backgrounds

- **Blue** (#458588, #83A598): Trust, calm, professionalism, information
  - Use for: Primary UI elements, links, information
  - Avoid: Pure blue on black (can strain eyes)

- **Purple** (#B16286, #D3869B): Creativity, luxury, wisdom
  - Use for: Special states, unique features
  - Avoid: Dark purple on dark backgrounds

**Neutral Colors:**
- **Gray** (#928374, #A89984): Balance, neutrality, professionalism
  - Use for: Inactive elements, borders, secondary text
  - Avoid: Too much gray (lifeless interface)

- **Brown** (#665C54, #7C6F64): Stability, earthiness, warmth
  - Use for: Backgrounds, subtle accents
  - Avoid: Overuse (can appear dated)

### Cognitive Impact

**High Contrast** (Black on White, White on Black):
- **Benefits**: Maximum readability, clear hierarchy
- **Drawbacks**: Eye strain in low light, harsh in dark environments
- **Best for**: Code editors during daytime

**Medium Contrast** (Gruvbox, Nord):
- **Benefits**: Reduced eye strain, comfortable for extended use
- **Drawbacks**: Slightly lower readability
- **Best for**: Long coding sessions, terminal work

**Low Contrast** (Solarized Light):
- **Benefits**: Very low eye strain, gentle
- **Drawbacks**: Can be hard to read in bright environments
- **Best for**: Light-sensitive users, specific lighting conditions

## Popular Terminal Color Schemes

### Dark Themes

**Gruvbox Dark** (Warm, Retro)
```
Background: #282828 (Dark brown-gray)
Foreground: #EBDBB2 (Warm cream)
Palette: Retro, warm, earthy tones
Psychology: Comfortable, nostalgic, reduces eye strain
Best for: Long coding sessions, warm environments
```

**Nord** (Cool, Arctic)
```
Background: #2E3440 (Deep blue-gray)
Foreground: #D8DEE9 (Cool white)
Palette: Cool blues, muted colors
Psychology: Professional, calm, focused
Best for: Modern aesthetics, cool color preference
```

**Dracula** (Vibrant, Energetic)
```
Background: #282A36 (Dark purple-gray)
Foreground: #F8F8F2 (Bright white)
Palette: High contrast, vibrant accents
Psychology: Energetic, creative, bold
Best for: Creative work, presentations
```

**Tokyo Night** (Modern, Balanced)
```
Background: #1A1B26 (Deep navy)
Foreground: #C0CAF5 (Soft blue-white)
Palette: Modern, balanced blues and purples
Psychology: Modern, sophisticated, professional
Best for: Modern development environments
```

**One Dark** (Popular, Balanced)
```
Background: #282C34 (Dark gray)
Foreground: #ABB2BF (Light gray)
Palette: Balanced, widely familiar (Atom editor)
Psychology: Professional, familiar, productive
Best for: Teams, collaboration, consistency
```

**Catppuccin Mocha** (Soft, Pastel)
```
Background: #1E1E2E (Dark purple-blue)
Foreground: #CDD6F4 (Soft lavender)
Palette: Soft pastels, high readability
Psychology: Gentle, modern, aesthetic
Best for: Reduced eye strain, aesthetics-focused
```

### Light Themes

**Gruvbox Light** (Warm, Paper-like)
```
Background: #FBF1C7 (Cream paper)
Foreground: #3C3836 (Dark brown)
Psychology: Natural, comfortable, like paper
Best for: Daytime work, office environments
```

**Solarized Light** (Scientific, Precise)
```
Background: #FDF6E3 (Warm white)
Foreground: #657B83 (Blue-gray)
Psychology: Scientifically designed for eye comfort
Best for: All-day use, mixed lighting
```

**Nord Light** (Clean, Minimal)
```
Background: #ECEFF4 (Cool white)
Foreground: #2E3440 (Dark blue-gray)
Psychology: Clean, professional, Scandinavian
Best for: Minimalist preferences, bright rooms
```

## Analyzing Theme Coherence

### Audit Checklist

**Cross-Tool Consistency:**
- [ ] ZSH prompt colors match theme palette
- [ ] Tmux status bar aligns with primary colors
- [ ] Kitty terminal background/foreground consistent
- [ ] Neovim syntax highlighting follows theme
- [ ] Git diff colors are semantically correct
- [ ] All tools use same accent color family

**Semantic Consistency:**
- [ ] Green = Success/Addition (git +, success messages)
- [ ] Red = Error/Deletion (git -, error messages)
- [ ] Yellow = Warning (alerts, cautions)
- [ ] Blue = Information (prompts, info)
- [ ] Purple = Special/Unique (virtual envs, special modes)
- [ ] Gray = Inactive/Secondary (comments, borders)

**Accessibility:**
- [ ] Contrast ratio ≥ 4.5:1 for normal text (WCAG AA)
- [ ] Contrast ratio ≥ 7:1 for important text (WCAG AAA)
- [ ] Colors distinguishable for color-blind users
- [ ] No information conveyed by color alone
- [ ] Text readable on all background variants

**Visual Hierarchy:**
- [ ] Primary elements use primary colors
- [ ] Secondary elements use muted/gray tones
- [ ] Active elements are brighter/bolder
- [ ] Inactive elements are dimmed
- [ ] Important info uses high-contrast colors

### Color Coherence Analysis Script

```bash
#!/bin/bash
# analyze-theme-coherence.sh

echo "=== Theme Coherence Analysis ==="
echo

# Extract colors from ZSH config
echo "ZSH Colors:"
grep -E "fg=|bg=|color[0-9]" ~/.zshrc ~/.zsh.d/*.zsh | \
  grep -oE "\#[0-9A-Fa-f]{6}|color[0-9]+" | sort -u

# Extract colors from tmux
echo -e "\nTmux Colors:"
grep -E "colour[0-9]+|#[0-9A-Fa-f]{6}" ~/.tmux.conf | \
  grep -oE "colour[0-9]+|#[0-9A-Fa-f]{6}" | sort -u

# Extract colors from Kitty
echo -e "\nKitty Colors:"
grep -E "color[0-9]+|ground|cursor" ~/.config/kitty/kitty.conf | \
  grep -oE "#[0-9A-Fa-f]{6}" | sort -u

# Extract colors from Neovim
echo -e "\nNeovim Colors:"
grep -E "gui(fg|bg)=#|cterm" ~/.config/nvim/init.lua | \
  grep -oE "#[0-9A-Fa-f]{6}" | sort -u

echo -e "\n=== Color Frequency ==="
cat ~/.zshrc ~/.zsh.d/*.zsh ~/.tmux.conf ~/.config/kitty/kitty.conf 2>/dev/null | \
  grep -oE "#[0-9A-Fa-f]{6}" | sort | uniq -c | sort -rn
```

## Color Scheme Resources

### Online Color Scheme Generators

**Terminal Specific:**
- **terminal.sexy** (https://terminal.sexy): Interactive terminal theme editor
- **Gogh** (https://gogh-co.github.io/Gogh/): 200+ terminal themes
- **iTerm2 Color Schemes** (https://iterm2colorschemes.com/): Large collection
- **base16** (http://chriskempson.com/projects/base16/): Modular theme system

**General Design:**
- **Coolors** (https://coolors.co): Random palette generator
- **Adobe Color** (https://color.adobe.com): Color wheel and harmony rules
- **Paletton** (https://paletton.com): Advanced color scheme designer
- **ColorHunt** (https://colorhunt.co): Curated color palette collection
- **Huemint** (https://huemint.com): AI-powered palette generation

**Accessibility Tools:**
- **WebAIM Contrast Checker**: https://webaim.org/resources/contrastchecker/
- **Colorblind Web Page Filter**: https://www.toptal.com/designers/colorfilter
- **Color Oracle**: Free color blindness simulator

### Base16 System

Framework for consistent theming across applications:
```yaml
# base16 structure
base00: Default Background
base01: Lighter Background (status bar)
base02: Selection Background
base03: Comments, Invisibles
base04: Dark Foreground (status bar)
base05: Default Foreground
base06: Light Foreground
base07: Light Background
base08: Red (Variables)
base09: Orange (Integers, Constants)
base0A: Yellow (Classes, Search)
base0B: Green (Strings)
base0C: Cyan (Regex, Escape Chars)
base0D: Blue (Functions)
base0E: Purple (Keywords)
base0F: Brown (Tags, Deprecated)
```

## Implementing Theme Coherence

### Unified Theme Configuration

**Create a central color definition:**
```bash
# ~/.dotfiles/colors/theme.env
# Central theme color definitions

# Background/Foreground
export THEME_BG_DARK="#282828"
export THEME_BG_LIGHT="#FBF1C7"
export THEME_FG_DARK="#3C3836"
export THEME_FG_LIGHT="#EBDBB2"

# Primary Palette
export THEME_RED="#CC241D"
export THEME_GREEN="#98971A"
export THEME_YELLOW="#D79921"
export THEME_BLUE="#458588"
export THEME_PURPLE="#B16286"
export THEME_AQUA="#689D6A"
export THEME_ORANGE="#D65D0E"

# Bright variants
export THEME_RED_BRIGHT="#FB4934"
export THEME_GREEN_BRIGHT="#B8BB26"
export THEME_YELLOW_BRIGHT="#FABD2F"
export THEME_BLUE_BRIGHT="#83A598"
export THEME_PURPLE_BRIGHT="#D3869B"
export THEME_AQUA_BRIGHT="#8EC07C"
export THEME_ORANGE_BRIGHT="#FE8019"

# Grays
export THEME_GRAY_DARK="#928374"
export THEME_GRAY_LIGHT="#A89984"

# UI Specific
export THEME_ACCENT="$THEME_BLUE_BRIGHT"
export THEME_SUCCESS="$THEME_GREEN_BRIGHT"
export THEME_WARNING="$THEME_YELLOW_BRIGHT"
export THEME_ERROR="$THEME_RED_BRIGHT"
export THEME_INFO="$THEME_BLUE_BRIGHT"
```

**Generate configs from central theme:**
```bash
#!/bin/bash
# generate-theme-configs.sh

source ~/.dotfiles/colors/theme.env

# Generate Kitty colors
cat > ~/.config/kitty/colors-generated.conf <<EOF
# Auto-generated from theme.env
foreground ${THEME_FG_LIGHT}
background ${THEME_BG_DARK}

# Normal colors
color0  ${THEME_BG_DARK}
color1  ${THEME_RED}
color2  ${THEME_GREEN}
color3  ${THEME_YELLOW}
color4  ${THEME_BLUE}
color5  ${THEME_PURPLE}
color6  ${THEME_AQUA}
color7  ${THEME_FG_LIGHT}

# Bright colors
color8  ${THEME_GRAY_DARK}
color9  ${THEME_RED_BRIGHT}
color10 ${THEME_GREEN_BRIGHT}
color11 ${THEME_YELLOW_BRIGHT}
color12 ${THEME_BLUE_BRIGHT}
color13 ${THEME_PURPLE_BRIGHT}
color14 ${THEME_AQUA_BRIGHT}
color15 ${THEME_FG_LIGHT}
EOF

# Generate tmux colors
cat > ~/.config/tmux/colors-generated.conf <<EOF
# Auto-generated from theme.env
set -g status-style "bg=${THEME_BG_DARK},fg=${THEME_FG_LIGHT}"
set -g pane-active-border-style "fg=${THEME_ACCENT}"
set -g pane-border-style "fg=${THEME_GRAY_DARK}"
EOF

echo "✓ Theme configs generated"
```

### Theme Switching System

```bash
#!/bin/bash
# switch-theme.sh

THEME=$1  # light or dark

case $THEME in
  light)
    export THEME_MODE="light"
    kitty @ set-colors --all ~/.config/kitty/gruvbox-light.conf
    tmux source-file ~/.config/tmux/gruvbox-light.conf
    ;;
  dark)
    export THEME_MODE="dark"
    kitty @ set-colors --all ~/.config/kitty/gruvbox-dark.conf
    tmux source-file ~/.config/tmux/gruvbox-dark.conf
    ;;
esac

# Persist selection
echo "export THEME_MODE=$THEME_MODE" > ~/.theme-mode
```

## Best Practices

### Design Principles
1. **Start with 5-7 base colors**: bg, fg, accent, success, warning, error, info
2. **Use shades**: Create light/dark variants for depth
3. **Test in context**: View colors in actual terminal with your content
4. **Consider lighting**: Test in bright and dark environments
5. **Respect conventions**: Red = danger, Green = success, Yellow = warning
6. **Maintain contrast**: Ensure readability in all scenarios
7. **Be consistent**: Use same color for same meaning across tools

### Common Mistakes to Avoid
- Using too many colors (cognitive overload)
- Low contrast text (accessibility issue)
- Inconsistent semantic colors (red for success in one place, error in another)
- Pure black backgrounds (harsh, prefer dark gray like #1e1e1e)
- Pure white text (bright, prefer off-white like #eeeeee)
- Ignoring color blindness (8% of males affected)
- Random accent colors (should harmonize with palette)

### Testing Your Theme
```bash
# Color test script
#!/bin/bash
echo -e "\033[0;30m Black \033[0m"
echo -e "\033[0;31m Red \033[0m"
echo -e "\033[0;32m Green \033[0m"
echo -e "\033[0;33m Yellow \033[0m"
echo -e "\033[0;34m Blue \033[0m"
echo -e "\033[0;35m Purple \033[0m"
echo -e "\033[0;36m Cyan \033[0m"
echo -e "\033[0;37m White \033[0m"
echo
echo -e "\033[1;30m Bright Black \033[0m"
echo -e "\033[1;31m Bright Red \033[0m"
echo -e "\033[1;32m Bright Green \033[0m"
echo -e "\033[1;33m Bright Yellow \033[0m"
echo -e "\033[1;34m Bright Blue \033[0m"
echo -e "\033[1;35m Bright Purple \033[0m"
echo -e "\033[1;36m Bright Cyan \033[0m"
echo -e "\033[1;37m Bright White \033[0m"
```

## For This Project

### Current Theme Analysis
Based on CLAUDE.md, the current theme uses:
- **Tmux**: Purple-green palette (#442E59, #79658C, #917CA6, #27403B, #5D736D)
- **ZSH**: Bright 256-color codes (32, 120, 226, 196, 87, 213, 154)
- **Dircolors**: Configured in ~/.dircolors

### Recommended Actions
1. **Audit current colors**: Extract all hex codes and ANSI colors used
2. **Create central palette**: Define authoritative color definitions
3. **Ensure consistency**: Match Kitty, tmux, ZSH colors
4. **Add documentation**: Document color meanings and usage
5. **Generate scheme**: Create light/dark variants
6. **Test accessibility**: Run contrast checks
7. **Add switching**: Implement dynamic theme switching

### Sample Makefile Target
```makefile
.PHONY: theme-audit
theme-audit: ## Audit theme colors across all configs
	@echo "Running theme coherence analysis..."
	@./scripts/analyze-theme-coherence.sh

.PHONY: theme-generate
theme-generate: ## Generate theme configs from central definition
	@./scripts/generate-theme-configs.sh
	@echo "✓ Theme configs generated"

.PHONY: theme-switch-light
theme-switch-light: ## Switch to light theme
	@./scripts/switch-theme.sh light

.PHONY: theme-switch-dark
theme-switch-dark: ## Switch to dark theme
	@./scripts/switch-theme.sh dark
```

## Resources

- **Base16 Project**: http://chriskempson.com/projects/base16/
- **terminal.sexy**: https://terminal.sexy
- **Color Theory**: https://www.interaction-design.org/literature/topics/color-theory
- **Material Design Colors**: https://material.io/design/color
- **WCAG Guidelines**: https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum
