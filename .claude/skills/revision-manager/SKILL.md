---
name: revision-manager
description: Manage manuscript and bible revisions — create snapshots, compute diffs, track change history, analyze cross-skill impact of changes, support rollback, and coordinate multi-skill revision passes.
---

# revision-manager

## Purpose
Manage the complete revision lifecycle for both manuscripts and bible entries. In a multi-skill ecosystem where a change to character backstory can cascade into scene rewrites, dialogue changes, flag adjustments, and mystery clue repositioning, revision management is critical infrastructure. This skill provides versioning, diffing, impact analysis, and coordinated rollback across the entire project.

## Trigger
- "Create a revision snapshot"
- "What changed between version X and Y"
- "Track this revision"
- "Revert to the previous version"
- "Show revision history for scene X"
- "What's affected if I change Y"
- "Create a checkpoint before the major rewrite"
- "Compare versions"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `operation` | enum | yes | `snapshot`, `diff`, `rollback`, `history`, `impact_analysis`, `compare` |
| `target_paths` | array | yes | Files or bible entities to operate on |
| `revision_description` | string | conditional | Required for `snapshot`: what this revision represents |
| `version_from` | string | conditional | Required for `diff` and `compare`: source version identifier |
| `version_to` | string | conditional | Required for `diff` and `compare`: target version identifier |
| `rollback_target` | string | conditional | Required for `rollback`: version to revert to |
| `change_description` | string | conditional | Required for `impact_analysis`: what's being changed |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `revision_snapshot` | object | Created revision with metadata, timestamp, and snapshot data |
| `diff_report` | object | Complete diff between two versions (additions, deletions, modifications) |
| `impact_analysis` | object | All entities/skills affected by a proposed or completed change |
| `revision_history` | array | Chronological list of all revisions for the target |
| `rollback_result` | object | Confirmation of rollback with restored state |
| `affected_dependencies` | array | Skills and entities that need updating due to changes |
| `revision_chain` | object | Parent-child revision links for full history traversal |

## Workflow

### Step 1: Operation Routing
Parse the operation type and route to the appropriate workflow.

### Step 2A: Create Snapshot
1. Identify all files/entities to include in the snapshot
2. Create a revision record:
   ```json
   {
     "revision_id": "rev_{timestamp}_{hash}",
     "timestamp": "ISO8601",
     "description": "User-provided description",
     "scope": ["list of affected files/entities"],
     "parent_revision": "previous_revision_id or null",
     "snapshot_data": {
       "file_path": "content_hash"
     }
   }
   ```
3. Store content hashes for efficient diffing
4. Update the revision chain (link to parent)
5. Return revision snapshot metadata

### Step 2B: Compute Diff
1. Load content for both versions
2. Compute line-by-line diff for manuscripts
3. Compute field-level diff for bible entities
4. Classify changes:
   - **Addition**: New content added
   - **Deletion**: Content removed
   - **Modification**: Content changed (show old → new)
   - **Restructure**: Content reorganized without semantic change
5. Generate human-readable diff report
6. Highlight semantically significant changes (character name changes, plot event reordering, flag value changes)

### Step 2C: Impact Analysis
Given a change (or proposed change):
1. Identify directly affected entities (what was changed)
2. Trace dependency graph to find indirectly affected entities:
   - Character backstory change → scenes featuring that character → dialogues → voice audit
   - Timeline event moved → all scenes referencing that event → mystery clues linked to that time → flag conditions
   - World rule changed → all scenes that use that rule → plot logic → route structure
3. Map affected skills that need to re-run:
   - Bible change → `bible-validator`
   - Manuscript change → `narrative-doctor`, `pacing-analyzer`, `theme-weaver`, `voice-keeper`
   - Character change → `character-designer` (for dependent characters), `dialogue-crafter`, `voice-keeper`
4. Estimate revision effort: number of entities × average fix complexity
5. Generate prioritized rework queue

### Step 2D: Rollback
1. Verify the target version exists in revision history
2. Check for dependent changes made AFTER the target version:
   - If later revisions depend on changes being rolled back, warn about cascade effects
3. Restore target version's content
4. Create a new revision marking the rollback
5. Generate impact analysis for the rollback (what's now out of sync)
6. Return rollback confirmation with affected dependencies

### Step 2E: View History
1. Traverse the revision chain for the target entity
2. Return chronological list with:
   - Revision ID, timestamp, description
   - Scope of changes
   - Parent revision
   - Whether this revision has been superseded or rolled back

### Step 2F: Compare Versions
1. Load both versions
2. Generate side-by-side comparison
3. Highlight semantic differences (not just textual)
4. For manuscripts: show changed prose with context
5. For bible entities: show field-by-field comparison
6. Return formatted comparison report

### Step 3: Dependency Notification
After any mutation (snapshot, rollback):
1. Identify all skills whose outputs may be invalidated
2. Generate notification list: "The following skills should be re-run: X, Y, Z"
3. If in coordinated revision mode, automatically queue re-run tasks

## Validation Rules

1. **Revision Description Required**: Every revision must have a meaningful description. "update" or "fix" is insufficient
2. **Unbroken Revision Chain**: Revision parent pointers must form a continuous chain. No orphaned revisions
3. **Snapshot Completeness**: A snapshot must capture all files within its declared scope. Partial snapshots that miss dependent files are invalid
4. **Rollback Safety**: Rollback must warn if it will create inconsistencies. Cannot rollback a bible entity without flagging all manuscripts that depend on it
5. **Impact Analysis Completeness**: Impact analysis must traverse the full dependency graph to depth 3 (direct → indirect → tertiary effects)
6. **Hash Integrity**: Content hashes must be verified on both snapshot creation and retrieval. Hash mismatch = data corruption warning
7. **Concurrent Revision Detection**: If two revision branches exist (parallel edits), flag the conflict. Manual resolution required
8. **No Silent Overwrites**: Creating a snapshot must not overwrite an existing revision with the same parent without explicit confirmation
9. **Bible-Manuscript Sync**: After any bible revision, flag all manuscripts written against the old bible version as potentially stale
10. **Revision Retention**: Revisions older than the last 5 revisions may be archived but must be recoverable. The last 5 revisions must be immediately accessible
