---
name: world-designer
description: Design and maintain the fictional world — geography, history, magic/science systems, social structures, factions, and universe rules. Produces world bible entries with internal consistency verification.
---

# world-designer

## Purpose
Design the fictional world's foundational elements: geography, history, magic or science systems, social hierarchies, political factions, cultural norms, and the fundamental rules that govern reality. The output becomes the bedrock upon which characters, plot, and mysteries are built. Every story event must be possible within the world rules defined here.

## Trigger
- "Design the world for this story"
- "Create the setting"
- "Define the magic system" / "How does the science work in this world"
- "What factions exist in this world"
- "Design the school/city/organization"
- "What are the rules of this universe"
- "What's the history of this world"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `genre` | enum | yes | Primary genre: `science_fiction`, `fantasy`, `contemporary`, `historical`, `school_life`, `psychological`, `urban_fantasy`, `isekai` |
| `tone` | enum | yes | Overall tone: `dark`, `bittersweet`, `romantic`, `thriller`, `melancholic`, `hopeful`, `cynical` |
| `reference_works` | array | no | Target works for tone/scale reference (e.g., Steins;Gate, Fate/Stay Night) |
| `scale` | enum | yes | World scope: `single_location`, `city`, `region`, `nation`, `global`, `multiverse` |
| `system_type` | enum | conditional | Required for fantasy/sci-fi: `magic_system`, `science_system`, `superpower_system`, `none` |
| `existing_bible_entries` | array | no | Previously created world entities to extend or maintain consistency with |
| `time_period` | string | yes | When the story takes place (e.g., "2010 summer, Akihabara") |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `world_entities` | array | One or more world bible entries created/updated |
| `system_rules` | object | Complete rules for the magic/science system (if applicable) |
| `faction_map` | object | Faction relationships: alliances, conflicts, hierarchies |
| `location_graph` | object | Locations and their spatial/travel relationships |
| `consistency_report` | object | Internal consistency verification results |
| `implications` | array | World design implications for characters, timeline, and plot |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for existing world entities (`entity_type: world, operation: list`)
2. Absorb genre, tone, scale, and reference work parameters
3. If reference works provided, extract relevant world-building patterns

### Step 2: Establish Fundamental Rules
1. Define the **reality baseline**: what is possible and impossible in this world
2. If system_type is not `none`, design the complete system:
   - **Hard magic/sci-fi**: Clear rules, costs, limitations, conservation laws
   - **Soft magic**: Thematic boundaries, emotional costs, mysterious elements
   - **Science**: Technology level, key innovations, limitations
3. Document rules as explicit, testable statements
4. Verify all rules are internally consistent (no rule contradicts another)

### Step 3: Design Geography and Locations
1. Define the spatial scope appropriate to `scale`
2. Create primary locations with:
   - Physical description (sensory details)
   - Narrative function (what kinds of scenes happen here)
   - Associated characters/factions
   - Mood/atmosphere
3. Map spatial relationships (travel time, adjacency, accessibility)
4. Ensure geographic logic (rivers flow downhill, cities have water sources, etc.)

### Step 4: Design Social Architecture
1. Define factions/groups with:
   - Purpose and goals
   - Power/resources
   - Internal hierarchy
   - Relationship to other factions (alliance/rivalry/war/ignorance)
2. Design social rules and norms:
   - Class/status system
   - Cultural taboos and expectations
   - Power dynamics
3. If school setting: design the school system (calendar, hierarchy, clubs, rules)

### Step 5: Design History
1. Create key historical events that shaped the present
2. Establish causal chains: past event → present condition
3. Place historical secrets (things characters may discover)
4. Ensure history explains current faction dynamics

### Step 6: Verify and Write
1. Run internal consistency check:
   - All rules compatible with each other
   - Locations logically connected
   - History causally coherent
   - Faction motivations make sense
2. Identify implications for other bible sections:
   - What character types are needed
   - What plot events are enabled/disabled by world rules
   - What timeline constraints exist
3. Write all entities to `bible-manager` (`entity_type: world, operation: create`)
4. Return complete output package

## Validation Rules

1. **System Consistency**: Magic/science rules must not contradict each other. If rule A says "teleportation requires physical contact" and rule B enables "remote teleportation," that's a violation
2. **Geographic Logic**: Locations must obey physical logic unless explicitly magical. No river flowing from sea to mountain without magical explanation
3. **Historical Causality**: Every major historical event must have a cause. No "it just happened" for world-shaping events
4. **Faction Motivation**: Every faction must have a coherent goal rooted in their history/resources. No "evil for evil's sake"
5. **Rule Completeness**: If a system exists, its rules must cover: capability, cost, limitation, counter, and origin
6. **Scale Appropriateness**: World scope must match story needs. A single-location story doesn't need continental politics
7. **Reference Integrity**: All referenced entities (locations, factions) must exist in the bible after writing
8. **Tonal Consistency**: World elements must support the stated tone. Comedic elements in a dark tragedy need narrative justification
9. **Period Accuracy**: If set in a real historical period or real-world location (e.g., Akihabara 2010), details must be period-accurate
10. **Mystery Seeding**: At least one historical secret or unresolved mystery should be planted for potential plot use
