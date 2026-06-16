---
name: bible-manager
description: Maintain the Project Bible — the single source of truth for all world settings, character profiles, timeline events, route structures, mystery clues, and flag registries. Every other skill reads from and writes canonical data through this skill.
---

# bible-manager

## Purpose
Maintain the **Project Bible** as the single source of truth for all narrative elements. Every entity — locations, characters, timeline events, route definitions, mystery clues, flag specifications — is created, read, updated, and queried through this skill. No other skill may bypass the bible to create or modify canonical data.

## Trigger
- Any skill needs to read canonical project data
- Any skill needs to write/update canonical project data
- User says: "update the bible", "register this in the bible", "what does the bible say about X", "query the bible", "cross-reference X and Y"
- `bible-validator` requests a full bible dump for consistency checking

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `entity_type` | enum | yes | One of: `world`, `character`, `timeline_event`, `route`, `scene_spec`, `mystery_clue`, `flag`, `emotion_beat`, `theme`, `relationship` |
| `operation` | enum | yes | One of: `create`, `read`, `update`, `delete`, `query`, `list`, `crossref` |
| `entity_id` | string | conditional | Required for `read`, `update`, `delete`; optional for `query` |
| `entity_data` | object | conditional | Required for `create`, `update`; must conform to entity schema |
| `query_filter` | object | conditional | Filter criteria for `query` and `list` operations |
| `include_related` | boolean | no | If true, return related entities via cross-reference resolution (default: false) |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `status` | enum | `success`, `conflict`, `error` |
| `entity` | object | The canonical entity record (for read/query operations) |
| `entities` | array | List of entity records (for list/query operations) |
| `cross_refs` | array | Resolved cross-references to related entities |
| `conflicts` | array | List of conflicts detected during write (duplicate names, contradictory facts, orphaned refs) |
| `warnings` | array | Non-blocking issues (stale references, soft inconsistencies) |

## Workflow

### Step 1: Receive and Validate Request
1. Parse `entity_type`, `operation`, and accompanying data
2. Validate that `entity_id` is provided for `read`/`update`/`delete`
3. Validate that `entity_data` conforms to the entity type's JSON Schema
4. Return error immediately if validation fails

### Step 2: Execute Operation

**For `create`:**
1. Generate a unique `entity_id` (format: `{entity_type}-{uuid_short}`)
2. Check for name collisions within the same entity type
3. Check for factual contradictions with existing bible entries
4. If conflict found, return `status: conflict` with conflict details — do NOT write
5. If no conflict, stamp entity with `created_at`, `updated_at`, `version: 1`
6. Write entity file to `bible/{entity_type}s/{entity_id}.json`
7. Update cross-reference index
8. Return created entity

**For `read`:**
1. Locate entity file at `bible/{entity_type}s/{entity_id}.json`
2. If `include_related: true`, resolve all cross-references from indices
3. Return entity with metadata

**For `update`:**
1. Read existing entity
2. Increment `version`
3. Update `updated_at` timestamp
4. Validate that updated data doesn't introduce contradictions
5. Write updated entity file
6. Update cross-reference indices
7. Return updated entity with diff against previous version

**For `delete`:**
1. Check cross-reference index for inbound references to this entity
2. If referenced, return `status: conflict` listing all dependents
3. If no references, move entity to archive (soft delete) with `deleted_at` stamp
4. Remove from cross-reference indices

**For `query`:**
1. Load all entities of `entity_type`
2. Apply `query_filter` as predicate
3. Return matching entities sorted by `updated_at` descending

**For `list`:**
1. Return all entity IDs + names + short descriptions of `entity_type`
2. Optionally filtered by `query_filter`

**For `crossref`:**
1. Given an `entity_id`, find all entities that reference it
2. Given two `entity_id`s, find all connection paths between them
3. Return cross-reference map

### Step 3: Index Maintenance
After every mutation, update the global cross-reference index at `bible/_index.json`:
- Entity → entities it references
- Entity → entities that reference it
- Tag/keyword → entities with that tag

## Validation Rules

1. **Unique ID**: Every entity must have a unique `entity_id` within its type
2. **Unique Names**: Character names, location names, and route names must be unique within their type
3. **Required Fields**: Each entity type has a JSON Schema; all required fields must be present
4. **Reference Integrity**: Any field typed as `$ref` must resolve to an existing entity
5. **No Circular Dependencies**: Reference chains must not form cycles (A→B→A)
6. **Version Monotonicity**: Version numbers must only increase
7. **Timestamp Consistency**: `updated_at` >= `created_at`; timestamps in ISO 8601
8. **No Orphan Routes**: Route entities must reference at least one existing scene
9. **Timeline Ordering**: If entity has `timestamp` field, it must be valid ISO 8601
10. **Relationship Bidirectionality**: If Character A has relationship R to Character B, Character B must have a corresponding inverse relationship entry

## Entity Schemas (Abbreviated)

### World Entity
```json
{
  "entity_id": "string",
  "type": "location|faction|system|historical_event|rule",
  "name": "string (unique)",
  "description": "string",
  "parent_world_entity": "$ref|null",
  "properties": "object (type-specific)",
  "tags": ["string"],
  "created_at": "ISO8601",
  "updated_at": "ISO8601",
  "version": "integer"
}
```

### Character Entity
```json
{
  "entity_id": "string",
  "name": "string (unique)",
  "role": "protagonist|heroine|rival|mentor|antagonist|supporting",
  "surface_traits": { "age": "int", "appearance": "string", "mannerisms": ["string"] },
  "deep_structure": {
    "wound": "string (past trauma)",
    "lie": "string (false belief about self/world)",
    "need": "string (what they actually need)",
    "desire": "string (what they think they want)",
    "ghost": "string (past event that haunts them)"
  },
  "voice_guide": {
    "speech_patterns": ["string"],
    "vocabulary_level": "simple|moderate|sophisticated",
    "catchphrases": ["string"],
    "honorific_default": "string",
    "emotional_expressiveness": "reserved|moderate|expressive",
    "sentence_length_tendency": "short|medium|long",
    "forbidden_words": ["string"]
  },
  "arc_template": { "starting_state": "string", "midpoint_shift": "string", "ending_state": "string" },
  "relationships": [{ "target_character": "$ref", "type": "string", "dynamic": "string" }],
  "tags": ["string"],
  "created_at": "ISO8601",
  "updated_at": "ISO8601",
  "version": "integer"
}
```

### Timeline Event Entity
```json
{
  "entity_id": "string",
  "timestamp": "ISO8601",
  "description": "string",
  "causes": ["$ref (preceding events)"],
  "effects": ["$ref (subsequent events)"],
  "participants": ["$ref (characters)"],
  "location": "$ref (world entity)",
  "route_scope": "common|route_specific",
  "route_id": "$ref|null",
  "is_reveal_point": "boolean",
  "tags": ["string"]
}
```

### Route Entity
```json
{
  "entity_id": "string",
  "name": "string (unique)",
  "type": "common|heroine|true|bad|side",
  "heroine_id": "$ref|null",
  "dramatic_question": "string",
  "entry_conditions": { "flag_formula": "string", "choice_sequence": ["$ref"] },
  "scene_sequence": ["$ref"],
  "ending_type": "good|true|normal|bad|tragic",
  "ending_description": "string",
  "requires_routes_completed": ["$ref"],
  "estimated_word_count": "integer",
  "tags": ["string"]
}
```

### Mystery Clue Entity
```json
{
  "entity_id": "string",
  "mystery_id": "string",
  "clue_type": "direct|foreshadowing|red_herring|reveal",
  "content": "string",
  "placement_scene": "$ref",
  "discovery_character": "$ref",
  "points_to_truth": "boolean",
  "alternative_explanation": "string (for red herrings)",
  "reveal_target_scene": "$ref|null (when clue pays off)",
  "difficulty": "obvious|noticeable|subtle|hidden",
  "tags": ["string"]
}
```

## Bible Directory Structure
```
bible/
├── _index.json              # Global cross-reference index
├── _schema/                  # JSON Schema definitions per entity type
│   ├── world.schema.json
│   ├── character.schema.json
│   ├── timeline_event.schema.json
│   ├── route.schema.json
│   ├── scene_spec.schema.json
│   ├── mystery_clue.schema.json
│   ├── flag.schema.json
│   ├── emotion_beat.schema.json
│   └── theme.schema.json
├── worlds/                   # World entities (locations, factions, systems, etc.)
├── characters/               # Character entities
├── timeline_events/          # Timeline event entities
├── routes/                   # Route entities
├── scene_specs/              # Scene specification entities
├── mystery_clues/            # Mystery clue entities
├── flags/                    # Flag entities
├── emotion_beats/            # Emotion beat entities
└── themes/                   # Theme/motif entities
```
