---
name: theme-weaver
description: Ensure thematic coherence — track theme expression across all scenes, motif recurrence with escalating significance, symbolism consistency, and verify that the ending resolves (or intentionally subverts) the work's primary themes.
---

# theme-weaver

## Purpose
Ensure that the work's themes are not merely stated but woven into the fabric of every scene. Themes should be expressed through character decisions, situational irony, symbolic imagery, and structural echoes — not through characters lecturing about "what the story is about." This skill tracks theme expression density, motif recurrence patterns, symbolism consistency, and verifies thematic resolution in endings.

## Trigger
- "Check the themes"
- "Is the theme coming through clearly"
- "Track the motifs"
- "Analyze the symbolism"
- "Are the themes consistent"
- "Does the ending resolve the themes"
- "Find thematic contradictions"
- "Map theme expression across the story"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `defined_themes` | array | yes | Primary and secondary themes with definitions (from project concept) |
| `defined_motifs` | array | yes | Recurring motifs/symbols and their intended meanings |
| `manuscript_sections` | array | yes | All scene manuscripts to analyze |
| `plot_blueprint` | object | yes | Plot structure for structural theme analysis |
| `character_arcs` | array | yes | Character arcs (themes are expressed through character change) |
| `endings` | array | yes | All route endings for thematic resolution verification |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `theme_report` | object | Complete thematic analysis |
| `theme_expression_map` | object | Scene-by-scene theme expression tracking |
| `motif_tracker` | object | Every occurrence of each motif with escalating significance analysis |
| `symbolism_audit` | object | Symbol consistency check (same symbol = same meaning) |
| `theme_gap_analysis` | object | Acts or routes where themes are under-expressed |
| `thematic_contradictions` | array | Events that undermine stated themes without narrative comment |
| `ending_thematic_resolution` | object | How each ending resolves or subverts each theme |

## Workflow

### Step 1: Load Thematic Framework
1. Absorb all defined themes and their descriptions
2. Absorb all defined motifs/symbols and their intended meanings
3. Query `bible-manager` for theme entities if previously registered
4. Understand the thematic hierarchy: primary themes (the work is "about" this) vs. secondary themes (supporting/sub-themes)

### Step 2: Scan for Theme Expression
For each scene, identify theme expression through:

**Direct Expression:**
- Characters articulating thematic ideas (use sparingly — too much is preachy)
- Internal monologue grappling with thematic questions

**Dramatic Expression (preferred):**
- Character decisions that embody a thematic value
- Situations that force thematic dilemmas
- Consequences that demonstrate thematic truths

**Symbolic Expression:**
- Imagery and objects carrying thematic weight
- Environmental details reflecting theme
- Structural parallels (scene A echoes scene B thematically)

**Ironic Expression:**
- Events that superficially support one theme while actually demonstrating its opposite
- Characters who claim to believe X while their actions prove Y

### Step 3: Map Theme Density
1. For each theme, count expressions per act/route
2. Identify theme deserts: sections where a major theme is absent for too long
3. Identify theme overload: sections where themes are too explicit/heavy-handed
4. The goal is **distribution with escalation**: each theme appears in every act, but the depth/sophistication of expression increases

### Step 4: Track Motif Recurrence
For each defined motif:
1. Log every occurrence with: scene location, context, significance level (1-5)
2. Verify the **escalation rule**: each recurrence should carry more significance than the last
   - First occurrence: Introduction (reader registers the motif)
   - Second occurrence: Reinforcement (reader recognizes pattern)
   - Third occurrence: Transformation (motif gains new meaning)
   - Final occurrence: Culmination (motif pays off thematically)
3. Flag motifs that appear only once (failed motif) or appear but never escalate (static motif)

### Step 5: Audit Symbolism Consistency
1. Every symbol must have a stable meaning:
   - "Rain" can't mean "sadness" in scene 5 and "renewal" in scene 20 without narrative justification
   - If a symbol's meaning evolves, the evolution must be traceable and intentional
2. Flag symbolic contradictions: same symbol used with incompatible meanings
3. Flag accidental symbolism: imagery that reads as symbolic but wasn't intended (can confuse attentive readers)

### Step 6: Detect Thematic Contradictions
1. Identify narrative events that undermine stated themes:
   - Theme: "Love conquers all" but the story rewards characters who abandon love for ambition
   - Theme: "Truth matters" but the happy ending depends on a lie never being exposed
2. Contradictions are not automatically wrong — they may be intentional subversion
3. For each contradiction, determine:
   - **Intentional subversion**: The story is critiquing the theme (valid, but must be clear)
   - **Accidental contradiction**: The writer didn't notice (must be fixed)
   - **Character-specific**: This character believes X but the story shows X is wrong (valid character arc)

### Step 7: Verify Ending Resolution
For each ending:
1. What happens to each major theme?
   - **Resolved**: Theme reaches its natural conclusion
   - **Subverted**: Theme is deliberately overturned (with narrative purpose)
   - **Abandoned**: Theme is dropped without resolution (FAILURE)
   - **Contradicted**: Ending implies opposite of theme without acknowledgment (FAILURE)
2. The primary theme MUST be resolved or intentionally subverted. It cannot be ignored
3. True route ending must address ALL primary themes

### Step 8: Produce Theme Report
1. Theme-by-theme analysis with evidence from text
2. Motif tracking with escalation verification
3. Symbolism consistency audit
4. Gap analysis (where themes need more expression)
5. Contradiction report with intentionality assessment
6. Ending resolution verification

## Validation Rules

1. **Primary Theme Presence**: Each primary theme must appear in every act (Ki, Shō, Ten, Ketsu). Absence from an entire act is a failure
2. **Motif Escalation**: Each motif must appear at minimum 3 times with escalating significance. Single-appearance motifs should be either developed or cut
3. **Symbol Stability**: Each symbol must maintain consistent meaning throughout. Meaning evolution requires explicit narrative justification
4. **Show vs. Tell Balance**: No more than 20% of theme expressions may be "direct" (characters stating themes). At least 80% must be dramatic or symbolic
5. **Ending Resolution**: The primary theme must be resolved or intentionally subverted in every ending. No abandoned primary themes
6. **No Accidental Contradictions**: Any event contradicting a stated theme must be identifiable as intentional subversion. Unintentional contradictions must be fixed
7. **Theme Distribution**: Theme expression density should increase across acts (more sophisticated/deep engagement as story progresses, not just more frequent)
8. **Character-Theme Alignment**: Each major character should embody or challenge at least one theme. Characters without thematic function are decoration
9. **No Theme Monopoly**: No single character should be the sole vehicle for a major theme. Themes must be expressed through multiple characters and events
10. **Reread Value**: Thematic elements (symbols, motifs, dramatic echoes) must be detectable on first read but gain deeper meaning on reread
