---
name: voice-keeper
description: Maintain character voice consistency — audit every line of dialogue and internal monologue against character voice guides, detect voice drift, flag lines that sound like the wrong character, and ensure each character's linguistic fingerprint remains unique and stable.
---

# voice-keeper

## Purpose
Guard the integrity of each character's unique voice. In a work with multiple characters — especially one spanning hundreds of thousands of words across multiple routes — voice drift is a constant risk. This skill performs systematic voice audits, comparing every line of dialogue and internal monologue against the character's voice guide, detecting drift, catching "voice bleed" (Character A sounding like Character B), and ensuring that deliberate voice evolution (character growth expressed through changing speech patterns) is intentional and tracked.

## Trigger
- "Check character voice consistency"
- "Does X sound right here"
- "Run a voice audit"
- "This dialogue doesn't sound like X"
- "Check for voice drift across routes"
- "Are the characters' voices distinct enough"
- "Audit dialogue for voice accuracy"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `character_voice_guides` | array | yes | Complete voice guides for all characters from bible-manager |
| `dialogue_manuscripts` | array | yes | All dialogue scripts from dialogue-crafter |
| `internal_monologue_passages` | array | yes | All internal monologue from scene-writer (POV character thoughts) |
| `audit_scope` | enum | yes | `single_character`, `scene`, `route`, `full_work` |
| `voice_evolution_events` | array | no | Documented moments where a character's voice intentionally changes (trauma, growth, route-specific development) |
| `previous_audit` | object | no | Prior voice-keeper audit for drift-over-time comparison |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `voice_audit_report` | object | Complete voice consistency analysis |
| `per_character_analysis` | object | Character-by-character voice metrics and deviation flags |
| `voice_deviations` | array | Specific lines that deviate from voice guide, with severity and fix suggestions |
| `voice_bleed_instances` | array | Lines where Character A sounds like Character B |
| `consistency_scores` | object | Per-character consistency score (0-100) |
| `drift_analysis` | object | How voice changes over the course of the narrative (intentional vs. unintentional) |
| `linguistic_fingerprint_comparison` | object | Cross-character voice similarity matrix |

## Workflow

### Step 1: Load Voice Profiles
1. Query `bible-manager` for complete voice guides of all characters
2. For each character, extract the linguistic fingerprint:
   - **Sentence length**: Average words per sentence, standard deviation
   - **Vocabulary richness**: Type-token ratio, unique words used
   - **Register**: Ratio of casual to formal expressions
   - **Emotional leakage**: Ratio of emotionally marked words to neutral words
   - **Speech tic frequency**: How often catchphrases/verbal tics appear
   - **Honorific pattern**: Distribution of honorific types used
   - **Question frequency**: How often they ask questions vs. make statements
   - **Hedge frequency**: Use of "maybe," "perhaps," "I think," "sort of" (uncertainty markers)

### Step 2: Analyze Each Character's Lines
For each character, process all their dialogue and internal monologue:

1. **Extract linguistic metrics** for every line
2. **Compare against voice profile**: Calculate deviation score
3. **Apply statistical threshold**: Flag lines with deviation > 2σ from baseline
4. **Contextual analysis**: Is the deviation justified?
   - Emotional extreme (anger, terror, grief → normal voice patterns break)
   - Relationship context (speaking to superior vs. intimate → register shifts)
   - Intentional growth (character arc → gradual voice evolution)
   - **UNJUSTIFIED**: No contextual reason → voice error

### Step 3: Detect Voice Bleed
1. For each line, calculate similarity to every other character's voice profile
2. Flag lines where Character A's line scores higher similarity to Character B's profile than to their own
3. Voice bleed is especially common between:
   - Characters of similar age/background
   - Characters in the same scene (writer unconsciously homogenizes)
   - Minor characters who share scenes with major characters

### Step 4: Analyze Voice Evolution (Drift Analysis)
1. Track each character's voice metrics chronologically across the narrative
2. Distinguish between:
   - **Healthy stability**: Metrics stay within baseline range
   - **Healthy evolution**: Gradual, directional change matching character arc
   - **Unhealthy drift**: Random fluctuations without narrative cause
   - **Route inconsistency**: Character sounds different in different routes without justification
3. Flag rate-of-change anomalies (sudden voice shifts not at documented evolution events)

### Step 5: Cross-Character Voice Distinctness
1. Build a similarity matrix: Character × Character → voice overlap %
2. Flag any pair with >30% overlap (their voices are too similar)
3. The most common failure: protagonist and same-gender best friend sound identical
4. For each flagged pair, recommend differentiation strategies:
   - Give one character a more distinctive speech tic
   - Adjust vocabulary register for one
   - Change sentence-length tendency for one
   - Differentiate honorific usage patterns

### Step 6: Generate Fix Recommendations
For each voice deviation:
1. **The problematic line** (quoted)
2. **Why it deviates** (which voice metrics are off)
3. **Suggested rewrite** (1-2 alternatives that match the voice guide)
4. **If the deviation is intentional**: Document it as a voice evolution event for future audits

### Step 7: Produce Voice Audit Report
1. Per-character consistency scores
2. All deviations with context and fixes
3. All voice bleed instances
4. Drift analysis with intentionality assessment
5. Cross-character distinctness matrix
6. Overall voice health assessment

## Validation Rules

1. **Consistency Threshold**: Each character must maintain ≥80% voice consistency score. Below 80% requires systematic rewrite
2. **Voice Bleed Prevention**: No line may score higher similarity to another character's profile than to the speaker's own profile
3. **Distinctness Requirement**: Every character pair must have ≤30% voice overlap. Characters with >30% overlap must be differentiated
4. **Drift Intentionality**: Any voice metric shift >1σ over the course of the narrative must be documented as either an intentional evolution event or flagged as unintentional drift
5. **Honorific Consistency**: Honorific usage patterns must be stable. A shift in usage must correspond to a documented relationship change event
6. **Catchphrase Discipline**: Catchphrases/verbal tics must appear at a consistent frequency (±50% of baseline). Overuse (spamming the tic) and underuse (forgetting the tic) are both errors
7. **Emotional Voice Break Justification**: When a character breaks their normal voice patterns (extreme emotion), the cause must be clear from context. Unexplained voice breaks are errors
8. **Route Voice Consistency**: A character's voice in different routes must be consistent except for route-specific character development. Route A's version of a character should not have a different vocabulary than Route B's without narrative justification
9. **Internal Monologue vs. Dialogue Gap**: The gap between how a character thinks and how they speak is a character trait. If the gap collapses (they think and speak identically), flag it
10. **No Generic Lines**: Any line that could be said by "any character" (no identifying features) must be rewritten with voice-specific language
