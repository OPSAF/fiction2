---
name: emotion-designer
description: Design the emotional architecture — beat-by-beat emotional targets, tension curves, catharsis scheduling, emotional contrast design, and per-route emotional signatures. Ensures the reader feels the right thing at the right time.
---

# emotion-designer

## Purpose
Design the complete emotional journey of the reader. Maps every story beat to a target emotional response, constructs the tension/relief rhythm, places catharsis points at structurally optimal positions, and ensures emotional variety across the narrative. For multi-route works, designs distinct emotional signatures so each route delivers a unique feeling-experience. Inspired by White Album 2's devastating emotional architecture.

## Trigger
- "Design the emotional arc"
- "Where should the reader cry"
- "Map the tension curve"
- "Design the catharsis points"
- "What should the reader feel at this scene"
- "Is the emotional pacing right"
- "Design the emotional contrast"
- "Create the emotional beat map"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `plot_blueprint` | object | yes | Complete plot structure with all beats from plot-architect |
| `scene_list` | array | yes | All planned scenes with their dramatic functions |
| `character_arcs` | array | yes | Character arc templates from character-designer |
| `route_designs` | array | yes | Route structures from route-designer |
| `genre_emotion_profile` | object | yes | Genre-expected emotional palette (nakige expects tears, thriller expects tension, etc.) |
| `reference_emotional_targets` | array | no | Specific emotional moments to evoke (e.g., "reader should cry at scene 47", "reader should feel triumphant at climax") |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `emotion_map` | array | Beat-by-beat emotional targets (scene → primary emotion → intensity) |
| `tension_curve` | object | Overall tension graph with peaks, valleys, and relief points |
| `catharsis_schedule` | array | Catharsis points with their setup requirements and expected payoff |
| `emotional_contrast_design` | object | How adjacent scenes contrast emotionally |
| `per_route_emotional_signature` | object | Each route's unique emotional profile |
| `emotional_variety_report` | object | Verification that the emotional palette is sufficiently varied |
| `devastation_index` | number | Overall emotional impact score (0-100) |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for plot blueprint, scene list, character arcs, and route designs
2. Absorb genre emotion profile and specific emotional targets

### Step 2: Define Emotional Palette
1. Map the **primary emotions** the work will evoke:
   - Joy, sadness, anger, fear, surprise, disgust, anticipation, trust (Plutchik's wheel)
   - Genre-specific: nostalgia, longing (mono no aware), catharsis, dread, hope, despair
2. Define the **emotional range**: how wide is the palette?
   - Wide palette: comedy + tragedy + romance + thriller (Fate/Stay Night)
   - Narrow palette: focused on longing + sadness + bittersweet (White Album 2)
   - The palette choice is a creative decision, not a quality metric

### Step 3: Assign Emotional Targets Per Scene
For each scene in the beat sheet:
1. **Primary emotion**: What should the reader predominantly feel?
2. **Intensity**: 1-10 scale
3. **Secondary emotion**: What else is present (emotional complexity)?
4. **Transition from previous scene**: How does the emotional state change?
5. **Character POV emotion**: What is the POV character feeling (may differ from reader emotion — dramatic irony)

### Step 4: Design the Tension Curve
1. Plot the overall tension/intensity curve across the narrative
2. The curve must NOT be monotonic:
   - **Peaks** (intensity 8-10): Climaxes, major reveals, confrontations, devastating moments
   - **Valleys** (intensity 2-4): Slice-of-life, recovery, bonding, comic relief
   - **Rising action** (intensity trending up): Building stakes, converging plotlines
   - **Falling action** (intensity trending down): Aftermath, reflection, emotional processing
3. Apply the **breather rule**: after every peak (intensity ≥ 8), there must be a valley (intensity ≤ 4) within the next 2-3 scenes
4. Apply the **buildup rule**: a peak must be preceded by at least 2 scenes of rising intensity
5. Identify the **absolute peak** (highest intensity in the entire work, typically the true route climax)

### Step 5: Place Catharsis Points
Catharsis = the release of built-up emotional tension. It's the payoff.

1. **Major catharsis points** (3-5 per route):
   - Confession scenes (romance)
   - Truth reveals (mystery)
   - Reconciliation moments (drama)
   - Victory/defeat moments (conflict)
   - Sacrifice moments (tragedy)

2. Each catharsis point requires:
   - **Setup investment**: At least 3 scenes building the emotional stakes
   - **Trigger event**: The specific thing that releases the tension
   - **Release**: The emotional outpouring (tears, joy, relief, devastation)
   - **Aftermath**: The new emotional equilibrium (changed relationship, new understanding, grief)

3. Catharsis points must be **spaced apart**: at least 3-4 scenes between major catharsis moments

### Step 6: Design Emotional Contrast
1. Map adjacent scene emotions to ensure contrast:
   - Tension → Relief → Tension (not Tension → More Tension → Even More Tension)
   - Joy → Sorrow (emotional whiplash for impact)
   - Calm → Sudden Shock (horror/thriller beats)
2. **Comic relief rule**: After particularly intense/dark scenes (intensity ≥ 7), lighter scenes help the reader process
3. **Escalation rule**: When building to a major catharsis, the intensity of the same emotion should escalate with each successive scene

### Step 7: Design Per-Route Emotional Signatures
Each route should have a distinct emotional fingerprint:

| Route Type | Emotional Signature |
|-----------|-------------------|
| Heroine A (childhood friend) | Nostalgia → Warmth → Conflict → Reconciliation → Bittersweet joy |
| Heroine B (tsundere) | Frustration → Amusement → Vulnerability → Passion → Triumphant love |
| Heroine C (tragic heroine) | Mystery → Unease → Sympathy → Desperation → Devastation → Hope |
| True Route | Accumulation → Revelation → Determination → Confrontation → Catharsis → Peace |
| Bad End | Security → Small mistake → Snowballing consequences → Desperation → Despair |

### Step 8: Verify Emotional Design
1. **Variety check**: Is the emotional palette sufficiently varied? (No 10 consecutive scenes of the same emotion)
2. **Intensity check**: Are peaks and valleys properly distributed?
3. **Catharsis check**: Does each major setup pay off?
4. **Fatigue check**: Will the reader be emotionally exhausted at the wrong points?
5. **Nakige check** (if applicable): Does the work make the reader cry, then give them hope?

### Step 9: Write to Bible
1. Write emotion beat entities to `bible-manager`
2. Return complete output package

## Validation Rules

1. **Non-Monotonic Curve**: The tension curve must not be flat or monotonically increasing. Minimum 3 distinct peaks and 3 distinct valleys
2. **Breather Rule**: After any scene with intensity ≥ 8, there must be a scene with intensity ≤ 4 within the next 3 scenes
3. **Peak Setup**: Any scene with intensity ≥ 8 must be preceded by at least 2 scenes of rising intensity
4. **Catharsis Spacing**: Major catharsis points must be separated by at least 3 scenes
5. **Emotional Variety**: No single emotion may dominate >40% of scenes in a route
6. **Devastation Requirement**: For nakige/drama works, at least one scene must target intensity 9+ for sadness/despair
7. **Hope Requirement**: For works that are not pure tragedies, the ending must trend toward hope or acceptance (intensity 3-5, emotion: peace/hope/contentment)
8. **Character Emotion Consistency**: The emotional targets must be achievable by the characters present. A stoic character shouldn't generate tearful scenes unless they break
9. **Route Emotional Distinctness**: Each route's emotional signature must differ from others by at least 40% on the emotion distribution
10. **Emotional Honesty**: Emotions must be earned through narrative setup. Unearned sentiment (forcing tears without buildup) is a violation
