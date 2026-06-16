---
name: flag-engineer
description: Design and manage the narrative flag/state system — affection points, story flags, hidden variables, route entry formulas, and the complete state machine that governs branching logic and ensures mechanical consistency.
---

# flag-engineer

## Purpose
Design the complete flag/state system that mechanically governs the visual novel's branching logic. Every choice consequence, route entry condition, and character relationship state is tracked through flags. This skill ensures the flag system is: (1) complete (every narrative branch is governed by flags), (2) consistent (no contradictory flag states), (3) traceable (every flag change can be traced to a specific choice), and (4) player-fair (the system is discoverable through play).

## Trigger
- "Design the flag system"
- "What flags does this choice set"
- "Check flag consistency"
- "Trace the flag dependencies for route X"
- "Is this flag state reachable"
- "Design the affection point system"
- "Map flag thresholds to route entry"
- "Find flag conflicts"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `route_entry_conditions` | array | yes | All route entry condition formulas from route-designer |
| `choice_consequences` | array | yes | All choice flag effects from choice-designer |
| `character_relationship_states` | object | yes | All relationship dynamics that need flag tracking |
| `bad_end_conditions` | array | yes | Conditions that trigger bad/dead ends |
| `scene_unlock_conditions` | array | conditional | If scenes are gated behind flags (optional scene conditions) |
| `flag_visibility` | enum | yes | Which flags are visible to the player: `none_hidden`, `affection_only`, `key_flags`, `all_visible` |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `flag_registry` | array | Complete flag definitions (name, type, range, default, visibility) |
| `flag_dependency_graph` | object | DAG of flag relationships: which flags influence which |
| `route_entry_formulas` | object | Formal boolean formulas for each route's entry conditions |
| `flag_transition_table` | object | State machine: current state + choice → next state |
| `conflict_report` | object | Flag conflicts, deadlocks, unreachable states |
| `reachability_analysis` | object | Verification that all routes and endings are reachable |
| `flag_progression_curves` | object | Expected flag value trajectories for each route |

## Workflow

### Step 1: Collect Requirements
1. Gather all route entry conditions from `route-designer`
2. Gather all choice consequences from `choice-designer`
3. Gather all bad end conditions
4. Gather all scene unlock conditions (if any)

### Step 2: Design Flag Taxonomy
Flags fall into four categories:

**1. Affection Flags** (感情値)
- Per-heroine numeric values (typically 0-100)
- Increased/decreased by choices related to that heroine
- Primary determinant of route entry
- May be visible or hidden depending on `flag_visibility`

**2. Story Flags** (ストーリーフラグ)
- Boolean triggers marking narrative events
- Examples: `met_mentor`, `discovered_lab`, `confessed_feelings`, `saw_argument`
- Used to gate scenes, dialogue variations, and route branches
- Typically hidden from player

**3. Hidden Variables** (隠しパラメータ)
- Numeric values tracking subtle states
- Examples: `trust_level`, `suspicion`, `mental_state`, `determination`
- Used for nuanced branching (not just true/false)
- Always hidden from player

**4. Global Flags** (グローバルフラグ)
- Cross-route persistent values
- Track which routes have been completed
- Used for true route unlocking, NG+ content
- May be visible as "extras" or "progress" indicators

### Step 3: Define Flag Registry
For each flag:
```json
{
  "flag_id": "heroine_a_affection",
  "type": "affection",
  "target": "character_id (for affection flags)",
  "data_type": "integer | boolean",
  "range": { "min": 0, "max": 100 },
  "default": 0,
  "visibility": "hidden | visible | visible_after_completion",
  "description": "Tracks protagonist's affection level with Heroine A",
  "influenced_by": ["choice_ids"],
  "influences": ["route_entry_A", "scene_sc012_dialogue_variant"],
  "reset_on_new_game": true,
  "carries_to_ng_plus": false
}
```

### Step 4: Build Flag Dependency Graph
1. Map every flag's influences:
   - Which choices set/modify this flag
   - Which flags does this flag depend on (computed flags)
2. Map every flag's dependents:
   - Which route conditions use this flag
   - Which scene variants use this flag
   - Which dialogue branches use this flag
3. Build the complete DAG
4. Detect cycles (A depends on B which depends on A) — these are errors unless explicitly designed as feedback loops

### Step 5: Define Route Entry Formulas
For each route, express entry conditions as boolean formulas:

```
Route_HeroineA = (heroine_a_affection >= 70)
              AND (heroine_a_trust_flag == true)
              AND NOT (heroine_b_confession_triggered)
              AND (common_route_completed == true)

BadEnd_01 = (trust_level <= 20)
           AND (critical_choice_reveal == false)
           AND (current_scene == scene_critical_moment)
```

### Step 6: Build and Verify State Machine
1. Create the **flag transition table**: (current_flag_state, choice_id) → (new_flag_state)
2. Verify reachability: starting from initial state, can every route and ending be reached?
3. Verify no deadlocks: no state from which no valid transition exists
4. Verify no impossible states: no combination of flag values that can never occur
5. Verify route exclusivity: if routes are meant to be exclusive, flag formulas must ensure mutual exclusion

### Step 7: Detect and Resolve Conflicts
1. **Contradictory requirements**: Route A requires flag X, but all paths to route A set flag X to false
2. **Unreachable thresholds**: Heroine route requires affection >= 80, but maximum possible affection is 75
3. **Flag race conditions**: Choice A and Choice B in the same scene both modify the same flag in incompatible ways, but the player can make both choices
4. **Forgotten flags**: A flag is set but never read (wasted complexity) or read but never set (always default)

### Step 8: Write to Bible
1. Write all flag entities to `bible-manager`
2. Return complete output package

## Validation Rules

1. **Route Reachability**: Every defined route must be reachable from the initial game state through at least one valid choice sequence
2. **Bad End Reachability**: Every bad end must be reachable (and must be avoidable — not a "walking dead" scenario unless intentionally designed as such)
3. **Flag Coverage**: Every narrative branch must be governed by at least one flag. No branching based on "invisible" state
4. **No Dead Flags**: Every flag must be both written (at least one choice sets it) AND read (at least one condition checks it)
5. **Deterministic Transitions**: Given the same flag state and same choice, the resulting flag state must always be the same
6. **Threshold Realism**: Affection thresholds must be achievable given the maximum points available through choices
7. **Mutual Exclusivity**: Routes designed as exclusive must have mutually exclusive entry formulas
8. **Reset Integrity**: `reset_on_new_game` flags must actually reset. Carry-over flags must not break early-game logic
9. **No Leakage**: Hidden flags must have no visible indication of their value (no "tell" in the UI or dialogue that reveals hidden state)
10. **NG+ Integrity**: New Game Plus flags must not break the intended first-play experience. NG+ content must be clearly additive, not corrective
