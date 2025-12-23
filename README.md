# Endgame Mintlify Documentation

This repository contains the documentation for Endgame, built using the Mintlify platform. The documentation is deployed as a "monorepo" on Mintlify, meaning all Mintlify-specific files are contained within the `/mintlify` subdirectory rather than the project root.

## Project Structure

```
mintlify-docs/
├── mintlify/                 # Main documentation directory (deployed)
│   ├── mint.json            # Mintlify configuration
│   ├── index.mdx            # Homepage
│   ├── changelog.mdx        # Auto-generated changelog page
│   ├── *.mdx                # Documentation pages
│   ├── changelog_entries/   # Individual changelog entries (format: YYYY_MM_DD_prXXXX.change.md)
│   ├── features/            # Feature documentation
│   ├── integrations/        # Integration guides
│   ├── trust/               # Security & privacy docs
│   ├── images/              # Image assets
│   ├── logo/                # Logo assets
│   └── snippets/            # Reusable content blocks
├── internal/                 # Gitignored directory (not deployed)
│   ├── notion_site/         # One-time snapshot of old Notion docs
│   └── changelog/           # Auto-generated changelog data
│       ├── input/           # Raw changelog from GitHub/Linear
│       └── claude/          # Processed changelog entries
├── src/                      # Python tools for changelog generation
│   └── generate_changelog.py # Script that processes changelog entries
├── README.md                 # This file
├── CLAUDE.md                # AI assistant instructions
├── Makefile                 # Build automation
├── Procfile                 # Process definitions
└── pyproject.toml           # Python project configuration
```

## Development

### Prerequisites

- Node.js version 19 or higher
- Mintlify CLI installed globally

### Installation

Install the [Mintlify CLI](https://www.npmjs.com/package/mint) to preview documentation changes locally:

````bash

```npm i -g mint

### Local Development

Navigate to the `/mintlify` directory and start the development server:

```bash
cd mintlify
mint dev
````

View your local preview at `http://localhost:3000`.

To use a custom port:

```bash
mint dev --port 3333
```

### Content Validation

Check for broken links in your documentation:

```bash
mint broken-links
```

This command scans all documentation files for internal and external links, reporting any that are broken or unreachable.

### Updating the CLI

Keep the Mintlify CLI up to date:

```bash
mint update
```

## Monorepo Structure

This project is deployed as a Mintlify "monorepo", which means:

- All Mintlify documentation files are contained in the `/mintlify` subdirectory
- The `mint.json` configuration file is located at `/mintlify/mint.json`
- When running commands like `mint dev`, you must be in the `/mintlify` directory
- The deployment process knows to look in this subdirectory for the documentation

## Key Files

- **`/mintlify/mint.json`**: Central configuration file defining site structure, navigation, theming, and metadata
- **`/mintlify/*.mdx`**: Documentation content written in MDX (Markdown + JSX components)
- **`/internal/`**: This directory is gitignored and not meant for deployment. Contains:
  - Historical documentation snapshots
  - Auto-generated changelog data from GitHub and Linear

## Changelog System

The project includes an automated changelog generation system that processes individual changelog entries into a formatted changelog page.

### Changelog Entry Format

Individual changelog entries are stored in `/mintlify/changelog_entries/` with the naming convention:

```
YYYY_MM_DD_prXXXX.change.md
```

Each entry file contains:

- A title heading (# Title)
- Bullet points describing the changes
- Links section with references to:
  - GitHub PR (e.g., https://github.com/Endgame-Labs/cerebro/pull/XXXX)
  - Linear issues (e.g., https://linear.app/endgame/issue/END-XXXX)

Example entry:

```markdown
# New User Management Page

- Manage user invitations.
- View and manage organization users.
- Assign user roles.

Links:
https://github.com/Endgame-Labs/cerebro/pull/5194
https://linear.app/endgame/issue/END-4107
```

### Generating the Changelog

To process all individual changelog entries and update the main changelog page:

```bash
make changes
```

This command:

1. Activates the Python virtual environment
2. Runs the `src/generate_changelog.py` script
3. Processes all `.change.md` files in `/mintlify/changelog_entries/`
4. Groups entries by date
5. Updates the `/mintlify/changelog.mdx` file with the formatted changelog

The generated changelog uses Mintlify's `<Update>` components with date labels, organizing changes chronologically with the most recent updates first.

## Deployment

Changes are automatically deployed to production when pushed to the main branch via the Mintlify GitHub app integration. No manual build or deployment commands are needed.

## Troubleshooting

- **Dev environment won't start**: Run `mint update` to ensure you have the latest CLI version
- **404 errors**: Make sure you're running commands from the `/mintlify` directory where `mint.json` is located
- **Broken links**: Use `mint broken-links` to identify and fix broken internal/external links

## Resources

- [Mintlify Documentation](https://mintlify.com/docs)
- [Mintlify Community](https://mintlify.com/community)
- [Endgame Platform](https://endgame.io)
