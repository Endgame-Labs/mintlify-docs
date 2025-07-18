# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Mintlify documentation starter kit - a static documentation site built using the Mintlify platform. The repository contains MDX files for documentation pages, configuration for site structure, and assets like images and logos.

## Architecture

- **docs.json**: Central configuration file defining site structure, navigation, theming, and metadata
- **MDX files**: Documentation content written in MDX (Markdown + JSX components)
- **Navigation structure**: Organized into tabs ("Guides" and "API reference") with nested groups and pages
- **Assets**: Images stored in `/images/` and logos in `/logo/` directories
- **API documentation**: OpenAPI specification in `/api-reference/openapi.json` for auto-generated API docs

## Development Commands

### Local Development
```bash
# Install Mintlify CLI globally
npm i -g mint

# Start local development server (runs on http://localhost:3000)
mint dev

# Use custom port
mint dev --port 3333

# Update CLI to latest version
mint update
```

### Content Validation
```bash
# Check for broken links in documentation
mint broken-links
```

## Key Configuration

- **Site configuration**: Edit `docs.json` for navigation, theming, and site metadata
- **Content**: Create/edit `.mdx` files in appropriate directories
- **Navigation**: Update the `navigation` section in `docs.json` to add new pages
- **Theming**: Modify colors and branding in the `colors` and `logo` sections of `docs.json`

## Content Structure

- Root pages: `index.mdx`, `quickstart.mdx`, `development.mdx`
- Essentials: Basic documentation features in `/essentials/`
- AI tools: Documentation about AI development tools in `/ai-tools/`
- API reference: Auto-generated and manual API docs in `/api-reference/`
- Snippets: Reusable content blocks in `/snippets/`

## Deployment

Changes are automatically deployed to production when pushed to the main branch via the Mintlify GitHub app integration. No manual build or deployment commands needed.

## Prerequisites

- Node.js version 19 or higher
- Mintlify CLI installed globally