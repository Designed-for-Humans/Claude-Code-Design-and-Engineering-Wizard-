# Design System Wizard

A Claude Code skill that combines structured development methodology with design system discipline to build production-quality, accessible UI interfaces.

Powered by **[Design Systems for Humans](https://systems.designedforhumans.tech)**.

## What It Does

The `/design` skill guides Claude through a 7-phase workflow:

| Phase | Name | What Happens |
|-------|------|-------------|
| 0 | **Setup** | Connect your design system (MCP server, AI file, or built-in reference) |
| 1 | **Design Context** | Pull from Figma, verbal description, or existing UI |
| 2 | **Token Analysis** | Map every visual property to a named token — zero hardcoded values |
| 3 | **Architecture** | Plan components with props, variants, states, and accessibility contracts |
| 4 | **Implementation** | TDD, semantic HTML, ARIA, three color modes |
| 5 | **Design QA** | Visual testing across viewports, dark mode, and axe-core accessibility audit |
| 6 | **Documentation** | NN/g-style component docs + Figma Code Connect round-trip |

## Installation

### Quick Install (curl)

```bash
curl -sL https://raw.githubusercontent.com/Designed-for-Humans/Claude-Code-Design-and-Engineering-Wizard-/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/Designed-for-Humans/Claude-Code-Design-and-Engineering-Wizard-.git
cp -r Claude-Code-Design-and-Engineering-Wizard-/skill/ .claude/skills/design-system-wizard/
```

## Setup — Three Tiers

The skill works at three levels depending on your account:

### Tier 1: Pro Account (Full Experience) — $19/mo

The complete workflow with live, personalized tokens.

1. Sign up at **[systems.designedforhumans.tech](https://systems.designedforhumans.tech)**
2. Upgrade to **Pro**
3. Create your design system (17 templates or build from scratch)
4. Connect the MCP server:

```bash
claude mcp add design-system -t http https://zncwlnoobrkxfghglpep.supabase.co/functions/v1/design-system-mcp/mcp
```

**What you get:**
- Your personalized design tokens (colors, typography, spacing, borders, shadows)
- CSS variable generation (CSS, SCSS, or Tailwind)
- Compliance checking (`evaluate_compliance`)
- AI Context Export files (Markdown/JSON for offline use)
- Component docs + accessibility guidelines
- Figma block export for round-trip sync

### Tier 2: Free Account (Partial MCP)

Sign up for free and connect the MCP server. You get:

- Component documentation (`get_component_docs`) — full NN/g-style docs for 20+ components
- Accessibility guidelines (`get_accessibility_guidelines`) — WCAG requirements per component
- Default token structure (token names and categories, but not your custom values)

**Not included (Pro only):** personalized token values, `generate_css_variables`, `evaluate_compliance`, AI file exports, Figma block export.

### Tier 3: No Account (Built-in Reference)

The skill still works using its built-in reference files:
- **TOKENS.md** — full token taxonomy with naming conventions
- **ACCESSIBILITY.md** — WCAG requirements + per-component contracts
- **COMPONENTS.md** — NN/g documentation templates

You get the structured 7-phase workflow and design system best practices. You just won't have personalized token values — you'll define them yourself in your project's CSS.

### 3. Use It

```
/design build a settings page with sidebar navigation and form sections
```

```
/design implement this Figma design: https://figma.com/design/abc123/MyDesign?node-id=1-2
```

```
/design improve the accessibility of our current login form
```

## What's Inside

```
skill/
├── SKILL.md           # Main 7-phase workflow with tool orchestration
├── ONBOARDING.md      # Setup guide for systems.designedforhumans.tech + MCP
├── CHECKLISTS.md      # Pass/fail gate items for each phase
├── TOKENS.md          # Full design token taxonomy (colors, type, spacing, etc.)
├── ACCESSIBILITY.md   # WCAG requirements + per-component a11y contracts
├── PATTERNS.md        # Code templates for tokens, variants, dark mode, TDD
└── COMPONENTS.md      # NN/g documentation template + component hierarchy
```

## MCP Integration

When connected, the skill orchestrates three MCP servers:

| Server | Tools Used | Tier |
|--------|-----------|------|
| **design-system-mcp** | `get_component_docs`, `get_accessibility_guidelines` | Free |
| **design-system-mcp** | `get_design_tokens` (personalized), `generate_css_variables`, `evaluate_compliance`, `export_block_for_figma` | Pro |
| **Figma MCP** | `get_design_context`, `get_screenshot`, `get_variable_defs`, `add_code_connect_map` | Free (separate Figma account) |
| **Claude Preview** | `preview_screenshot`, `preview_inspect`, `preview_resize`, `preview_eval` (axe-core) | Free (built into Claude Code) |

## Core Principles

1. **Every pixel has a token.** No hardcoded colors, spacing, or font sizes.
2. **Accessibility is not optional.** WCAG AA minimum. Keyboard + screen reader support for all interactive elements.
3. **Semantic HTML first.** `<nav>`, `<main>`, `<article>`, `<button>` — not div soup.
4. **Verify before you build.** Search for existing components. Never recreate what exists.
5. **Three modes always.** Light, dark, and high-contrast.
6. **Architect first, code second.** 70% understanding, 30% building.

## Inspired By

- [claude-wizard](https://github.com/vlad-ko/claude-wizard) — structured development methodology
- [Design Systems for Humans](https://systems.designedforhumans.tech) — design token platform with MCP integration
- [Nielsen Norman Group](https://www.nngroup.com/) — component documentation approach

## License

MIT
