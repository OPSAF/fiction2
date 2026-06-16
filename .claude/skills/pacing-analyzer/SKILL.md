---
name: pacing-analyzer
description: Analyze narrative pacing — scene density, tension rhythm, information flow rate, reader fatigue prediction, and the action/reflection balance. Ensures the story never drags, never rushes, and maintains optimum reader engagement.
---

# pacing-analyzer

## Purpose
Analyze the narrative's pacing: the rhythm of tension and relief, the distribution of scene intensities, the flow rate of new information, the balance between action/dialogue/reflection/exposition, and the reader's predicted energy/fatigue curve. Pacing problems are the #1 cause of reader dropout — this skill catches them before the reader does.

## Trigger
- "Analyze the pacing"
- "Is this section too slow"
- "Check the rhythm"
- "Where does it drag"
- "Is the climax rushed"
- "Check scene density"
- "Analyze information flow"
- "Is there too much exposition"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `manuscript_sections` | array | yes | Scene manuscripts to analyze (with word counts) |
| `emotion_map` | object | yes | Emotional targets per scene from emotion-designer |
| `scene_types` | array | yes | Type classification for each scene |
| `plot_blueprint` | object | yes | Plot structure with act boundaries from plot-architect |
| `analysis_scope` | enum | yes | `act`, `route`, `common_route`, `full_work` |
| `target_reader_profile` | enum | no | `casual` (reads 30min/day), `dedicated` (reads 1-2hr/day), `marathon` (reads until done) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `pacing_report` | object | Complete pacing analysis with all metrics and findings |
| `rhythm_graph` | object | Scene-by-scene intensity/engagement curve |
| `drag_points` | array | Scenes or sections where pacing slows excessively |
| `rush_points` | array | Scenes or sections where pacing is too fast |
| `density_heatmap` | object | Visualization of scene density (events per word count) |
| `information_flow_rate` | object | New information introduced per scene (tracking reader cognitive load) |
| `fatigue_prediction` | object | Where the reader is likely to feel tired or put down the work |
| `recommendations` | array | Specific pacing fixes with priority |

## Workflow

### Step 1: Load Analysis Data
1. Load manuscript sections with metadata (word count, scene type, position in narrative)
2. Load emotion map (intensity scores per scene)
3. Load plot blueprint (act boundaries, turning points, climax positions)

### Step 2: Calculate Pacing Metrics

**Metric 1: Scene Intensity Curve**
- Map intensity (1-10) across all scenes in order
- Calculate intensity delta (change from scene N to scene N+1)
- Identify the rhythm pattern

**Metric 2: Scene Density**
- Density = (number of significant events + new information points) / word count
- A 3000-word scene with 1 event = low density (potential drag)
- A 500-word scene with 5 events = high density (potential rush)

**Metric 3: Type Distribution**
- % action scenes, dialogue scenes, introspection scenes, exposition scenes, transition scenes
- Compare to genre-appropriate benchmarks

**Metric 4: Action/Reflection Ratio**
- Action = scenes that move plot forward (events, decisions, revelations)
- Reflection = scenes that process what happened (aftermath, character moments, bonding)
- Ideal ratio depends on genre; typically 60:40 to 70:30 action:reflection

**Metric 5: Information Flow Rate**
- New information units introduced per 1000 words
- Peak information load (maximum new info in any single scene)
- Information "digestion time" (scenes where reader can process what they learned)

**Metric 6: Reader Engagement Prediction**
- Model reader energy level based on scene intensity progression
- Predict "put-down points" (where reader is likely to stop reading)
- Predict "page-turner" zones (where reader can't stop)

### Step 3: Identify Pacing Problems

**Drag (Too Slow):**
- 3+ consecutive scenes with intensity ≤ 3
- Scenes where density < 0.5 events per 1000 words
- Excessive introspection/exposition without plot advancement
- "Treading water" scenes where nothing changes

**Rush (Too Fast):**
- Scenes with density > 3 events per 1000 words
- Major plot events without setup or aftermath
- Emotional beats without sufficient buildup
- Climax resolved in too few words

**Exhaustion (Too Intense):**
- 4+ consecutive scenes with intensity ≥ 7
- No relief/breather scenes after major emotional events
- Reader fatigue score exceeding threshold

**Info-Dump (Cognitive Overload):**
- Single scene with >5 new information units
- Exposition concentrated rather than distributed
- World-building without narrative context

### Step 4: Analyze by Act/Route Section
1. **Ki (Introduction)**: Should be moderate pace — hook the reader, establish the world, don't overwhelm
2. **Shō (Development)**: Can sustain longer, slower sections — reader is invested
3. **Ten (Twist)**: Should accelerate — rising tension, converging plotlines
4. **Ketsu (Resolution)**: Fastest pace at climax, then decelerate for denouement

### Step 5: Generate Recommendations
For each problem identified:
1. **Diagnosis**: What's wrong and why it affects reader experience
2. **Location**: Which scenes are affected
3. **Proposed Fix**:
   - Drag → Cut/condense scenes, add micro-event, split into smaller scenes with variety
   - Rush → Expand key moments, add reaction beats, split dense scenes
   - Exhaustion → Insert breather scene, lower intensity of one scene
   - Info-dump → Distribute information across more scenes, convert to dialogue/discovery
4. **Priority**: Which fixes have the most impact on reader experience

### Step 6: Produce Pacing Report
1. Generate rhythm visualization (text-based graph)
2. List all issues with severity and location
3. Provide prioritized fix recommendations
4. Include before/after rhythm projection for key fixes

## Validation Rules

1. **Drag Threshold**: No more than 2 consecutive scenes with intensity ≤ 3 (unless deliberate atmospheric building)
2. **Rush Threshold**: No single scene with density > 4 events per 1000 words
3. **Exhaustion Threshold**: No more than 3 consecutive scenes with intensity ≥ 7
4. **Breather Rule**: After any scene with intensity ≥ 8, a scene with intensity ≤ 4 must appear within 3 scenes
5. **Act Pacing Profile**: Each act must match its expected pacing profile. Ki should not be the fastest section; Ketsu climax should not be the slowest
6. **Info Distribution**: No single scene may introduce >5 discrete new information units
7. **Climax Proportion**: The climax scene(s) must be among the top 10% highest-intensity scenes. A climax that's lower intensity than earlier scenes is a structural failure
8. **Ending Deceleration**: Final 2-3 scenes must decrease in intensity (emotional landing, not abrupt stop)
9. **Word Count Efficiency**: Each scene must justify its word count. A 4000-word scene that accomplishes what a 1500-word scene could is a drag candidate
10. **Genre Benchmarking**: Pacing profile must be within acceptable range for the target genre. A thriller paced like a slice-of-life is a failure
