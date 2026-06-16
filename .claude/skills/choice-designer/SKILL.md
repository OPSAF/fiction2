---
name: choice-designer
description: Design meaningful player choice points — decision moments that genuinely branch the narrative, express character values, carry thematic weight, and produce distinct, traceable consequences through the flag system.
---

# choice-designer

## Purpose
Design every player-facing choice point in the visual novel. Choices are the primary interactive mechanic and must be: (1) genuinely difficult (no obvious "correct" answer), (2) expressive of character values, (3) thematically meaningful, (4) mechanically impactful through the flag system, and (5) producing distinct, traceable consequences. A choice where the player instantly knows the right answer is a failed choice.

## Trigger
- "Design the choice points"
- "What choices should the player make here"
- "Create a decision point for this scene"
- "Is this choice meaningful enough"
- "What are the consequences of this choice"
- "Design the choice matrix for the common route"
- "Map choices to route branches"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `scene_context` | object | yes | The scene where the choice appears (characters present, situation, emotional state) |
| `route_design` | object | yes | Route topology and entry conditions from route-designer |
| `character_states` | object | yes | Current relationship states and character knowledge |
| `flag_registry` | object | yes | Current flag definitions from flag-engineer |
| `dramatic_objective` | string | yes | What this choice point needs to accomplish narratively |
| `choice_count` | integer | no | Target number of options (default: 3; range: 2-4) |
| `theme_expression` | string | yes | Which theme(s) this choice should embody |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `choice_point_spec` | object | Complete choice point design with all options |
| `option_designs` | array | Each option with: text, consequences, flag effects, thematic meaning |
| `consequence_map` | object | Immediate vs. delayed consequences per option |
| `flag_effect_spec` | object | Flag operations triggered by each option |
| `choice_difficulty_assessment` | object | How difficult this choice is and why |
| `thematic_alignment_report` | object | How each option expresses or challenges the story's themes |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for scene specification, character states, and flag registry
2. Absorb dramatic objective and theme requirements

### Step 2: Identify Decision-Worthy Junctures
Not every scene needs a choice. A choice point is warranted when:
1. The narrative genuinely branches (different outcomes are possible)
2. Character values are in conflict (different aspects of the protagonist are tested)
3. The player has sufficient information to make a meaningful decision (not guessing blind)
4. The consequences will be felt (immediately or later)

### Step 3: Design Options
For each choice point, design 2-4 options:

**Option Design Principles:**
1. **No Obviously Correct Answer**: If 90% of players pick option B, the choice failed
2. **Value Expression**: Each option represents a different value or priority
   - Example: Tell the truth (honesty) vs. Protect feelings (kindness) vs. Stay silent (caution)
3. **Genuine Trade-offs**: Each option should have both upside and downside
4. **Character Consistency**: The options must all feel like things this protagonist COULD do
5. **Information Asymmetry**: Player knows things the protagonist doesn't (or vice versa), creating tension

**Option Structure:**
```json
{
  "option_id": "choice_03_a",
  "display_text": "The text shown to the player (should be the protagonist's thought/action, not a menu label)",
  "value_stance": "What choosing this says about the protagonist's values",
  "immediate_outcome": "What happens right after this choice (dialogue change, scene direction change)",
  "delayed_consequences": [
    { "trigger_scene": "scene_id", "effect": "What happens later because of this" }
  ],
  "flag_effects": {
    "set": { "flag_name": "value" },
    "increment": { "flag_name": "delta" },
    "decrement": { "flag_name": "delta" }
  },
  "thematic_meaning": "How this choice embodies or challenges a theme",
  "is_trap": false  // true only for choices that lead to bad ends if chosen recklessly
}
```

### Step 4: Design Consequences
1. **Immediate consequences**: Dialogue changes, character reactions, scene direction (visible within 1-2 scenes)
2. **Short-term consequences**: Relationship shifts, information gained/missed, opportunities opened/closed (visible within the route act)
3. **Long-term consequences**: Route determination, character fates, ending type (visible at route end or across routes)
4. The player should see SOME consequence quickly (immediate feedback) and discover SOME consequence later (delayed payoff)

### Step 5: Map Flag Effects
1. Each option must have deterministic flag effects
2. Flag effects include:
   - **Affection flags**: +N or -N to a heroine's affection
   - **Story flags**: Boolean triggers for specific events (saw_event_X = true)
   - **Hidden flags**: Trackers the player doesn't see (trust_level, suspicion_level)
   - **Global flags**: Cross-route persistent variables
3. Flag effects must be internally consistent with the flag system logic
4. Run conflict check: does any combination of choices create an impossible flag state?

### Step 6: Verify Choice Quality
1. **Difficulty check**: No option should be the "obvious right answer"
2. **Consequence distinctness**: Each option must lead to observably different outcomes
3. **Thematic weight**: Each option must express a meaningful value stance
4. **Information sufficiency**: Player must have enough context to make an informed choice
5. **No illusion of choice**: If all options lead to the same outcome, remove the choice point

### Step 7: Write to Bible
1. Write choice point specifications to `bible-manager` as part of scene specifications
2. Provide flag effect specs to `flag-engineer` for integration
3. Return complete output package

## Validation Rules

1. **Choice Impact**: At minimum, each option must change dialogue in the next 3 scenes AND affect at least one flag. Zero-impact choices are forbidden
2. **No Dominant Options**: No single option should be strictly better than all others (no "I win" button)
3. **Consequence Visibility**: At least one consequence of each option must be visible to the player within the same play session
4. **Flag Determinism**: Flag effects must be deterministic. No random flag changes
5. **Route Alignment**: Choices in the common route must collectively determine which heroine routes are accessible
6. **Trap Choice Fairness**: If a choice is a "trap" (leads to bad end), the player must have had sufficient information to potentially avoid it. No death by random choice
7. **Option Count**: 2-4 options per choice point. 2 is acceptable for binary moral decisions; 3 is ideal; 4 only if all four are genuinely distinct
8. **Display Text Quality**: Choice text must feel like natural character thought, not menu navigation. "Maybe I should check on her..." not "Go to heroine A's room"
9. **Thematic Consistency**: Each choice must connect to at least one defined theme
10. **No Redundant Choices**: If two choices in the same scene test the same value (e.g., two "be nice to heroine A" options), consolidate them
