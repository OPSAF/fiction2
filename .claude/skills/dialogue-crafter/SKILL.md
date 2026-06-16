---
name: dialogue-crafter
description: Write character-specific dialogue — conversations, monologues, subtext, and verbal sparring. Every line must be attributable to its speaker without a name tag, carry subtext, and advance either plot or character (preferably both).
---

# dialogue-crafter

## Purpose
Craft dialogue that is: (1) instantly attributable to its speaker by voice alone, (2) laden with subtext (characters rarely say exactly what they mean), (3) advancing plot, character, or both simultaneously, and (4) culturally authentic in honorific usage and conversational norms. Dialogue is the primary vehicle for character expression in visual novels — it must be excellent.

## Trigger
- "Write the dialogue for this scene"
- "What would X say here"
- "Craft the conversation between X and Y"
- "This dialogue sounds flat — fix it"
- "Make this sound more like X"
- "Write the confession dialogue"
- "Add subtext to this conversation"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `scene_manuscript` | object | yes | Scene prose from scene-writer with `[DIALOGUE_REFINE]` markers |
| `character_voice_guides` | array | yes | Voice guides for all characters in the conversation |
| `relationship_states` | object | yes | Current relationship states between all conversation participants |
| `conversation_objective` | object | yes | What each character wants from this conversation (may differ per character) |
| `emotional_context` | object | yes | Emotional state of each character entering the conversation |
| `subtext_requirements` | object | yes | What should be communicated beneath the surface |
| `cultural_context` | object | yes | Setting-specific conversational norms (era, location, social context) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `dialogue_script` | string | Complete dialogue with character voice markers and stage directions |
| `subtext_annotation` | object | Line-by-line subtext analysis: what's really being said vs. what's spoken |
| `voice_consistency_report` | object | Per-character verification that each line matches their voice guide |
| `power_dynamic_analysis` | object | How power shifts through the conversation (who leads, who follows) |
| `honorific_audit` | object | All honorific usage with justification for each instance |
| `alternative_readings` | array | How the conversation reads on second pass with full knowledge (for re-read value) |

## Workflow

### Step 1: Load Character Voices
1. Query `bible-manager` for complete voice guides of all characters in the scene
2. For each character, internalize:
   - Speech patterns (sentence length, complexity, directness)
   - Vocabulary register (word choice level)
   - Catchphrases and verbal tics
   - Default honorific level
   - Emotional expressiveness (how much feeling leaks into words)
   - Forbidden words/phrases
   - How their speech differs from their internal monologue

### Step 2: Establish Conversation Architecture
1. Define each character's **conversation goal**:
   - What do they want to achieve with their words?
   - What are they trying to hide?
   - What are they trying to discover?
2. Map the **power dynamic**:
   - Who has higher status in this conversation?
   - Does the power shift during the conversation?
   - Is someone manipulating, pleading, threatening, confessing?
3. Determine the **conversation type**:
   - **Exposition dialogue**: Conveying information (danger: can feel unnatural)
   - **Conflict dialogue**: Characters in opposition (verbal sparring)
   - **Bonding dialogue**: Building intimacy/understanding
   - **Subtext dialogue**: What's said ≠ what's meant (the default for serious works)
   - **Climax dialogue**: Confession, revelation, confrontation

### Step 3: Draft the Dialogue
For each line of dialogue:

**Voice Check (before writing the line):**
1. Would this character use these specific words?
2. What's their sentence length tendency?
3. What honorific would they use for this person?
4. How much emotion would leak into their words?
5. Do they speak directly or indirectly?

**Subtext Layer:**
1. What does the character literally say? (surface text)
2. What do they actually mean? (subtext)
3. Why can't they say it directly? (the barrier — pride, fear, social norm, strategy)
4. What does the listener understand? (may differ from both surface and subtext)

**Action Integration:**
- Dialogue doesn't happen in a vacuum. Interleave:
  - Physical actions during speech
  - Facial expressions and body language
  - Internal reactions (if POV character)
  - Environmental interactions (sipping tea, looking away, touching hair)

### Step 4: Apply Japanese Conversational Norms (for Japanese-setting works)
1. **Honorific usage** (must be precise):
   - `-san`: Default polite, professional distance
   - `-kun`: Male junior/equal, female to close male friend
   - `-chan`: Close friends, children, female intimates
   - `-sama`: Extreme respect, master/servant, divine
   - `-senpai`: Senior in organization/school
   - `-sensei`: Teacher, doctor, master of craft
   - **No honorific (yobisute)**: Intimate (family, lovers, extremely close friends) OR rude (deliberately dropping honorifics)
   - **Name shifts**: When a character switches from surname+san to first name — THIS IS A MAJOR RELATIONSHIP MILESTONE

2. **Conversational rhythms**:
   - Aizuchi (相槌): Backchannel responses (un, hai, sou desu ne) — listeners actively signal attention
   - Indirect refusal: Japanese characters rarely say "no" directly. "Chotto..." (it's a bit...), "Kangaete okimasu" (I'll think about it)
   - Reading the air (空気を読む): Characters notice what's NOT being said

3. **Contextual formality shifts**:
   - Public vs. private settings
   - Presence of seniors/authority figures
   - Emotional intensity causing formality breakdown

### Step 5: Verify Line Attributability
**The Blind Attribution Test**: Remove all dialogue tags. Can you tell who said each line?
- If two characters' lines are interchangeable, rewrite until they're not
- Each character's word choice, rhythm, and emotional leakage should fingerprint every line

### Step 6: Verify Subtext Completeness
1. Every conversation of 4+ exchanges must have at least one layer of subtext
2. Map what's really being communicated beneath the surface
3. Ensure subtext is eventually comprehensible (on first read, it creates intrigue; on second read, it's clear)
4. Avoid "subtext" that's actually just the character lying (lying ≠ subtext; subtext is communication through what's unsaid)

### Step 7: Write Output
1. Produce final dialogue script with:
   - Character name labels (for manuscript clarity)
   - Stage directions [in brackets]
   - Subtext annotations [as comments or separate annotation layer]
2. Return complete output package

## Validation Rules

1. **Blind Attribution**: 100% of lines must be correctly attributable to their speaker without name tags. Zero "could be either character" lines
2. **Voice Guide Compliance**: Each line must match the character's defined speech patterns, vocabulary, and expressiveness. No out-of-voice lines unless intentionally showing emotional break
3. **Subtext Requirement**: Every conversation exceeding 3 exchanges must have documentable subtext (something communicated beyond literal meaning)
4. **Honorific Accuracy**: Honorific usage must match the relationship state between characters. A shift in honorifics must correspond to a relationship milestone
5. **Double Duty**: Each line must advance plot OR character (preferably both). No "filler" dialogue that does neither
6. **Power Dynamic Consistency**: Character A cannot simultaneously defer to and dominate Character B in the same conversation (unless deliberately showing emotional volatility)
7. **No Exposition Mouthpiece**: Characters cannot say things they wouldn't naturally say just to inform the reader. "As you know, brother, our father died three years ago..." is forbidden
8. **Cultural Authenticity**: Conversational norms must match the setting. Japanese schoolgirls don't speak like American teenagers
9. **Emotional Plausibility**: Character's emotional state must influence their dialogue. An enraged character doesn't speak in calm, measured sentences
10. **Re-read Value**: Dialogue must contain elements that gain new meaning on second reading (foreshadowing, dramatic irony, misunderstood subtext that clicks later)
