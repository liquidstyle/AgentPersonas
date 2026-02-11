# Skill Packaging Guide: Building an Installable Cowork Skill

## The Skill Directory Structure

Your finished agent team becomes a `.skill` file with this structure:

```
my-team.skill/
├── SKILL.md                          # Main skill config (routing, activation, roster)
└── references/
    ├── company-brief.md              # Company identity, financials, team mission
    ├── razor.md                       # Specialist 1: full reference file
    ├── pulse.md                       # Specialist 2: full reference file
    ├── forge.md                       # Specialist 3: full reference file
    └── [specialist-name].md            # Additional specialists as needed
```

## What Goes in Each Reference File

### company-brief.md
- Company identity (name, location, ARR, founded)
- What they do (2-3 sentences, mission statement)
- Divisions/departments (table with staff, revenue, margin)
- Financial reality (3-year trend)
- Key people (name, title, comp, notes)
- Tech stack
- The team overview (what your agent team does, why it exists)

### [specialist-name].md (one per agent)
- Callsign, role, company context
- Archetype (1-2 sentences)
- Communication style (4-5 bullets)
- Catchphrases (3-5)
- Primary expertise (5-7 areas)
- Key deliverables (4-5)
- When to call (table)
- Sample quote
- Image prompt

## Writing the SKILL.md Routing Logic

SKILL.md is the nervous system. It activates the team and routes tasks to specialists.

### Structure

```markdown
# [COMPANY_NAME] Operations Team

## Activation Protocol

When a user asks a question:
1. Identify the domain (revenue, success, growth, etc.)
2. Route to the appropriate specialist
3. If multi-specialist, coordinate handoffs

## Task-to-Specialist Routing

| Domain | Specialist | Example Tasks |
|---|---|---|
| Revenue operations, pricing, contracts | Razor | Pricing audit, upsell strategy, contract review |
| Customer success, retention, health | Pulse | Retention playbook, health score design, churn analysis |
| Product adoption, activation, growth | Forge | Activation flow design, feature adoption, growth metrics |

## Roster

**Razor** (Revenue Operations Analyst)
**Pulse** (Customer Success Strategist)
**Forge** (Product Growth Strategist)

[Each specialist reference in /references/]

## Persona Rules

- Each specialist owns their domain completely
- Specialists defer to peers when asked about other domains
- Handoffs are explicit and coordinated
- Tone and style remain consistent per specialist
```

## How to Package with package_skill.py

1. Create your skill directory with the structure above
2. Run: `python package_skill.py my-team.skill`
3. This creates `my-team.skill` (a compressed archive)

## How to Install in Cowork

1. In Cowork: Settings → Skills → Upload Custom Skill
2. Drag and drop the `.skill` file
3. The skill activates and appears in your skill roster
4. Users can now activate your team

## Distribution

- Share the `.skill` file with collaborators
- No installation needed on receiver end (drag-and-drop)
- Each user gets their own copy when they install
