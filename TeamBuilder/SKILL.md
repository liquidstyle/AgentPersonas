---
name: team-builder
description: "AI Agent Team Builder — guided framework for designing, developing, and packaging a custom AI operations team. Deploy when a user wants to: create AI agent personas with distinct personalities and expertise, build a virtual operations team, design agent specs with communication styles and catchphrases, generate image prompts for agent portraits, create team briefing documents, build a Meet the Team PDF, write a Strategic Brief document, or package agents into an installable Cowork skill. Trigger on: team building, agent creation, persona design, operations team, virtual team, AI agents, custom agents, agent personalities, team skill, or any request to create multiple specialized AI assistants."
---

# Team Builder — AI Agent Team Creation Framework

Guided framework for building a custom AI operations team from scratch. Walks users through every phase: company context, team design, persona creation, spec files, image generation, documentation, and skill packaging.

## The Process

Building an effective agent team follows 7 phases in order. Do not skip phases — each builds on the previous. Guide the user through one phase at a time.

### Phase 1: Company Context

**Goal**: Build the shared knowledge base all specialists will need.

1. Ask the user about their company:
   - Company name, location, what they do
   - Revenue, team size, key divisions
   - Core challenges and goals
   - Key people (names, roles, dynamics)
   - Tech stack and tools
   - Target market and key clients

2. Read `templates/company-brief-template.md` and fill it in with the user's answers

3. Save as `company-brief.md` in the working directory

**Done when**: Company brief is written and the user confirms it's accurate.

### Phase 2: Team Design

**Goal**: Define the team concept — how many specialists, what domains, what's the team called.

1. Ask the user:
   - What is the team's mission? (revenue recovery, growth, operations, etc.)
   - What are the 3-6 biggest operational gaps or pain points?
   - Do they want a team name and theme? (military ops, heist crew, sports team, etc.)
   - How many specialists do they want? (recommend 4-7; fewer is better than too many)

2. Map each pain point to an specialist role. Each specialist should own one clear domain with no overlap. Read `references/persona-design-guide.md` for guidance.

3. Present the proposed roster as a table:

| Callsign | Role | Domain | Why They Exist |
|----------|------|--------|----------------|
| ... | ... | ... | ... |

4. Iterate until the user approves the roster.

**Done when**: User approves the team name, specialist count, and role assignments.

### Phase 3: Persona Creation

**Goal**: Build each specialist's personality — archetype, voice, catchphrases, expertise.

For each specialist on the roster:

1. Read `references/persona-design-guide.md` for the archetype method and design principles
2. Read `templates/agent-template.md` for the structure
3. Show `references/example-specialist.md` as an example of the finished product

4. Ask the user:
   - Any personality inspiration? (a character, a real person's style, a vibe?)
   - What's this specialist's attitude toward their work?
   - Do they prefer data-first or narrative-first communication?
   - Any specific catchphrases or verbal tics?

5. Draft the specialist using the agent template. Include:
   - Archetype (the "X meets Y" formula)
   - Communication style (4-5 bullets)
   - Catchphrases (3-5 signature phrases)
   - Primary expertise (5-7 areas)
   - Key deliverables (4-5 output types)
   - "When to Call" decision table
   - Sample quote

6. Present to the user and iterate until approved.

7. Save as `[callsign].md` in the working directory.

Repeat for each specialist. Build one at a time — don't batch them.

**Done when**: All specialists have approved agent definition files.

### Phase 4: Full Spec Development

**Goal**: Expand each agent definition into a deep personality specification.

For each specialist:

1. Read `templates/spec-template.md` for the full spec structure
2. Expand the agent definition into a comprehensive spec:
   - Detailed communication examples (show, don't just describe)
   - 3-5 interaction scenarios with sample dialogues
   - Relationships with other team members (who they defer to, who they clash with)
   - Edge cases (what do they do when asked something outside their lane?)
   - Expanded expertise with frameworks and methodologies they use

3. Save as `spec-[callsign].md` in the working directory.

**Done when**: All specialists have full spec files.

### Phase 5: Image Generation

**Goal**: Create visual identity for each specialist.

1. Read `references/image-prompt-guide.md` for style options and prompt anatomy.

2. Ask the user:
   - What visual style? (portrait photography, illustrated, minimalist, retro card, cyberpunk)
   - Should they all share a consistent style? (strongly recommend yes)
   - Any color palette preferences?
   - Should faces be visible or obscured?

3. For each specialist, write an image prompt that includes:
   - Subject description (pose, expression, clothing)
   - Background (unique color per specialist)
   - Lighting and mood
   - Style-specific instructions
   - Format (square, portrait, etc.)

4. Add the image prompt to each specialist's spec file.

5. Provide all prompts to the user with instructions on where to generate them (ChatGPT/DALL-E, Midjourney, or other image generators).

**Done when**: Image prompts are written for all specialists and the user has generated (or plans to generate) images.

### Phase 6: Documentation

**Goal**: Build the team's briefing materials and presentation documents.

Three deliverables in this phase:

#### 6A: Master Briefing Document (Markdown)
Compile everything into a single comprehensive team document:
- Company brief (from Phase 1)
- Team overview and mission statement
- All specialist profiles (from Phase 3)
- Handoff protocol (how specialists reference each other)
- Data pipeline guide (what data the team needs and where it lives)
- Visual style guide with image prompts

Save as `[TEAM-NAME]-Briefing.md`

#### 6B: Meet the Team PDF
Build a visual presentation PDF with:
- Cover page with team name and branding
- Roster overview page (all specialists in a grid)
- Individual specialist pages (portrait image, name, role, key stats)
- Closing page

This requires the specialist images from Phase 5. If images aren't ready, mark this as pending.

Use ReportLab (Python) for PDF generation. Key technique: use low-level `canvas.Canvas` API (not SimpleDocTemplate) when pages need custom backgrounds — draw backgrounds BEFORE content to avoid overlay issues.

#### 6C: Strategic Brief PDF (Optional)
If the user wants a business case document for leadership:
- The Situation (why the team exists)
- The Mission (what the team will do)
- The Financial Case (projected impact)
- The Engagement Plan (phased rollout)
- The Bottom Line

**Done when**: Briefing document is complete. PDFs are generated if images are available.

### Phase 7: Skill Packaging

**Goal**: Package everything into an installable Cowork skill.

1. Read `references/skill-packaging-guide.md` for the full process
2. Read `templates/skill-md-template.md` for the SKILL.md structure

3. Create the skill directory:
   ```
   [team-name]/
   ├── SKILL.md
   └── references/
       ├── company-brief.md
       ├── [specialist-1].md
       ├── [specialist-2].md
       └── ...
   ```

4. Write the SKILL.md with:
   - Frontmatter (name, comprehensive description with all trigger words)
   - Activation protocol (read company-brief first, then identify and load specialist)
   - Task-to-specialist routing table
   - Roster overview (one-liner per specialist)
   - Persona rules (stay in character, use catchphrases, handoff protocol)
   - Multi-specialist mission handling
   - Output standards

5. Copy the company brief and all specialist agent definitions into references/

6. Package with the skill-creator's package_skill.py script

7. Provide the `.skill` file to the user with installation instructions:
   - Open Claude Desktop, navigate to Cowork mode
   - Drag the `.skill` file into the chat window
   - Confirm installation
   - Select workspace folder with their data
   - Test by invoking an specialist

**Done when**: `.skill` file is packaged and the user has installation instructions.

## Phase Navigation

Always tell the user which phase they're in and what comes next. Use this format:

```
━━━ PHASE [N] of 7: [PHASE NAME] ━━━
[Current objective]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

If the user wants to skip ahead or go back, allow it — but warn them about missing dependencies (e.g., can't build PDFs without images, can't package a skill without specialist files).

## Resources

### references/
- `persona-design-guide.md` — How to design effective agent personas (archetype method, voice design, expertise scoping)
- `image-prompt-guide.md` — How to create image prompts for agent portraits (styles, anatomy, examples)
- `example-specialist.md` — Complete example of a finished specialist reference file
- `skill-packaging-guide.md` — How to structure and package the final installable skill

### templates/
- `company-brief-template.md` — Fill-in-the-blank company context template
- `agent-template.md` — Fill-in-the-blank single agent definition template
- `spec-template.md` — Fill-in-the-blank full specialist spec template
- `skill-md-template.md` — Fill-in-the-blank SKILL.md for the final team skill
