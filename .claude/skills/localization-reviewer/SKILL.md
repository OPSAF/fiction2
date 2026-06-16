---
name: localization-reviewer
description: Review content for Japanese cultural accuracy and localizability — honorific audit, cultural reference verification, social norm accuracy, dialect appropriateness, and preparation of localization notes for future translators.
---

# localization-reviewer

## Purpose
Ensure the work is culturally authentic for its Japanese setting while being structurally prepared for future localization into other languages. This skill serves two audiences: (1) the Japanese reader who will notice cultural inaccuracies instantly, and (2) the future translator who needs to understand what's culturally specific vs. what can be adapted. This is not a translation skill — it's a cultural accuracy and localization-readiness audit.

## Trigger
- "Check cultural accuracy"
- "Review the honorifics"
- "Is this culturally appropriate for a Japanese setting"
- "Audit the school system accuracy"
- "Prepare localization notes"
- "Will this make sense to a Western audience"
- "Check for anachronisms"
- "Review regional dialect usage"

## Inputs
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `manuscript_sections` | array | yes | All scene manuscripts to review |
| `character_voice_guides` | array | yes | Voice guides with honorific patterns from bible-manager |
| `world_setting` | object | yes | World bible entries (time period, location, cultural context) |
| `target_markets` | array | no | Planned localization markets: `en_us`, `zh_cn`, `ko_kr`, etc. (for localization-readiness assessment) |
| `review_focus` | array | no | Specific areas: `honorifics`, `school_system`, `social_norms`, `seasonal_events`, `food_culture`, `dialect`, `pop_culture_references`, `wordplay`, `all` |

## Outputs
| Field | Type | Description |
|-------|------|-------------|
| `cultural_review_report` | object | Complete cultural accuracy assessment |
| `honorific_audit` | object | Every honorific usage with accuracy assessment |
| `cultural_reference_accuracy` | object | Verification of seasonal events, customs, school system, social norms |
| `anachronism_report` | array | Elements that don't belong in the story's time period or setting |
| `dialect_assessment` | object | Regional dialect appropriateness and consistency |
| `localization_notes` | object | Comprehensive notes for future translators |
| `problematic_content_flags` | array | Content that may need sensitivity review for target markets |
| `cultural_authenticity_score` | number | Overall cultural accuracy score (0-100) |

## Workflow

### Step 1: Load Cultural Context
1. Query `bible-manager` for:
   - World setting (time period, real-world location basis, fictional elements)
   - Character voice guides (honorific patterns, dialect markers)
   - All scene manuscripts
2. Establish the cultural baseline:
   - If set in real Japan (e.g., Akihabara 2010): verify against real-world accuracy
   - If set in fictional Japan-like setting: verify internal cultural consistency
   - If set in completely fictional world: verify cultural logic and consistency

### Step 2: Honorific Audit
For every instance of honorific usage in dialogue:

1. **Map character relationship → expected honorific**:
   - Senpai-kouhai → `-senpai` / `-kun` or `-san`
   - Teacher-student → `-sensei` / `-kun` or `-san`
   - Classmates (same year) → `-san` or `-kun` (distance) / yobisute (close)
   - Close friends → yobisute or `-chan`/`-kun`
   - Lovers → yobisute, possibly `-chan`/`-kun`, pet names
   - Strangers → `-san`

2. **Flag honorific errors**:
   - Wrong honorific for the relationship
   - Inconsistent honorific usage (same relationship, different honorifics without reason)
   - Missing honorific where one is expected
   - Honorific on self (characters should never use honorifics for themselves)

3. **Identify honorific shift moments** (relationship milestones):
   - Surname+san → First name (MAJOR intimacy escalation)
   - -san → yobisute (relationship has deepened significantly)
   - Adding honorific after being casual (relationship cooling/distance)
   - Verify each shift is intentional and narratively justified

4. **Special cases**:
   - Public vs. private: Characters may use more formal honorifics in public than private
   - Emotional state: Anger may cause honorific dropping (intentional rudeness)
   - Deliberate rudeness: Dropping honorifics to insult (must be clearly intentional in context)

### Step 3: Cultural Reference Verification

**School System Accuracy** (for school-setting works):
- Japanese academic year: April start, March end (not September-June)
- Three terms: April-July, September-December, January-March
- School festivals (文化祭/bunkasai): Typically October-November
- Sports festivals (体育祭/taiikusai): Typically May-June or September-October
- Entrance exams (入学試験): January-February for high school, February-March for university
- Club activities: After school daily, weekend practice, summer training camps
- Classroom structure: Homeroom (组), seating charts, cleaning duty (扫除当番)
- Verify all school events match the correct season and term

**Seasonal Event Accuracy**:
- Cherry blossoms (桜/sakura): Late March to early April (not year-round!)
- Summer festivals (夏祭り/natsumatsuri): July-August, with yukata, fireworks (花火大会)
- Tanabata (七夕): July 7
- Obon (お盆): Mid-August
- Culture Day (文化の日): November 3
- New Year (お正月/oshōgatsu): January 1-3, shrine visits (初詣/hatsumōde)
- Valentine's Day: February 14 (girls give to boys); White Day: March 14 (boys return)
- Christmas: December 24-25 (romantic holiday for couples in Japan, not family holiday)

**Social Norm Accuracy**:
- Indoor/outdoor shoe change (上履き/uwabaki in schools)
- Bowing depth and duration (casual 15°, polite 30°, deep apology 45°+)
- Indirect communication norms (reading the air, avoiding direct "no")
- Gift-giving customs (omiyage, seasonal gifts)
- Bathing culture (ofuro, sento, onsen etiquette)
- Meal etiquette (itadakimasu, gochisousama, chopstick taboos)

### Step 4: Anachronism Detection
1. Verify technology level matches the time period:
   - 2010 Japan: Flip phones (garakei) still common, smartphones emerging, LINE app launched 2011
   - 2000s: Feature phones, no smartphones, Mixi (early SNS), 2channel
   - 1990s: Pagers → early mobile phones, no widespread internet
2. Verify pop culture references are period-appropriate
3. Verify fashion, slang, and social trends match the era
4. Flag any "2020s thinking in a 2010s setting"

### Step 5: Dialect Assessment
If characters use regional dialects:
1. Verify dialect features are accurate for the claimed region:
   - Kansai-ben (Osaka/Kyoto/Kobe): ～や (ya), ～へん (hen), あかん (akan), おおきに (ookini), なんでやねん (nandeyanen)
   - Tohoku-ben: distinct vowel shifts
   - Hakata-ben: ～たい (tai), ～と？ (to?)
   - Hiroshima-ben: ～じゃけえ (jakē)
2. Verify consistency: character doesn't randomly drop in and out of dialect
3. Verify social context: dialect usage often decreases in formal settings (code-switching)
4. Flag "TV dialect" (stereotypical, inaccurate dialect portrayal)

### Step 6: Wordplay and Untranslatable Content
Identify content that will challenge translators:
1. **Kanji-based wordplay**: Puns relying on multiple readings of kanji
2. **Honorific-based humor**: Jokes that only work because of Japanese speech levels
3. **Cultural knowledge gags**: References to Japanese celebrities, TV shows, memes
4. **Keigo comedy**: Humor derived from formality level mismatches
5. **Dialect humor**: Comedy based on regional speech differences
6. For each, provide: the Japanese original, explanation of why it works, and suggested localization approach

### Step 7: Generate Localization Notes
For each identified localization challenge:
1. **Category**: Honorific, cultural reference, wordplay, social norm, food, etc.
2. **Original context**: What it is in Japanese and why it matters
3. **Localization options per target market**:
   - **Preserve**: Keep the Japanese element with explanation (suitable for dedicated fans)
   - **Adapt**: Find a cultural equivalent in the target culture
   - **Explain**: Add a translation note (TL note)
   - **Rewrite**: Change the content to something that works in the target language
4. **Recommendation**: Which approach is best for each target market

### Step 8: Produce Cultural Review Report
1. Honorific audit results
2. Cultural reference accuracy assessment
3. Anachronism findings
4. Dialect assessment
5. Localization readiness notes
6. Overall cultural authenticity score

## Validation Rules

1. **Honorific Accuracy**: 100% of honorific usages must match the character relationship state. Zero honorific errors allowed
2. **Honorific Shift Documentation**: Every honorific shift must be traceable to a documented relationship change event
3. **School Calendar Accuracy**: All school events must match the real Japanese academic calendar for the stated time period
4. **Seasonal Accuracy**: Seasonal descriptions (cherry blossoms, snow, heat) must match the stated date and Japanese climate
5. **No Period Anachronisms**: Technology, fashion, slang, and cultural references must all be consistent with the stated time period
6. **Dialect Consistency**: If a character uses dialect, the features must be accurate and usage must be consistent
7. **Self-Honorific Prohibition**: Zero instances of characters using honorifics for themselves
8. **Indoor/Outdoor Consistency**: Characters must change shoes when entering schools/homes (unless specifically noted as an exception)
9. **Food Seasonality**: Food references must match seasonal availability in Japan (e.g., no watermelon in winter without comment)
10. **Localization Documentation**: Every identified localization challenge must have at least one suggested approach for each target market
