# Agent Personas 🎭

> Multi-agent development teams for [Claude Code](https://docs.anthropic.com/en/docs/claude-code)

Agent Personas is a collection of themed, character-driven AI development teams that bring personality and specialized expertise to your coding workflow. Instead of working with a single generic assistant, you collaborate with a coordinated crew of specialists - each with their own personality, domain expertise, and communication style.

## Why Agent Personas?

**Traditional AI assistance:**
```
You → Generic AI → Response
```

**Agent Personas:**
```
You → Orchestrator → Specialist(s) → Coordinated Response
```

Benefits:
- **Specialization** - Each agent excels in their domain (architecture, testing, docs, etc.)
- **Parallel execution** - Independent tasks run simultaneously
- **Personality** - Engaging characters make development more enjoyable
- **Consistency** - Same specialists, same patterns, predictable quality
- **Routing intelligence** - Work automatically goes to the right expert

## Available Teams

### 🤘 [The Grind Crew](./GrindCrewDevTeam/)

A rock & roll development team. Five specialists who treat coding like shredding.

| Specialist | Role | Vibe |
|------------|------|------|
| **Duke** | Orchestrator | Tenacious D energy |
| **Riff** | Backend/Architecture | Prog-rock deep thinker |
| **Verse** | Frontend/UI | Indie rock curator |
| **Crash** | Testing/QA | Punk rock destroyer |
| **Ink** | Documentation | P!nk energy |

**Best for:** Small to medium teams wanting a fun, focused crew with clear specializations.

```bash
cd GrindCrewDevTeam
./installs/install-grindcrew.sh      # Local install
./installs/install-grindcrew.sh -g   # Global install
```

---

### 👍 [The Askewniverse Dev Team](./ViewAskewDevTeam/)

A character-driven team inspired by Kevin Smith's View Askewniverse films (Clerks, Mallrats, Chasing Amy, Dogma).

| Crew | Members | Domains |
|------|---------|---------|
| **Leadership** | Buddy Christ, Bethany | Routing, orchestration |
| **Quick Stop** | Dante, Randal, Jay, Silent Bob | Bugs, reviews, prototyping, architecture |
| **Mallrats** | Brodie, T.S. | UI/UX, project management |
| **Chasing Amy** | Alyssa, Holden | Documentation, testing |
| **Dogma** | Metatron, Rufus | API design, integrations |

**Best for:** Larger teams wanting comprehensive coverage with 12 specialists across all development domains.

```bash
cd ViewAskewDevTeam
./installs/install-askewniverse.sh      # Local install
./installs/install-askewniverse.sh -g   # Global install
```

## How It Works

### 1. Install a Team

Each team has install scripts that set up:
- **Personas** - Detailed character personality files
- **Agents** - Claude Code agent definitions with tools and models
- **Commands** - Slash commands for easy access

### 2. Start a Session

```bash
# Grind Crew
/grind

# Askewniverse
/askew
```

### 3. Work with Specialists

```bash
# Direct specialist access
@duke      # Grind Crew orchestrator
@bethany   # Askewniverse orchestrator

# Or let the orchestrator route for you
/grind I need to add user authentication
# Duke analyzes → Routes to Riff (backend) + Verse (UI) + Crash (tests)
```

## Installation Options

Both teams support:

| Flag | Description |
|------|-------------|
| *(none)* | Install to `./.claude/` (current project only) |
| `-g, --global` | Install to `~/.claude/` (all projects) |
| `-h, --help` | Show help |

**Local installs** are great for project-specific teams or trying things out.

**Global installs** make the team available across all your Claude Code projects.

## Project Structure

```
AgentPersonas/
├── README.md                    # You are here
├── GrindCrewDevTeam/           # Rock & roll team (5 specialists)
│   ├── README.md               # Team overview
│   ├── THE-GRIND-CREW.md      # Full documentation
│   ├── agents/                 # Agent definitions
│   ├── specs/                  # Character specifications
│   └── installs/               # Install/uninstall scripts
└── ViewAskewDevTeam/           # Askewniverse team (12 specialists)
    ├── README.md               # Team overview
    ├── THE-ASKEWNIVERSE-DEV-TEAM.md  # Full documentation
    ├── agents/                 # Agent definitions
    ├── specs/                  # Character specifications
    ├── images/                 # Character avatars
    ├── installs/               # Install/uninstall scripts
    └── presentation/           # Overview presentation
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed and configured
- Bash shell (macOS, Linux, or WSL on Windows)

## Creating Your Own Team

Want to build your own themed agent team? Each team follows a consistent pattern:

1. **Personas** - Markdown files defining personality, expertise, and communication style
2. **Agents** - YAML frontmatter + instructions for Claude Code
3. **Orchestrator** - A coordinator who routes work to specialists
4. **Install script** - Sets up everything in the right places

Check out the existing teams for examples, or see the [specs/](./GrindCrewDevTeam/specs/) folders for detailed character templates.

## Philosophy

Agent Personas is built on a few core beliefs:

- **Personality enhances productivity** - Engaging characters make work more enjoyable
- **Specialization beats generalization** - Focused expertise produces better results
- **Parallel is faster** - Coordinated specialists working simultaneously
- **Consistency matters** - Same team, same patterns, predictable quality
- **Fun is not frivolous** - Enjoying your tools makes you more effective

## Contributing

Ideas for new teams? Improvements to existing ones? PRs welcome!

Some ideas:
- **Sci-Fi Crew** - Star Trek or Firefly themed
- **Fantasy Guild** - D&D-style adventuring party
- **Heist Team** - Ocean's Eleven style specialists
- **Sports Team** - Coach + position players

## License

MIT - Use it, fork it, make your own weird teams.

---

*"The right team makes all the difference."*

🤘👍😉
