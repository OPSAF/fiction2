---
name: narrative-doctor
description: Diagnose and fix narrative problems — plot holes, continuity errors, character knowledge violations, logical contradictions, and flag state inconsistencies. The quality gate before any manuscript is considered complete.
---

# narrative-doctor

## Purpose
Diagnose narrative illnesses: plot holes, continuity breaks, character knowledge violations, logical contradictions, timeline paradoxes, flag state errors, and causal chain gaps. This is the primary quality assurance skill — it finds the problems that break reader immersion and provides actionable fix recommendations. Every manuscript section should pass through narrative-doctor before being considered complete.

## Trigger
- "Check for plot holes"
- "Review narrative consistency"
- "Does this make logical sense"
- "Find contradictions in the manuscript"
- "Check continuity between scenes"
- "Audit character knowledge states"
- "Verify the cause-and-effect chain"
- "Does this scene contradict anything"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `manuscript_sections` | array | yes | Scene manuscripts to audit |
| `bible_context` | object | yes | All relevant bible entries (timeline, characters, world, flags, mystery clues) |
| `audit_scope` | enum | yes | `single_scene`, `route`, `cross_route`, `full_work` |
| `severity_threshold` | enum | no | Minimum severity to report: `critical`, `major`, `minor`, `cosmetic` (default: `minor`) |
| `previous_diagnosis` | object | no | Results from prior narrative-doctor run (for verifying fixes) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `diagnosis_report` | object | Complete findings: issues, severity, location, evidence, suggested fixes |
| `issues` | array | Individual issue records |
| `severity_summary` | object | Count of issues by severity level |
| `clean_bill_of_health` | boolean | True if zero issues found above severity threshold |
| `fix_recommendations` | array | Actionable suggestions for each issue, ordered by priority |
| `dependency_impact` | object | Which other scenes/skills are affected by each issue |

## Workflow

### Step 1: Load Audit Context
1. Query `bible-manager` for all relevant data:
   - Timeline events and their causal links (from `timeline-architect`)
   - Character profiles with knowledge state tracking (from `character-designer`)
   - World rules and constraints (from `world-designer`)
   - Flag definitions and state machine (from `flag-engineer`)
   - Mystery clue placement and knowledge asymmetry matrix (from `mystery-designer`)
2. Load target manuscript sections

### Step 2: Run Diagnostic Checks

**Check 1: Timeline Continuity**
- Are events referenced in the correct temporal order?
- Does any scene reference a future event as if it already happened?
- Are time gaps accounted for? (e.g., "three days later" — what happened?)
- Do character ages align with timeline dates?
- Are seasonal/school-calendar references correct for the stated date?

**Check 2: Character Knowledge Integrity**
- Does any character know, reference, or act on information they haven't learned?
- Trace every piece of knowledge a character demonstrates back to a learning event
- Flag any "telepathic knowledge" (character knows something only the reader knows)
- Check information asymmetry matrix from mystery-designer against character dialogue/thoughts

**Check 3: Physical/World Continuity**
- Object permanence: Does an object exist in a scene when it was left elsewhere?
- Injury continuity: Was a character injured in scene N but fine in scene N+1 without healing time?
- Location consistency: Are characters where they should be?
- Weather/time-of-day consistency across concurrent scenes

**Check 4: Causal Chain Integrity**
- Does every significant event have a cause?
- Are there any "because the plot requires it" events with no in-world justification?
- Do any cause→effect chains have missing links?
- Are there coincidences that strain credulity? (One coincidence = plot device; two = lazy writing)

**Check 5: Logical Consistency**
- Do character actions make sense given their established personality and knowledge?
- Do any decisions require "idiot plot" logic (characters being stupid for plot convenience)?
- Are there contradictions in how the world's rules are applied?
- Does the mystery's surface narrative hold up to the information the reader has?

**Check 6: Flag State Consistency**
- Do the flag states implied by the narrative match what the flag system says they should be?
- If a choice was made that sets flag X=true, does the narrative reflect that?
- Are there scenes where flag-dependent content contradicts the current flag state?

**Check 7: Dialogue-Context Alignment**
- Does dialogue reference events in correct order?
- Do characters react to things that were just said (conversation flows naturally)?
- Are there "non-sequitur" responses that suggest the writer forgot what was just said?

### Step 3: Classify Issues by Severity

| Severity | Definition | Example |
|----------|-----------|---------|
| **Critical** | Story-breaking; reader cannot maintain suspension of disbelief | Protagonist knows the killer's identity before any reveal; timeline paradox renders plot impossible |
| **Major** | Significantly damages immersion or logic | Character references event from future; injury disappears between scenes; flag state contradicts route |
| **Minor** | Noticeable but doesn't break the story | Weather inconsistent between consecutive scenes; minor character age doesn't match timeline |
| **Cosmetic** | Only detectable by extremely attentive readers/re-readers | Background detail inconsistent; minor honorific slip |

### Step 4: Generate Fix Recommendations
For each issue:
1. **Describe the problem**: What's wrong, where, with evidence
2. **Explain the impact**: Why it matters to the reader experience
3. **Propose fixes**: At least 2 alternative fixes with trade-offs:
   - **Fix A (Minimal change)**: Smallest edit to resolve the issue
   - **Fix B (Best fix)**: The ideal narrative solution, even if it requires more changes
4. **Identify affected dependencies**: Other scenes, bible entries, or skill outputs that need updating

### Step 5: Produce Diagnosis Report
1. Sort issues by severity (critical first) then by narrative position
2. Generate severity summary
3. Provide clean bill of health assessment
4. Include dependency impact map for coordinated fixes

## Validation Rules

1. **No False Positives**: An issue must be verifiable with specific evidence (quote the line, cite the bible entry). "This feels wrong" is not a valid issue
2. **Knowledge Traceability**: Every character knowledge claim must be traceable to a specific learning event in the timeline
3. **Causal Completeness**: Every major plot event (turning point level) must have at least one documented cause
4. **Coincidence Budget**: Maximum 1 meaningful coincidence per route. "They happened to be at the same place at the same time" counts as 1
5. **Injury Realism**: Physical injuries must have realistic recovery timelines or magical healing must be established
6. **Fix Actionability**: Every issue must have at least one concrete, implementable fix suggestion. "Rewrite this scene" without specifics is insufficient
7. **Cross-Route Consistency**: Events that occur in the common route or across multiple routes must be consistent. Route-specific events must not contradict common route facts
8. **No Regression**: If checking against a previous diagnosis, previously fixed issues must not have regressed
9. **Severity Calibration**: An issue that a typical reader would notice on first read cannot be classified below "minor"
10. **Evidence Requirement**: Every flagged issue must cite the specific line(s) and the specific bible entry/rule being violated
