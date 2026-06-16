# Skill Ecosystem Overview

## Project: 日式轻小说/Galgame 商业项目

### Reference Targets
- **Steins;Gate** — timeline complexity, foreshadowing, science-mystery
- **White Album 2** — emotional devastation, character depth, romance-route design
- **Fate/Stay Night** — multi-route architecture, theme expression through routes, hidden truth layering
- **Classroom of the Elite** — psychological warfare, hidden abilities, social manipulation
- **Death Note** — intellectual battles, cat-and-mouse structure, moral ambiguity

### Architecture Philosophy

The skill ecosystem follows a **tiered architecture** with a single source of truth (Project Bible):

```
Tier 5: Production        [revision-manager] [localization-reviewer]
                              ↓                    ↓
Tier 4: Quality Assurance [narrative-doctor] [pacing-analyzer] [theme-weaver]
                           [voice-keeper] [bible-validator] [reader-simulator]
                              ↓ (all read bible, write reports)
Tier 3: Content Creation  [scene-writer] [dialogue-crafter]
                              ↓
Tier 2: Plot Architecture [plot-architect] [route-designer] [choice-designer]
                           [flag-engineer] [emotion-designer]
                              ↓
Tier 1: World Building    [world-designer] [character-designer] [timeline-architect]
                           [mystery-designer]
                              ↓
Tier 0: Foundation        [bible-manager] ← THE SINGLE SOURCE OF TRUTH
```

### Data Flow Principle
- **All writes** go through `bible-manager` for canonical data
- **All reads** go through `bible-manager` for consistency
- **Quality skills** read from bible + manuscripts and produce reports
- **Production skills** operate on manuscripts with bible context

### Skill Count: 20
- Tier 0: 1 skill (Foundation)
- Tier 1: 4 skills (World Building)
- Tier 2: 5 skills (Plot Architecture)
- Tier 3: 2 skills (Content Creation)
- Tier 4: 6 skills (Quality Assurance)
- Tier 5: 2 skills (Production)

### Bible Structure
```
bible/
├── world/         # Locations, history, magic systems, factions, rules
├── characters/    # Profiles, backstories, voice guides, relationship matrices
├── timeline/      # Chronological events, causal chains, time mechanics
├── routes/        # Route topology, entry conditions, ending definitions
├── scenes/        # Scene specifications, beat sheets
└── mysteries/     # Clue maps, foreshadowing registry, reveal schedules
```
