---
name: scene-writer
description: Write individual scenes — narrative prose, environmental description, action sequences, internal monologue. Each scene is a self-contained dramatic unit with clear objective, emotional target, and narrative progression.
---

# scene-writer

## Purpose
Write individual scenes as complete dramatic units. A scene is the fundamental building block of narrative: it has a clear objective, it changes at least one story element (character state, plot progress, reader knowledge, or emotional condition), and it leaves the story different than it found it. This skill produces prose manuscripts that integrate all bible data — world, character, emotion, plot — into immersive, voice-consistent narrative.

## Trigger
- "Write the scene where..."
- "Draft scene X"
- "Write the confession scene"
- "Continue from here"
- "Write the opening scene"
- "Write the climax of route X"
- "Draft this story beat"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `scene_spec` | object | yes | Scene specification from bible (location, characters, plot beat, emotional target, word count range) |
| `scene_objective` | string | yes | What must change in this scene (the "delta") |
| `preceding_scene_context` | object | yes | What happened in the immediately preceding scene(s) for continuity |
| `pov_character_id` | string | yes | Which character's perspective is this scene told from |
| `emotional_target` | object | yes | Target primary emotion + intensity from emotion-designer |
| `bible_context` | object | yes | All relevant bible entries (characters present, location, timeline position, flag states at this point) |
| `word_count_target` | object | yes | `{ min: int, target: int, max: int }` |
| `scene_type` | enum | yes | `dialogue_heavy`, `action`, `introspection`, `exposition`, `transition`, `climax`, `denouement` |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `manuscript` | string | Complete scene prose |
| `scene_metadata` | object | Word count, POV consistency check, emotional target hit confirmation |
| `dialogue_placeholders` | array | Marked spots where dialogue-crafter should refine character-specific lines |
| `continuity_notes` | object | State changes: what's different after this scene (for next scene's context) |
| `self_review_notes` | object | Writer's own assessment of scene quality against spec |
| `flag_state_changes` | array | If choices occur in this scene, the expected flag changes (for flag-engineer verification) |

## Workflow

### Step 1: Load All Context
1. Query `bible-manager` for:
   - Scene specification and its place in the plot blueprint
   - All characters appearing in the scene (full profiles + voice guides)
   - Location description (full sensory detail)
   - Timeline position (what just happened, what happens next)
   - Emotional target for this beat
   - Current flag states at this narrative point
2. Absorb preceding scene's continuity notes

### Step 2: Establish Scene Foundation
1. Define the **scene question**: What unresolved tension drives this scene forward?
2. Define the **scene delta**: What is different at the end vs. the beginning?
   - Character: Relationship shift, emotional change, new information learned
   - Plot: Event occurs, decision made, obstacle overcome/encountered
   - Knowledge: Reader learns something, mystery deepens, clue planted
   - State: Flag changes, location changes, time advances
3. Determine the **scene shape**:
   - Opening hook (first 1-3 sentences grab attention)
   - Rising action within the scene
   - Scene climax (the moment the scene exists to deliver)
   - Closing (emotional landing, transition hook to next scene)

### Step 3: Write the Opening
1. **Hook types** (choose based on scene context):
   - _In medias res_: Drop into ongoing action/dialogue
   - _Sensory immersion_: Establish atmosphere through environment
   - _Emotional state_: Open with POV character's internal feeling
   - _Continuity bridge_: Directly follow from previous scene's closing
   - _Contrast_: Deliberately oppose previous scene's mood for impact
2. Establish POV, location, and time within first 3 sentences
3. Set the emotional tone immediately

### Step 4: Write the Scene Body
1. **Environmental Immersion**: Weave location details into action (don't infodump). Use all senses — sight, sound, smell, temperature, texture
2. **Character Action/Reaction**: Show characters doing things that reveal their state. Action → Reaction → New Action (scene-level stimulus-response)
3. **Internal Monologue** (POV character only): Thoughts, feelings, observations. Must match the character's voice guide. Show the gap between what they think and what they say/do
4. **Dialogue Beats**: Write functional dialogue (what needs to be communicated) with annotations for `dialogue-crafter` to refine voice:
   ```
   [DIALOGUE_REFINE: Heroine_A, emotional_state: vulnerable, subtext: "please don't leave"]
   "You don't have to stay. I'll be fine on my own."
   ```
5. **Pacing Within Scene**: Vary sentence length for rhythm. Short sentences for tension/action. Longer sentences for reflection/atmosphere
6. **Sensory Anchoring**: Every ~300 words, re-ground the reader in physical reality (a sound, a visual detail, a physical sensation)

### Step 5: Write the Scene Closing
1. Deliver the scene's emotional landing:
   - **Cliffhanger**: Tension unresolved, pulls reader forward
   - **Emotional resonance**: A moment of reflection/feeling that lets the scene settle
   - **Reveal**: New information that changes everything
   - **Transition**: Smooth bridge to what comes next
2. The closing line should be memorable — it's what the reader carries into the next scene
3. Verify the scene delta has been achieved: something IS different now

### Step 6: Self-Review
1. **Spec compliance**: Does the scene achieve its objective?
2. **Word count**: Within target range? (±20% tolerance)
3. **POV consistency**: No head-hopping (sudden switch to another character's internal thoughts)
4. **Voice consistency**: Does the POV character's narration match their voice guide?
5. **World accuracy**: Do environmental details match the world bible?
6. **Emotional target**: Did the writing achieve the target emotional effect?
7. **Show vs. Tell**: Are emotions and character traits shown through action/sensory detail rather than stated?

### Step 7: Save Manuscript
1. Write scene manuscript to `manuscripts/scenes/{scene_id}.md`
2. Write continuity notes for the next scene
3. Flag sections for `dialogue-crafter` refinement
4. Return complete output package

## Validation Rules

1. **Scene Delta**: At least one story element must change during the scene. No "nothing happens" scenes
2. **POV Integrity**: No unintentional head-hopping. The reader only has access to the POV character's thoughts and perceptions
3. **Word Count**: Final word count within ±20% of target. Over/under requires justification
4. **Opening Hook**: First paragraph must establish POV, location, and tone. No "floating" openings where reader doesn't know where/who they are
5. **Sensory Anchoring**: At least one sensory detail (non-visual) per ~300 words. Sound, smell, touch, temperature
6. **World Consistency**: All described locations, objects, and facts must match bible entries. No invented world details without bible update
7. **Emotional Target Hit**: Scene must plausibly evoke the target emotion. A scene targeting "devastation (intensity 8)" that reads as mildly sad is a failure
8. **Character Knowledge**: POV character cannot know, reference, or think about information they haven't learned. Their internal monologue is bound by their knowledge state
9. **Dialogue-to-Prose Ratio**: Must match `scene_type`. Dialogue-heavy scenes: >50% dialogue. Introspection scenes: <20% dialogue
10. **Closing Impact**: Final paragraph/sentence must have narrative weight. No "and then they went to sleep" endings unless thematically purposeful
