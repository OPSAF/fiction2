---
name: route-designer
description: Design branching narrative routes — heroine routes, true route, bad endings, route entry conditions, route-specific dramatic questions, and the route topology that defines the player's journey through the story.
---

# route-designer

## Purpose
Design the branching narrative architecture — the player-navigable paths through the story. Each route is a complete dramatic experience with its own dramatic question, character focus, emotional signature, and ending. Routes must be distinct enough to justify their existence while forming a coherent whole where each route enriches the understanding of the others (the Fate/Stay Night model).

## Trigger
- "Design the route structure"
- "Create the heroine routes"
- "How does the player get to X's route"
- "Design the true route"
- "Where should bad endings go"
- "What's the route topology"
- "Design route entry conditions"
- "How many routes should this have"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `plot_blueprint` | object | yes | Master plot structure from plot-architect |
| `character_bible` | array | yes | All character entities, especially heroines |
| `route_heroines` | array | yes | Which characters get dedicated routes |
| `true_route_required` | boolean | no | Whether there's a final true route unlocked after others (default: true) |
| `bad_end_count` | integer | no | Target number of bad/dead ends (default: 3-5) |
| `common_route_end_point` | string | yes | Which beat/scene marks the end of the common route |
| `route_structure_type` | enum | yes | `sequential_unlock` (play any order), `enforced_order` (route A → B → C), `hidden_unlock` (true route appears after conditions met) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `route_topology` | object | Complete route map: all routes, their relationships, entry/exit points |
| `route_entities` | array | Route bible entries (one per route) ready for bible-manager |
| `route_dramatic_questions` | object | The unique dramatic question each route answers |
| `entry_condition_formulas` | object | Flag/choice formulas required to enter each route |
| `bad_end_map` | object | Where bad ends occur, what triggers them, what they teach |
| `route_differentiation_report` | object | Verification that each route is sufficiently distinct |
| `true_route_requirements` | object | What must be completed/understood before true route |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for plot blueprint, character entities, and existing route entities
2. Absorb common route end point and structure type

### Step 2: Define Route Topology
1. Map the complete route graph:
   ```
   Common Route (Ki + Shō)
        │
        ├── Ten (Twist Point) ──── Choice Matrix ──┬── Heroine A Route ──┬── Good End
        │                                           ├── Heroine B Route ──┬── Good End
        │                                           ├── Heroine C Route ──┬── Good End
        │                                           ├── Bad End 1         ├── Bad End
        │                                           ├── Bad End 2         └── Normal End
        │                                           └── Bad End 3
        │
        └── [After completing required routes] ── True Route ─── True End
   ```
2. Define route relationships:
   - **Independent routes**: Can be played in any order
   - **Escalating routes**: Each route reveals more; later routes assume earlier knowledge
   - **Contrasting routes**: Routes designed as foils to each other

### Step 3: Design Each Route

For each heroine route:
1. **Dramatic Question**: What specific question does this route answer?
   - Example: "Can love survive when built on deception?" (White Album 2 Koharu route)
   - Not just "Will they get together?" — that's the baseline
2. **Route Theme**: What thematic lens does this route provide?
3. **Character Arc Focus**: How does the protagonist change specifically in this route?
4. **Heroine's Hidden Depths**: What does this route reveal about the heroine that other routes don't?
5. **Route-Specific Conflict**: What obstacle is unique to this route?
6. **Ending Design**:
   - **Good End**: The cathartic resolution (earned, not guaranteed)
   - **Normal End**: Bittersweet but complete
   - **Bad End** (route-specific): What failure looks like for this relationship

### Step 4: Design True Route
1. The true route must:
   - Resolve the **central dramatic question** of the entire work
   - Reference and synthesize events/reveals from all other routes
   - Provide the **deepest layer of truth** (mystery resolution, world truth)
   - Deliver the **highest emotional payoff**
2. True route often features:
   - The "main" heroine (or no heroine, focusing on the protagonist's truth)
   - Confrontation with the true antagonist
   - Resolution of the protagonist's deepest wound

### Step 5: Design Bad Ends
1. Bad ends must be **educational**: the player should understand WHY they failed
2. Place bad ends at **critical failure points**:
   - Trust betrayed at the worst moment
   - Wrong choice in a life-or-death situation
   - Failure to understand a character's true feelings
3. Each bad end should **reveal something**: a character's dark side, a hidden truth, a "what if" that enriches understanding
4. Bad ends should not be random; they should be the logical consequence of specific choices

### Step 6: Define Entry Conditions
1. For each route, define the flag formula required:
   - Express as boolean logic over flag values
   - Example: `(heroine_a_affection >= 70) AND (heroine_a_trust_flag == true) AND NOT (heroine_b_route_triggered)`
2. Map the choice sequence that naturally leads to this route
3. Ensure entry conditions are **discoverable** (attentive player can figure out how to reach each route)
4. Ensure entry conditions don't conflict (player can't be locked into two routes simultaneously)

### Step 7: Verify Route Differentiation
1. Each route must have >50% unique content (scenes not shared with other routes)
2. Each route must answer a different dramatic question
3. Each route must reveal different aspects of the protagonist
4. Each route's emotional signature must be distinct

### Step 8: Write to Bible
1. Write all route entities to `bible-manager`
2. Return complete output package

## Validation Rules

1. **Dramatic Question Uniqueness**: No two routes may answer the same dramatic question
2. **Entry Condition Determinism**: Route entry must be deterministic based on flag states. No random routing
3. **Common Route Sufficiency**: Common route must provide all context needed to understand any individual route
4. **True Route Dependency**: True route must reference specific knowledge from at least 2 other routes
5. **Bad End Logic**: Each bad end must be traceable to specific player choices. No "gotcha" bad ends
6. **Content Overlap Limit**: No two routes may share >50% of their scene content
7. **Ending Variety**: A single work should not have all "happy" endings or all "tragic" endings. Emotional variety is mandatory
8. **Heroine Agency**: In each heroine's route, she must make at least one critical decision that affects the outcome. She cannot be purely passive
9. **Route Length Balance**: The shortest heroine route must be at least 60% the length of the longest (unless narratively justified)
10. **True Route Justification**: The true route must justify its "true" designation. It must be the most comprehensive resolution
