# Endgame Changelog Style Guide

## Purpose
This guide ensures consistent, clear, and user-focused changelog entries that avoid redundancy and provide maximum value to our users.

## Changelog Structure

### 1. Monthly Releases
Group updates into monthly releases to maintain regular communication while reducing redundancy:
- Publish comprehensive monthly updates
- Bundle all changes from the month
- Use clear month/year headers (e.g., "July 2025")
- Include both major features and improvements

### 2. Feature Tiers

#### Tier 1: Major Features 🚀
**When to use:** New capabilities that fundamentally change how users work
- Brand new features that didn't exist before
- Major integration launches (e.g., "Slack Integration Launch")
- Platform-wide changes (e.g., "AI Chat Platform Launch")

**Format:**
```markdown
### 🚀 [Feature Name] v[X.0]
[One-line description of the game-changing capability]

**Key Capabilities:**
- [User benefit 1]
- [User benefit 2]
- [User benefit 3]
```

#### Tier 2: Feature Enhancements ⚡
**When to use:** Significant improvements to existing features
- Performance improvements >25%
- UI/UX overhauls
- Major feature additions to existing systems

**Format:**
```markdown
### ⚡ [Feature Area] Enhancements
- **[Specific improvement]** with [user impact]
- **[Performance metric]** through [what we did]
```

#### Tier 3: Improvements & Fixes 🔧
**When to use:** Bug fixes, minor improvements, polish
- Bundle these monthly or quarterly
- Don't create individual entries

**Format:**
```markdown
### 🔧 Platform Improvements
- Fixed [issue] in [feature area]
- Improved [aspect] for better [result]
- Enhanced [feature] stability
```

## Writing Guidelines

### 1. Focus on User Impact

❌ **Don't write:**
"Enhanced AI claim validation with improved corroboration algorithms"

✅ **Do write:**
"Every AI response now shows its sources with one-click verification"

### 2. Consolidate Related Features

Instead of multiple entries:
- July 10: "Improved Citations for Chat Messages"
- June 30: "Real-time Citations in Chat"
- June 27: "Improved Citation Display"

Write one comprehensive entry:
```markdown
### 📚 Advanced Citation System
Complete citation and source transparency for all AI responses.
- Real-time inline citations
- Dedicated Sources tab
- One-click verification
```

### 3. Use Consistent Terminology

Pick ONE term per concept:
- **Enhanced** OR **Improved** OR **Better** (not all three)
- **AI Chat** OR **Chat** OR **Conversation** (be consistent)
- **Person** OR **Contact** OR **Individual** (choose one)

### 4. Version Major Features

For significant updates to existing features:
- "Slack Integration v2.0" (not "Improved Slack Integration" repeatedly)
- "Citation System 2.0" (not multiple citation improvements)
- "Search 3.0" (not "Enhanced Search" multiple times)

## What NOT to Include

### 1. Redundant Entries
❌ Multiple entries saying the same thing differently
❌ Progressive rollout announced multiple times
❌ Technical iterations of the same improvement

### 2. Internal Technical Details
❌ "Migrated to new database architecture"
❌ "Refactored authentication system"
❌ "Updated internal APIs"

✅ Only include if there's direct user impact

### 3. Minor Visual Tweaks
❌ "Adjusted button padding"
❌ "Changed font size in sidebar"
❌ "Updated icon color"

✅ Bundle into "UI Polish" section of monthly updates

## Entry Templates

### New Integration
```markdown
### 🔌 [Service] Integration
Connect Endgame with [Service] for [main benefit].

**Key Features:**
- [Feature 1 - what users can do]
- [Feature 2 - what users can do]
- [Feature 3 - what users can do]

**Getting Started:** [Link to docs]
```

### Performance Improvement
```markdown
### ⚡ [Feature] Performance Boost
[Feature] is now [X]% faster, [specific user benefit].

**Improvements:**
- [Metric 1]: [Before] → [After]
- [Metric 2]: [Before] → [After]
```

### Feature Overhaul
```markdown
### 🎨 [Feature] Redesign
Completely reimagined [feature] for [main benefit].

**What's New:**
- [Visual change with benefit]
- [Functional change with benefit]
- [New capability users requested]
```

## Best Practices

### 1. Group by Theme
When multiple related improvements ship together:
```markdown
### 📧 Email Intelligence Suite
Smarter email processing across the platform.
- 5-year historical analysis
- Improved thread detection
- Better recipient matching
- Enhanced meeting extraction
```

### 2. Highlight Business Value
Always connect features to business outcomes:
- "Close deals faster with..." 
- "Never miss important context with..."
- "Save hours per week by..."

### 3. Use Metrics When Meaningful
- "50% faster response times"
- "10x more accurate person matching"
- "Process 5 years of historical data"

### 4. Add Context for Major Changes
For significant updates, include:
- Why the change was made
- Migration notes if applicable
- Link to detailed documentation

## Monthly Update Structure

### Standard Monthly Format
```markdown
## [Month] [Year]

<Update label="[Month] [Year] Major Features">
[New capabilities and major enhancements]
</Update>

<Update label="[Month] [Year] Performance & Reliability">
[Performance improvements, bug fixes, and platform stability]
</Update>
```

### Monthly Summary Guidelines
- Lead with the most impactful changes
- Group all related improvements together
- Include metrics where meaningful
- End with a "Looking Ahead" section for major months

## Review Checklist

Before publishing a changelog entry, ensure:

- [ ] No duplicate entries for the same feature
- [ ] User impact is clear (not technical details)
- [ ] Related changes are grouped together
- [ ] Consistent terminology throughout
- [ ] Appropriate tier (Major/Enhancement/Fix)
- [ ] Business value is highlighted
- [ ] Any breaking changes are clearly marked
- [ ] Links to documentation included where needed

## Examples of Consolidation

### Before (Redundant):
- May 8: "Improved Chat Scrolling"
- April 23: "Improved Account Chat Experience" 
- April 30: "Eliminates double scrollbars"
- May 27: "Chat automatically scrolls"

### After (Consolidated):
```markdown
### 💬 Chat Experience Redesign
Completely overhauled chat interface for seamless conversations.
- Smart auto-scrolling keeps you oriented
- Larger, resizable chat window
- Eliminated scrolling issues on all devices
```

## Maintenance

- Review monthly for entries that can be consolidated before publication
- Ensure each month has a cohesive narrative
- Update terminology guide as new features emerge
- Track which types of updates users engage with most
- Adjust grouping strategies based on user feedback
- Consider special "Year in Review" summary annually