---
name: reader-simulator
description: Simulate a naive reader's experience through the narrative — model knowledge acquisition, expectation formation, emotional state, mystery-solving attempts, and satisfaction prediction. The ultimate test of whether the story works as designed.
---

# reader-simulator

## Purpose
Simulate the experience of a first-time reader progressing through the narrative. Model what the reader knows at each point, what they expect to happen next, what questions they're asking, how they're interpreting clues, what emotions they're likely feeling, and — critically — whether they're satisfied. The reader-simulator is the closest thing to a playtest before actual playtesting. It answers: "Does this story actually work for a human being experiencing it for the first time?"

## Trigger
- "Simulate the reader experience"
- "What does the reader know by chapter X"
- "Will the reader see this twist coming"
- "Test the reader journey"
- "Is the mystery too obvious / too obscure"
- "Simulate a first-time read"
- "Predict reader satisfaction"
- "Where will readers be confused"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `manuscript_sections` | array | yes | All scene manuscripts in reading order |
| `mystery_design` | object | yes | Complete mystery design with clue map, reveals, red herrings from mystery-designer |
| `emotion_map` | object | yes | Emotional targets per scene from emotion-designer |
| `plot_structure` | object | yes | Plot blueprint from plot-architect |
| `reader_profile` | enum | yes | Target reader type: `casual` (reads lightly), `attentive` (notices details), `analytical` (tries to solve mysteries), `re-reader` (has full knowledge) |
| `route_simulation` | string | yes | Which route to simulate (or `common_route` for the shared section) |
| `simulate_blind` | boolean | no | If true, simulator has zero prior knowledge (true first read). If false, simulator knows genre/tags (like a real player who read the synopsis) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `reader_journey_report` | object | Complete reader experience simulation |
| `knowledge_state_timeline` | array | Scene-by-scene: what the reader knows, believes, and suspects |
| `expectation_accuracy_map` | object | What the reader predicted vs. what actually happened |
| `mystery_solvability_assessment` | object | When (if ever) the reader could theoretically solve each mystery |
| `emotional_journey` | object | Predicted emotional states vs. designed emotional targets |
| `confusion_risk_points` | array | Scenes where reader may lack sufficient context |
| `satisfaction_prediction` | object | Predicted satisfaction scores for key story beats and endings |
| `re_read_value_assessment` | object | Which moments gain meaning on second reading |

## Workflow

### Step 1: Initialize Reader Model
Create a naive reader model:
1. **Knowledge state**: Empty (or synopsis-level if not blind)
2. **Belief state**: Default genre expectations
3. **Emotional state**: Neutral/anticipatory
4. **Question log**: Empty (questions the reader wants answered)
5. **Prediction log**: Empty (what the reader thinks will happen)
6. **Suspicion tracker**: Which characters/events seem suspicious
7. **Confidence level**: How confident the reader feels about their understanding

### Step 2: Process Each Scene Sequentially
For each scene, update the reader model:

**Knowledge Acquisition:**
- What new facts does the reader learn?
- What previous beliefs are confirmed/contradicted?
- What was previously ambiguous that's now clarified?

**Clue Processing:**
- Did the reader notice this clue? (probability based on `difficulty` and `reader_profile`)
- If noticed: How is the reader interpreting it?
- Is the reader connecting this clue to previous clues?
- Is the reader forming (or revising) a theory?

**Expectation Formation:**
- Based on current knowledge, what does the reader expect to happen next?
- What outcomes does the reader think are likely/possible/impossible?
- Track prediction accuracy over time

**Emotional Response:**
- Is the designed emotional target likely to be achieved?
- Does the reader have sufficient investment to feel the intended emotion?
- Is there emotional whiplash (too-rapid emotional shifts)?
- Is the reader likely to cry/laugh/gasp at the intended moments?

**Question Management:**
- New questions raised by this scene
- Questions answered by this scene
- Lingering questions (unresolved for too long → confusion risk)
- If >3 major unresolved questions accumulate → flag confusion risk

### Step 3: Mystery-Solving Simulation
For each mystery in the design:

1. **Track the "solve window"**: The point between when sufficient clues exist and when the reveal occurs
2. **Calculate solvability per scene**: Given clues presented so far, could an analytical reader solve it?
3. **Predict when different reader types would solve**:
   - Analytical reader: Solves at earliest solvability point
   - Attentive reader: Solves 2-3 scenes before reveal
   - Casual reader: Solves at reveal (ideal) or not at all (failure)
4. **If the analytical reader solves too early**: The mystery feels obvious → reduce clue obviousness
5. **If the casual reader can't understand the reveal**: The mystery feels unfair → add clearer clues

### Step 4: Satisfaction Prediction
For major story beats (reveals, climaxes, catharsis points, endings):

1. **Setup-Payoff Ratio**: Was sufficient emotional/narrative investment built?
2. **Surprise + Inevitability**: Is the outcome surprising yet retrospectively obvious?
3. **Emotional Payoff**: Does the emotional release match the investment?
4. **Intellectual Payoff**: Does the resolution make sense and feel earned?
5. **Predict satisfaction score** (1-10) for each beat

### Step 5: Identify Experience Problems

**Confusion Risks:**
- Scenes where the reader lacks context to understand what's happening
- Too many unresolved questions (>3) creating cognitive overload
- Contradictory information that hasn't been reconciled yet

**Predictability Problems:**
- Major twists that >80% of attentive readers would see coming >5 scenes early
- "Obvious" mystery solutions that make the protagonist look slow

**Emotional Failure Points:**
- Scenes designed for high emotion that lack sufficient buildup
- Emotional beats that the reader isn't invested enough to feel
- Catharsis that feels unearned

**Engagement Drops:**
- Sections where the reader model predicts "putting the work down"
- Scenes where nothing changes in reader knowledge, emotional state, or plot progress

### Step 6: Generate Re-read Value Assessment
Simulate a second read:
1. Which lines/scenes gain new meaning with full knowledge?
2. Which foreshadowing elements become visible?
3. Which character behaviors are recontextualized?
4. Score the re-read experience: does the work reward a second reading?

### Step 7: Produce Reader Journey Report
1. Complete knowledge state timeline
2. Emotional journey vs. designed targets
3. Mystery solvability analysis
4. Satisfaction predictions
5. Problem points with recommendations
6. Re-read value assessment

## Validation Rules

1. **Knowledge Acquisition Order**: The reader must learn facts in an order that allows comprehension. Critical context must precede events that require it
2. **Mystery Fairness**: The analytical reader must be able to solve each mystery at least 1 scene before its reveal (fair play). The casual reader must be able to understand the reveal when it happens
3. **Question Budget**: At no point should the reader have >5 major unresolved questions. >5 = cognitive overload and confusion
4. **Emotional Investment Requirement**: Before a major emotional beat (intensity ≥ 7), the reader must have at least 3 scenes of investment in the affected characters/relationships
5. **Surprise + Inevitability Balance**: Major reveals should be surprising on first encounter but feel "of course!" in retrospect. Predictability score for major reveals should be ≤50% for attentive readers at 2 scenes before reveal
6. **No Abandonment Zones**: No sequence of 3+ scenes where zero knowledge/emotional/plot change occurs for the reader
7. **Ending Satisfaction Floor**: Predicted satisfaction for any route ending must be ≥5/10. Below 5 = structural problem requiring rewrite
8. **Confusion Resolution**: Any scene flagged as "confusion risk" must be followed within 3 scenes by clarifying information
9. **Emotional Target Accuracy**: At least 70% of designed emotional targets must be predicted as achievable. Systematic emotional failure indicates a structural mismatch between design and execution
10. **Re-read Value Minimum**: At least 5 moments must be identified where full knowledge significantly changes the reading experience. Zero re-read value moments = insufficient depth
