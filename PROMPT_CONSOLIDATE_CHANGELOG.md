# Prompt: Consolidate Changelog Entries

## Purpose
This prompt helps consolidate redundant changelog entries into a more organized, user-friendly format following the established guidelines.

## Instructions

When consolidating changelog entries:

### 1. Group by Month
- Organize entries by month (not individual dates)
- Create two main sections per month:
  - "Major Features" - for new capabilities and significant enhancements
  - "Performance & Reliability" - for improvements, fixes, and optimizations

### 2. Apply Feature Tiers

**Tier 1: Major Features** 🚀
- New capabilities that didn't exist before
- Significant platform additions
- Integration launches
- Major version updates (v2.0, v3.0)

**Tier 2: Feature Enhancements** ⚡
- Substantial improvements to existing features
- Performance milestones (>25% improvement)
- UI/UX overhauls
- Minor version updates (v1.2, v1.3)

**Tier 3: Improvements & Fixes** 🔧
- Bug fixes and minor improvements
- Small performance optimizations
- Visual tweaks and polish
- Bundle these into "Platform Improvements"

### 3. Consolidation Guidelines

#### Identify Redundancy
Look for entries that describe the same feature with different wording:
- Multiple "improved citation" entries → One "Citation System v2.0"
- Several "enhanced Slack" entries → One "Slack Integration" with version
- Various "faster AI" entries → One "AI Performance" section

#### Write User-Focused Descriptions
❌ **Don't write:** "Enhanced AI claim validation with improved corroboration algorithms"
✅ **Do write:** "Every AI response now shows its sources with one-click verification"

#### Use Consistent Terminology
Pick ONE term per concept:
- Enhanced OR Improved OR Better (not all three)
- Person OR Contact OR Individual (choose one)
- AI Chat OR Chat OR Conversation (be consistent)

### 4. Version Major Features
Track feature evolution with versions:
- Slack Integration v1.0 → v2.0
- Citation System v1.0 → v2.0
- Search v1.0 → v2.0 → v3.0

### 5. Structure Each Entry

For major features:
```markdown
### 🚀 [Feature Name] v[X.0]
[One-line description of the capability]

**Key Capabilities:**
- [Specific user benefit 1]
- [Specific user benefit 2]
- [Specific user benefit 3]
```

For enhancements:
```markdown
### ⚡ [Feature Area] Enhancements
- **[Specific improvement]** with [user impact]
- **[Performance metric]** through [benefit]
```

### 6. What to Avoid
- Duplicate entries for the same feature
- Technical jargon without user context
- Multiple entries for progressive rollouts
- Separate entries for bug fixes
- Overly granular updates

### 7. Example Consolidation

**Before (Redundant):**
- July 10: "Improved Citations for Chat Messages"
- June 30: "Real-time Citations in Chat"
- June 27: "Improved Citation Display"
- June 26: "Chat Thread Citations"
- June 25: "See Sources in Chat"

**After (Consolidated):**
```markdown
### 📚 Citation System v2.0
Complete citation and source transparency for all AI responses.

**Key Features:**
- Real-time inline citations appear as AI generates responses
- Dedicated Sources tab with numbered references
- Citations persist through message edits and regeneration
- Enhanced visual styling and formatting
```

## Output Format

The consolidated changelog should:
1. Use Mintlify's `<Update>` component for each monthly section
2. Include clear month/year headers
3. Group related improvements together
4. Focus on business value and user impact
5. Use consistent emoji indicators
6. Maintain feature version tracking