---
name: plot-architect
description: Design the overall narrative structure — acts or kishōtenketsu, turning points, parallel plotlines, climax hierarchy, and cross-route architecture. Produces the master plot blueprint that all routes and scenes derive from.
---

# plot-architect

## Purpose
Design the master narrative architecture — the structural skeleton that all routes, scenes, and character arcs hang upon. Whether using Western three-act structure, Japanese kishōtenketsu (起承転結), or a hybrid, this skill defines the turning points, parallel plotlines, climax hierarchy, and the structural relationship between the common route and route-specific branches.

## Trigger
- "Design the plot structure"
- "Structure the story"
- "What's the three-act breakdown" / "Design the kishōtenketsu"
- "Where are the turning points"
- "How do the parallel plotlines intersect"
- "Design the climax hierarchy"
- "Map the common route structure"
- "What happens in each act"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `story_concept` | object | yes | High-level story premise and dramatic question |
| `world_bible` | array | yes | World entities from bible-manager (for setting constraints) |
| `character_bible` | array | yes | Character entities from bible-manager (for arc integration) |
| `timeline` | array | yes | Timeline events from bible-manager |
| `route_count` | integer | yes | Number of planned routes (heroine + true + bad) |
| `target_total_word_count` | integer | yes | Estimated total word count across all routes |
| `structure_type` | enum | yes | `three_act`, `kishōtenketsu`, `five_act`, `hybrid` |
| `genre_conventions` | object | yes | Genre-specific structural expectations |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `plot_blueprint` | object | Complete plot structure with acts, turning points, and beats |
| `beat_sheet` | array | Ordered list of narrative beats with descriptions and word count allocations |
| `parallel_plotline_map` | object | Multiple plotlines and their intersection points |
| `climax_hierarchy` | object | Climax ranking (which route's climax is the "true" climax) |
| `common_route_structure` | object | Common route beat sheet (shared beginning across all routes) |
| `cross_route_map` | object | How routes relate structurally (shared beats, divergences, thematic echoes) |
| `word_count_budget` | object | Word count allocation per act, per route, per beat |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for world entities, characters, and timeline events
2. Absorb story concept, genre conventions, and target word count
3. Confirm structure type (kishōtenketsu is default for Japanese VN/galgame)

### Step 2: Establish Structural Framework

**If kishōtenketsu (起承転結):**
- **Ki (起) — Introduction**: Establish world, characters, normal life (~20% of word count)
- **Shō (承) — Development**: Deepen relationships, build stakes, develop mysteries (~30%)
- **Ten (転) — Twist**: The dramatic turn; everything changes; the "OH SHIT" moment (~30%)
- **Ketsu (結) — Resolution**: Consequences, climax, catharsis, closure (~20%)

**If three-act:**
- **Act I — Setup**: Ordinary world, inciting incident, crossing the threshold (~25%)
- **Act II — Confrontation**: Rising stakes, midpoint reversal, darkest moment (~50%)
- **Act III — Resolution**: Climax, falling action, new equilibrium (~25%)

The kishōtenketsu is particularly well-suited for the "common route (ki + shō) → heroine route (ten + ketsu)" structure of galgames.

### Step 3: Place Major Turning Points
1. **Inciting Incident**: The event that kicks off the story (end of Ki / early Act I)
2. **First Turning Point**: Irreversible commitment to the story's central conflict
3. **Midpoint Reversal**: Something that changes the nature of the conflict (often a reveal)
4. **Darkest Moment / "All Is Lost"**: The low point before the climax
5. **Climax**: The decisive confrontation/resolution of the central dramatic question
6. **Denouement**: New equilibrium, emotional landing

Each turning point must:
- Cause a genuine change in direction (not just "more of the same")
- Have clear cause (not random)
- Affect the protagonist's emotional state measurably

### Step 4: Design Parallel Plotlines
1. **A-Plot (Main Plot)**: The central dramatic conflict (e.g., "prevent the conspiracy," "win the tournament")
2. **B-Plot (Relationship Plot)**: The primary emotional/romantic arc
3. **C-Plot (Character Arc)**: The protagonist's internal transformation
4. **Mystery Plot** (optional): The truth-discovery throughline
5. Map intersection points: where do these plotlines collide or comment on each other?
6. Ensure no plotline is abandoned for extended periods

### Step 5: Design Common Route
1. The common route must establish:
   - All major characters and their baseline relationships
   - The world rules and normal state
   - The central dramatic question
   - At least one meaningful choice per heroine
   - Sufficient investment that the reader cares about the route branches
2. Common route typically ends at or just after the Ten (Twist)
3. Route branches diverge from the consequences of the Twist

### Step 6: Design Cross-Route Architecture
1. **Common beats**: Scenes that appear in all routes (or with route-specific variations)
2. **Route-unique beats**: Scenes exclusive to one route
3. **Echo beats**: Different routes have parallel scenes that comment on each other (Fate/Stay Night: the basement scene in Fate vs. UBW vs. HF)
4. **Knowledge layering**: Information revealed in one route recontextualizes scenes in other routes
5. **True route requirements**: What the reader must know from other routes before the true route makes full sense

### Step 7: Allocate Word Count Budget
1. Distribute target word count across:
   - Common route vs. route-specific content
   - Acts/sections within each
   - Heroine routes (equal or weighted by narrative importance)
2. Ensure no route is severely under/over-weighted relative to its dramatic importance

### Step 8: Verify and Write
1. Verify structural completeness: all required turning points present
2. Verify plotline convergence: all plotlines intersect at least twice
3. Verify word count budget is realistic
4. Write plot blueprint to `bible-manager` (as scene_spec entities for the beat sheet)
5. Return complete output package

## Validation Rules

1. **Structure Completeness**: All required structural elements (acts, turning points) must be present and ordered correctly
2. **Turning Point Causality**: Each turning point must have a clear cause. No deus ex machina
3. **Plotline Balance**: No plotline may be absent for >20% of the total narrative length
4. **Common Route Completeness**: Common route must establish all elements needed for any route to be comprehensible
5. **Climax Hierarchy**: If there's a true route, its climax must be the most significant. Heroine route climaxes must not overshadow the true route
6. **Word Count Proportionality**: Each act's word count must be within ±10% of its target allocation
7. **Genre Convention Compliance**: Must meet genre expectations (romance has confession scene, mystery has reveal scene, etc.) unless intentionally subverting
8. **Beat Density**: No single beat should exceed 15% of total common route word count (prevents pacing problems)
9. **Cross-Route Echoes**: At least 3 echo beats should exist across routes (scenes that gain new meaning when you've read other routes)
10. **Character Arc Integration**: Every major character's arc must have plot beats that enable their transformation
