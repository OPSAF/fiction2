# Skill Dependency Graph

## Call Relationship Diagram

```
                              ┌─────────────────────────────────────────────┐
                              │              bible-manager                   │
                              │         (Single Source of Truth)             │
                              └──────┬──────┬──────┬──────┬──────┬──────────┘
                                     │      │      │      │      │
              ┌──────────────────────┼──────┼──────┼──────┼──────┼──────────────────────┐
              │                      │      │      │      │      │                      │
              ▼                      ▼      ▼      ▼      ▼      ▼                      ▼
    ┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
    │world-designer│   │character-   │   │timeline-    │   │mystery-     │   │  (future    │
    │             │   │designer     │   │architect    │   │designer     │   │  skills)    │
    └──────┬──────┘   └──────┬──────┘   └──────┬──────┘   └──────┬──────┘   └─────────────┘
           │                 │                 │                 │
           └────────┬────────┘                 │                 │
                    │                          │                 │
                    ▼                          ▼                 │
          ┌──────────────────────────────────────────┐           │
          │           plot-architect                  │           │
          └────┬─────────────┬─────────────┬─────────┘           │
               │             │             │                      │
               ▼             ▼             ▼                      │
    ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
    │route-designer│   │emotion-     │   │  (reads     │          │
    │             │   │designer     │   │  mysteries) │◄─────────┘
    └──────┬──────┘   └──────┬──────┘   └─────────────┘
           │                 │
           ▼                 │
    ┌─────────────┐          │
    │choice-      │          │
    │designer     │          │
    └──────┬──────┘          │
           │                 │
           ▼                 │
    ┌─────────────┐          │
    │flag-engineer│          │
    └──────┬──────┘          │
           │                 │
           └────────┬────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │   scene-writer      │◄── reads bible, emotion map, plot structure
         └──────────┬──────────┘
                    │
                    ▼
         ┌─────────────────────┐
         │  dialogue-crafter   │◄── reads character voice guides, scene context
         └──────────┬──────────┘
                    │
                    │  (manuscripts produced)
                    │
    ┌───────────────┼───────────────┬───────────────────┬───────────────┐
    │               │               │                   │               │
    ▼               ▼               ▼                   ▼               ▼
┌────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐
│narrative│   │pacing-     │   │theme-      │   │voice-      │   │reader-     │
│doctor   │   │analyzer    │   │weaver      │   │keeper      │   │simulator   │
└────┬────┘   └─────┬──────┘   └─────┬──────┘   └─────┬──────┘   └─────┬──────┘
     │              │                │                │                │
     └──────────────┴────────────────┴────────────────┴────────────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │   bible-validator   │◄── cross-validates ALL bible sections
                         └─────────────────────┘

    ┌────────────────────────────────────────────────────────────────────┐
    │                        PRODUCTION LAYER                            │
    │  ┌─────────────────────┐    ┌─────────────────────────┐           │
    │  │ revision-manager    │    │ localization-reviewer   │           │
    │  │ (tracks all changes)│    │ (cultural/l10n audit)   │           │
    │  └─────────────────────┘    └─────────────────────────┘           │
    └────────────────────────────────────────────────────────────────────┘
```

## Dependency Matrix

| Skill | Depends On |
|-------|-----------|
| **bible-manager** | _(none — foundation)_ |
| **world-designer** | bible-manager |
| **character-designer** | bible-manager, world-designer |
| **timeline-architect** | bible-manager, world-designer |
| **mystery-designer** | bible-manager, plot-architect, character-designer |
| **plot-architect** | bible-manager, world-designer, character-designer, timeline-architect |
| **route-designer** | bible-manager, plot-architect, character-designer |
| **choice-designer** | bible-manager, route-designer, character-designer |
| **flag-engineer** | bible-manager, route-designer, choice-designer |
| **emotion-designer** | bible-manager, plot-architect, character-designer |
| **scene-writer** | bible-manager, plot-architect, emotion-designer, route-designer |
| **dialogue-crafter** | bible-manager, character-designer, emotion-designer, scene-writer |
| **narrative-doctor** | bible-manager, scene-writer, timeline-architect, flag-engineer |
| **pacing-analyzer** | bible-manager, scene-writer, emotion-designer |
| **theme-weaver** | bible-manager, scene-writer, plot-architect |
| **voice-keeper** | bible-manager, dialogue-crafter, character-designer |
| **bible-validator** | bible-manager, world-designer, character-designer, timeline-architect, route-designer, flag-engineer, mystery-designer |
| **reader-simulator** | bible-manager, scene-writer, mystery-designer, emotion-designer |
| **revision-manager** | bible-manager, scene-writer, dialogue-crafter |
| **localization-reviewer** | bible-manager, dialogue-crafter, character-designer, world-designer |

## Call Flow for Common Workflows

### Workflow: New Route Development
```
world-designer → character-designer → timeline-architect
    → plot-architect → route-designer → choice-designer
    → flag-engineer → emotion-designer → scene-writer
    → dialogue-crafter → narrative-doctor → pacing-analyzer
    → theme-weaver → voice-keeper → reader-simulator
    → bible-validator → revision-manager
```

### Workflow: Mystery Plot Construction
```
world-designer → plot-architect → character-designer
    → mystery-designer → timeline-architect → scene-writer
    → dialogue-crafter → reader-simulator → narrative-doctor
    → bible-validator
```

### Workflow: Quality Assurance Pass
```
bible-validator → narrative-doctor → pacing-analyzer
    → theme-weaver → voice-keeper → reader-simulator
    → localization-reviewer → revision-manager
```
