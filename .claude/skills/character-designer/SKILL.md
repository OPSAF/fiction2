---
name: character-designer
description: Create fully-realized characters with psychological depth — wound/lie/need/desire/ghost pentad, voice guides, relationship matrices, and arc templates across multiple routes. Produces character bible entries.
---

# character-designer

## Purpose
Create characters with genuine psychological depth, distinct voice, and narrative function. Every character — from protagonist to one-scene side character — receives a complete profile anchored in the **wound → lie → need → desire → ghost** pentad. Characters are designed to serve the story's dramatic architecture while feeling like real people with internal contradictions.

## Trigger
- "Create the protagonist" / "Design the main character"
- "I need a heroine/rival/mentor/antagonist"
- "Flesh out this character"
- "Design the character cast"
- "What's X's backstory"
- "Define the relationship between X and Y"
- "Create a character voice guide"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `role` | enum | yes | Narrative role: `protagonist`, `heroine`, `rival`, `mentor`, `antagonist`, `supporting`, `cameo` |
| `story_context` | object | yes | Plot overview, tone, genre, world setting summary |
| `character_requirements` | object | yes | What the story needs from this character (dramatic function) |
| `existing_characters` | array | yes | Already-designed characters (for voice differentiation and relationship design) |
| `world_entities` | array | yes | Relevant world bible entries (factions, locations, history) for backstory integration |
| `route_count` | integer | no | Number of planned routes (for arc template design per route) |
| `reference_archetype` | string | no | Archetype to subvert or embody (e.g., "tsundere", "kuudere", "genius antagonist") |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `character_entity` | object | Complete character bible entry ready for bible-manager |
| `voice_guide` | object | Detailed speech pattern, vocabulary, and mannerism specifications |
| `relationship_matrix` | object | Relationship vectors to all existing characters |
| `arc_template` | object | Character arc trajectory across common route and each specific route |
| `voice_differentiation_report` | object | Confirmation that this character's voice is distinguishable from all others |

## Workflow

### Step 1: Load Context
1. Query `bible-manager` for existing character entities (`entity_type: character, operation: list`)
2. Query `bible-manager` for relevant world entities (factions, locations, historical events)
3. Absorb story context: genre, tone, dramatic premise

### Step 2: Define Narrative Function
1. What does the **story** need from this character?
   - Protagonist: drives the story, makes key decisions, undergoes transformation
   - Heroine: embodies a thematic value, provides emotional stakes, has independent arc
   - Rival: challenges protagonist, represents alternative path, forces growth
   - Antagonist: opposes protagonist's goal, embodies the lie, has understandable motivation
   - Mentor: provides wisdom/tools, has own tragedy, may die/leave
2. What **theme** does this character embody or challenge?
3. What **dramatic question** does this character exist to answer?

### Step 3: Design Surface Traits
1. **Name**: Culturally appropriate, era-appropriate, with possible meaning/kanji significance
2. **Appearance**: Distinctive features, consistent visual identity, clothing reflects personality
3. **Mannerisms**: 3-5 physical/verbal habits that make them recognizable
4. **Surface personality**: How they present to the world (may differ from true self)
5. **Social role**: Status, occupation, group membership

### Step 4: Design Deep Structure (The Pentad)
1. **Wound** (過去の傷): The past trauma or painful experience that shaped them
2. **Lie** (偽りの信念): The false belief about themselves or the world that the wound created
3. **Need** (真に必要なもの): What they actually need to heal/grow (may be unaware of it)
4. **Desire** (表面的な望み): What they think they want; the conscious goal
5. **Ghost** (心の亡霊): The specific past event or person that haunts them, manifesting in present behavior

The pentad must form a coherent psychological structure:
```
Wound → creates → Lie → drives → Desire (wrong goal)
                                 vs.
                        Need (right goal that would heal the Wound)
Ghost → triggers → Lie at key moments
```

### Step 5: Design Voice Guide
1. **Speech patterns**: Sentence length tendency, complexity, directness
2. **Vocabulary register**: Simple, moderate, or sophisticated word choice
3. **Catchphrases/verbal tics**: 1-3 distinctive phrases or patterns
4. **Honorific usage**: Default level (casual/polite/formal), when it shifts
5. **Emotional expressiveness**: Reserved, moderate, or expressive
6. **Forbidden words/phrases**: Things this character would never say
7. **Internal monologue style**: How they think vs. how they speak

### Step 6: Design Relationships
For each existing character, define:
1. **Relationship type**: Friend, lover, rival, enemy, mentor, family, stranger
2. **History**: How they met, key shared experiences
3. **Dynamic**: Power balance, unspoken tensions, mutual needs
4. **Evolution potential**: How the relationship can change across routes
5. **Honorific usage**: What they call each other (and why)

### Step 7: Design Arc Template
1. **Common route arc**: Where the character starts, midpoint shift, where they end before route branch
2. **Per-route arc**: How different routes develop or reveal different aspects
3. **Bad-end states**: What failure looks like for this character
4. **True-end resolution**: The most complete version of their arc

### Step 8: Verify and Write
1. Run voice differentiation check against all existing characters:
   - Compare speech patterns, vocabulary, tics
   - If linguistic fingerprint overlaps >30% with another character, refine
2. Verify pentad coherence (Wound→Lie→Desire chain is logical)
3. Verify relationship bidirectionality (both sides defined)
4. Write character entity to `bible-manager` (`entity_type: character, operation: create`)
5. Return complete output package

## Validation Rules

1. **Pentad Completeness**: All five elements (wound, lie, need, desire, ghost) must be present and logically connected
2. **Voice Uniqueness**: Character's linguistic fingerprint must differ from every other character by at least 70% on the differentiation metrics
3. **Relationship Bidirectionality**: If A's relationship to B is defined, B must have a corresponding relationship entry for A
4. **No Mary Sue/Gary Stu**: Check for indicators — universally liked without reason, no meaningful flaws, always right, trauma without behavioral impact
5. **Narrative Function**: Character must serve a clear dramatic function. No "cool character" without story purpose
6. **Arc Potential**: Character must have growth potential in at least the common route. Static characters are only acceptable for cameo roles
7. **World Integration**: Backstory must reference specific world bible entities (locations, events, factions)
8. **Name Validity**: Name must be culturally and period-appropriate; kanji readings must be documented if used
9. **Honorific Logic**: Honorific usage patterns must be internally consistent and match relationship dynamics
10. **Flaw Genuineness**: Character flaws must have actual narrative consequences. A "flaw" that never causes problems is not a flaw
