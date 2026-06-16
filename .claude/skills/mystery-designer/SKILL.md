---
name: mystery-designer
description: Design mysteries, foreshadowing, clue chains, reveals, and the information-release schedule that controls reader knowledge. Plants fair-play clues and tracks the reader's epistemological journey.
---

# mystery-designer

## Purpose
Design the complete mystery architecture — the truth beneath the surface, the surface narrative the reader initially believes, the clue chain that leads from one to the other, the foreshadowing that makes reveals feel inevitable in retrospect, red herrings that misdirect fairly, and the information-asymmetry matrix that tracks who knows what when. Inspired by Steins;Gate's layered reveals and Death Note's cat-and-mouse information warfare.

## Trigger
- "Design the central mystery"
- "Plant foreshadowing for the reveal"
- "What clues should the reader have by chapter X"
- "Design the mystery's clue chain"
- "Is this mystery fairly solvable"
- "Design the reveal sequence"
- "What does each character know at this point"
- "Create a red herring"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `mystery_type` | enum | yes | Type of mystery: `whodunit`, `howdunit`, `whydunit`, `what_is_happening`, `character_secret`, `world_secret`, `conspiracy` |
| `the_truth` | object | yes | Complete description of what actually happened/is true |
| `surface_narrative` | object | yes | What the reader (and most characters) initially believe |
| `plot_architecture` | object | yes | Plot structure with key scenes and their order |
| `character_knowledge_states` | object | yes | Initial knowledge state for each character |
| `reveal_schedule` | array | yes | Target scenes/chapters for each major reveal |
| `fair_play_requirement` | boolean | no | Must the reader be able to solve before the reveal? (default: true) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `mystery_entities` | array | Mystery bible entries (truth, surface, clues, red herrings) |
| `clue_map` | object | Complete clue placement map: scene → clues planted → what they suggest |
| `foreshadowing_registry` | array | All foreshadowing elements with their payoff scenes |
| `reveal_sequence` | array | Ordered reveal beats with dramatic impact scores |
| `red_herring_catalog` | array | All red herrings with their alternative explanations |
| `information_asymmetry_matrix` | object | Character × Knowledge grid tracking who knows what when |
| `fair_play_report` | object | Verification that the mystery is solvable with given clues |

## Workflow

### Step 1: Define the Truth
1. Write the complete, unambiguous truth of what happened
2. Include: who, what, when, where, why, how
3. Identify which parts of the truth are:
   - **Layer 1**: Revealed in common route
   - **Layer 2**: Revealed in specific heroine routes
   - **Layer 3**: Only revealed in true route
   - **Layer 4**: Implied but never explicitly stated (reader must infer)

### Step 2: Design the Surface Narrative
1. Construct the false/misleading version that the reader initially believes
2. The surface must be:
   - **Plausible**: A reasonable person would believe it
   - **Flawed**: Contains small inconsistencies the attentive reader notices
   - **Thematic**: The surface narrative reflects the story's themes (even if falsely)
3. Map the gap between surface and truth — this gap IS the mystery

### Step 3: Build the Clue Chain
1. Start from the truth and work backwards:
   - What evidence would the truth leave behind?
   - Who would know fragments of the truth?
   - What doesn't add up in the surface narrative?
2. Design clues at four difficulty levels:
   - **Obvious**: Most readers notice (establishes mystery exists)
   - **Noticeable**: Attentive readers catch (builds engagement)
   - **Subtle**: Only re-readers notice (reward for investment)
   - **Hidden**: Requires connecting multiple scenes (genius-level)
3. Place clues on the timeline with increasing density as reveals approach
4. Ensure the **fair play principle**: a reader who catches all subtle+ clues could theoretically solve the mystery

### Step 4: Design Red Herrings
1. Create alternative explanations that:
   - Are internally consistent
   - Point to a wrong conclusion
   - Have their own explanation when the truth is revealed
2. Red herrings must:
   - Not be stronger than real clues (unfair)
   - Have a "oh, that's why that seemed suspicious" moment when truth is revealed
   - Be distributed evenly (not all clustered)

### Step 5: Design Reveal Beats
1. Each major reveal needs:
   - **Setup**: Clues that make it possible to anticipate
   - **Trigger**: The specific event/scene that forces the reveal
   - **Delivery**: How the information is communicated (dialogue, discovery, deduction)
   - **Aftermath**: Immediate consequences and character reactions
   - **Recontextualization**: How this changes the meaning of past scenes
2. Sequence reveals for maximum dramatic impact:
   - Small reveals build to large reveals
   - Each reveal raises new questions while answering old ones
   - Final reveal recontextualizes the entire story

### Step 6: Map Information Asymmetry
1. Create a matrix: Characters × Key Facts
2. Track when each character learns each fact
3. Ensure no character acts on knowledge they don't have
4. Design dramatic irony moments (reader knows, character doesn't)
5. Design surprise moments (character knows, reader doesn't)
6. This matrix is the definitive reference for narrative-doctor

### Step 7: Verify and Write
1. Run fair play verification: can the mystery be solved?
2. Verify all clues are placed before their corresponding reveals
3. Verify no character violates their knowledge state
4. Write all mystery entities to `bible-manager`
5. Return complete output package

## Validation Rules

1. **Fair Play**: All clues needed to solve the mystery must be present in the narrative before the reveal. The reader must have a theoretical chance
2. **Clue-Reveal Ordering**: Every clue must appear before the reveal it supports (unless it's a retrospective clue shown in flashback)
3. **Red Herring Explainability**: Every red herring must have a satisfying alternative explanation revealed when the truth comes out
4. **Knowledge State Integrity**: No character may act on, reference, or imply knowledge of facts they haven't learned yet
5. **Reveal Impact Hierarchy**: Small reveals serve big reveals. No big reveal should come before its setup clues
6. **Information Density Curve**: Clue density should increase as reveals approach. Early chapters: sparse clues. Late chapters: dense clue convergence
7. **Surface Narrative Plausibility**: The false surface narrative must be believable. If it's obviously wrong from chapter 1, there's no mystery
8. **Recontextualization Value**: Each reveal should make the reader want to re-read earlier scenes. "Oh, THAT'S what that meant"
9. **No Cheating**: The truth cannot rely on information the reader had zero access to (hidden scenes the reader never saw, facts from cut content)
10. **Unresolved Threads**: Any mystery thread introduced must be resolved (or intentionally left ambiguous with thematic purpose). No forgotten clues
