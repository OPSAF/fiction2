---
name: bible-validator
description: Cross-validate the entire Project Bible — detect contradictions across all bible sections, find orphaned references, identify stale entities, verify cross-reference integrity, and ensure the single source of truth is actually trustworthy.
---

# bible-validator

## Purpose
Perform comprehensive cross-validation of the entire Project Bible. As the bible grows through contributions from multiple skills (world-designer, character-designer, timeline-architect, etc.), inconsistencies inevitably creep in. This skill is the final quality gate for the bible itself — it detects contradictions between bible sections, orphaned references, stale or unused entities, schema violations, and version inconsistencies. A bible with contradictions poisons every skill that reads from it.

## Trigger
- "Validate the bible"
- "Check for contradictions in the bible"
- "Is the bible consistent"
- "Full bible consistency check"
- "Find orphaned references"
- "Check cross-reference integrity"
- "Audit the bible"
- "Pre-release bible validation"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `bible_sections` | array | yes | Which bible sections to validate: `all` or specific types |
| `validation_depth` | enum | yes | `quick` (schema only), `standard` (schema + cross-refs), `deep` (schema + cross-refs + semantic contradiction detection) |
| `focus_areas` | array | no | Specific concerns: `contradictions`, `orphans`, `staleness`, `schema_compliance`, `version_consistency`, `reference_integrity` |
| `previous_validation` | object | no | Prior validation report for regression checking |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `validation_report` | object | Complete validation results |
| `contradictions` | array | Factual contradictions between bible entries (e.g., character's backstory contradicts timeline) |
| `orphaned_references` | array | References to entities that don't exist |
| `stale_entities` | array | Entities defined but never referenced by anything |
| `schema_violations` | array | Entities that don't conform to their JSON schema |
| `version_inconsistencies` | array | Related entities with incompatible version stamps |
| `cross_reference_integrity` | object | Complete reference graph integrity report |
| `bible_health_score` | number | Overall bible quality score (0-100) |
| `fix_priority_queue` | array | Issues ordered by impact × ease of fix |

## Workflow

### Step 1: Load Bible
1. Query `bible-manager` for all entities across all sections (full bible dump)
2. Load all JSON schemas from `bible/_schema/`
3. Load the cross-reference index from `bible/_index.json`

### Step 2: Schema Compliance Check
For every entity in the bible:
1. Validate against its type's JSON Schema
2. Check: required fields present, field types correct, enum values valid, format constraints met (ISO 8601 dates, etc.)
3. Flag any schema violation with entity ID and specific field

### Step 3: Cross-Reference Integrity Check
1. For every `$ref` field in every entity, verify the referenced entity exists
2. Check reference bidirectionality where applicable:
   - Character A's relationship lists Character B → Character B's relationship should list Character A
   - Scene references a location → Location's "appears_in" should reference the scene
   - Timeline event lists participants → Each participant's timeline should include the event
3. Detect dangling references: A references B, but B has been deleted
4. Detect missing back-references: A references B, but B doesn't reference A (when bidirectionality is expected)

### Step 4: Contradiction Detection (Deep Mode)

**Cross-Section Contradictions:**

1. **Character vs. Timeline**:
   - Character's age at event X ≠ (event_date - birth_date)
   - Character's backstory event placed differently in timeline
   - Character described as being at location A during event that happens at location B

2. **Character vs. Character**:
   - Two characters claim the same unique achievement
   - Relationship descriptions are asymmetric (A thinks B is "best friend"; B thinks A is "acquaintance" — possible but must be intentional)
   - Contradictory backstory details (two characters can't both be "the one who introduced X to Y")

3. **World vs. Plot**:
   - Plot event violates established world rules
   - Magic/system used in a way that violates its defined limitations
   - Technology level inconsistency (smartphones in a 1995 setting)

4. **Route vs. Flag**:
   - Route entry formula references a flag that doesn't exist
   - Flag threshold for route entry exceeds maximum possible flag value
   - Two routes claimed as exclusive but their entry formulas can both be true simultaneously

5. **Mystery vs. Timeline**:
   - Clue placed at a scene that occurs after the reveal it's supposed to support
   - Character knows a clue before the scene where they discover it
   - Red herring's alternative explanation contradicts established facts

### Step 5: Staleness and Orphan Detection
1. **Orphaned references**: Entity A references Entity B, but Entity B doesn't exist
2. **Stale entities**: Entity exists in bible but is never referenced by any other entity
   - Some staleness is expected (world-building details, minor locations)
   - But major characters, key locations, and plot-critical items should be well-referenced
3. **Unused flag definitions**: Flag defined in registry but never checked by any condition
4. **Unreferenced scenes**: Scene spec exists but not in any route's scene sequence

### Step 6: Version Consistency Check
1. Check that related entities have compatible version timestamps
2. If Entity A (v3) references Entity B (v1), verify the reference was valid at the time of Entity A's last update
3. Flag entities that haven't been updated despite their dependencies changing

### Step 7: Calculate Bible Health Score
```
Health Score = 100
  - (critical_contradictions × 20)
  - (major_contradictions × 10)
  - (minor_contradictions × 3)
  - (orphaned_references × 5)
  - (schema_violations × 8)
  - (stale_major_entities × 2)
```
Minimum score: 0. Target: ≥80 for production readiness.

### Step 8: Generate Fix Priority Queue
Prioritize fixes by: Impact (how many skills/entities affected) × Inverse of Ease (how hard to fix)

## Validation Rules

1. **Zero Critical Contradictions**: A production-ready bible must have zero critical contradictions
2. **Schema Compliance**: 100% of entities must pass schema validation. No exceptions
3. **Reference Resolution**: 100% of cross-references must resolve. Zero dangling references allowed
4. **Bidirectional Relationships**: All relationship-type references must be bidirectional (or have documented reason for asymmetry)
5. **Character-Timeline Alignment**: All character age references must be consistent with timeline dates
6. **World-Plot Consistency**: No plot event may violate established world rules without the world rules being updated
7. **Flag Completeness**: Every flag must be both written (set by at least one choice) and read (checked by at least one condition)
8. **Route Reachability**: Every route must be reachable from initial state (validated through flag formulas)
9. **Mystery Clue Ordering**: All clues must be placed before their corresponding reveals in timeline order
10. **Health Threshold**: Bible health score must be ≥80 before any manuscript that depends on the bible can be considered final
