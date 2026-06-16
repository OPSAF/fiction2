---
name: timeline-architect
description: Design and manage the temporal structure — chronological events, parallel timelines, time travel mechanics, causal chains, and route-specific timeline divergences. Produces timeline bible entries with full causal linkage.
---

# timeline-architect

## Purpose
Design the complete temporal architecture of the narrative. This includes the chronological ordering of all events, causal dependency chains, time travel mechanics (if applicable), parallel timeline management (for multi-route works), and temporal consistency verification. The timeline is the backbone that ensures "what happens when" is never in question.

## Trigger
- "Design the timeline"
- "Map out the chronology"
- "When does X happen relative to Y"
- "Design the time travel mechanics"
- "How do the routes diverge temporally"
- "Check temporal consistency"
- "Map causal chains"
- "What's the timeline of the common route"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `story_events` | array | yes | All known plot events with approximate temporal placement |
| `world_history` | array | yes | Historical events from world-designer that predate the story |
| `character_birthdays_and_ages` | array | yes | Character temporal data for age consistency |
| `route_structure` | object | conditional | Route divergence points (required if multi-route) |
| `time_mechanics` | object | conditional | Time travel/multi-timeline rules (required if applicable) |
| `story_start_date` | string | yes | The calendar date/time when the story begins |
| `story_duration` | string | yes | Total narrative duration (e.g., "3 months", "2 weeks", "1 year") |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `timeline_events` | array | Complete timeline event entities for bible-manager |
| `causal_graph` | object | Directed acyclic graph of cause→effect chains |
| `route_timeline_map` | object | Timeline branches per route with divergence/convergence points |
| `temporal_consistency_report` | object | Verification results for age consistency, event ordering, causality |
| `time_mechanics_spec` | object | Complete time travel/multi-timeline rules (if applicable) |
| `calendar_view` | object | Human-readable calendar with all events placed on specific dates |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for existing timeline events (`entity_type: timeline_event, operation: list`)
2. Query `bible-manager` for world history entities
3. Query `bible-manager` for character entities (ages, birthdays)
4. Absorb story events, start date, and duration

### Step 2: Establish Temporal Framework
1. Define the **time model**:
   - **Linear**: Single, unchangeable timeline (White Album 2 style)
   - **Branching**: Multiple possible futures diverging from choice points (Fate/Stay Night style)
   - **Looping**: Time loops with iteration (Steins;Gate world-line style)
   - **Layered**: Multiple timelines/world-lines coexisting
2. If non-linear, design the time mechanics:
   - What can change the past/future
   - What are the costs and limitations
   - What is preserved across changes (Steins;Gate: Reading Steiner)
   - What are the convergence/divergence rules
3. Document time mechanics as formal rules

### Step 3: Place Events on Timeline
1. Create the **absolute timeline** (the true chronological order, including events the reader discovers later)
2. Place every story event with:
   - Exact or approximate timestamp (ISO 8601)
   - Duration estimate
   - Location
   - Participating characters
   - Preceding causal events
   - Resulting effects
3. Mark events as:
   - `present_action`: Happens in narrative present
   - `flashback`: Past event shown retrospectively
   - `flashforward`: Future event previewed
   - `historical`: Background event never directly shown
   - `hidden`: Event the reader doesn't know about yet

### Step 4: Map Causal Chains
1. For each event, identify its **necessary causes** (without this, event couldn't happen)
2. For each event, identify its **sufficient causes** (these together guarantee the event)
3. Build the causal DAG (Directed Acyclic Graph)
4. Verify no causal loops (unless time travel explicitly allows them)
5. Flag events with missing causes (gaps in logic chain)

### Step 5: Handle Route Divergence (Multi-Route Works)
1. Mark the **common route period**: all events shared across routes
2. Identify **divergence points**: specific moments where choices cause timeline branching
3. For each route, map:
   - Route-specific events
   - Events that happen in some routes but not others
   - Events that happen differently across routes
4. Mark **convergence points** (if any): moments where different routes share events again
5. Ensure no route has temporal paradoxes

### Step 6: Verify Temporal Consistency
1. **Age check**: Character ages at each event must be consistent with birthdates
2. **Seasonal check**: Events must match seasonal descriptions (summer festival in summer, etc.)
3. **Duration check**: Travel times, event durations must be realistic
4. **Causality check**: No event precedes its cause
5. **Reveal check**: Hidden events must be placed before their reveals in absolute time

### Step 7: Write to Bible
1. Write all timeline event entities to `bible-manager`
2. Write time mechanics specification (if applicable)
3. Return complete output package

## Validation Rules

1. **Causal Completeness**: Every major plot event must have at least one causal predecessor. Minor events may be coincidental
2. **Temporal Ordering**: Effect events must have timestamps >= their cause events' timestamps (except for time travel where explicitly defined)
3. **Age Consistency**: Character age at event = floor((event_date - birth_date) / 365.25 days). Ages must match character descriptions
4. **Duration Realism**: Event durations must be plausible. A "2-hour conversation" must have sufficient content to justify its length
5. **Seasonal Accuracy**: Described weather, seasonal events, and school calendar must match the date. No cherry blossoms in October without explanation
6. **Route Divergence Logic**: Route divergence points must be reachable from the common route. No "orphaned" route branches
7. **Time Travel Consistency**: If time travel exists, all changes must follow the established mechanics. No ad-hoc exceptions
8. **No Unexplained Time Skips**: Any gap >1 week in the narrative present must be accounted for (what happened during this time)
9. **Reveal Integrity**: Hidden events must be placed in absolute time before any character learns about them
10. **Calendar Coherence**: Day-of-week must match the date. July 28, 2010 was a Wednesday — events on that date must reflect this
