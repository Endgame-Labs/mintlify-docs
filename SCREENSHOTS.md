# Docs screenshot guide

Rules for screenshots on docs.endgame.io and the text around them. We're testing them on the Settings update (Linear: "Docs: settings update", 37 pages, 110 of the 136 images in use) before applying them to the rest of the docs.

## 1. Decide if it needs an image

Add a screenshot only when text can't do the job as well. Screenshots go stale, and screen readers can't read them.

- A labelled button or link needs no image. Say where it is: "At the top right of the page, click **New digest**."
- Show what an action opens (the New digest form), not the control that opens it.
- Prefer one image that answers several things, like a card's menu showing Run digest, Edit and Delete.

## 2. Pick the image's job

| Job | Shows | Capture | Caption |
|---|---|---|---|
| **Signpost** | Where you are or what to look for. A whole page or just part of one. | Only enough to recognise the spot. | Say what the reader is looking at: "The Digests page lists your digests and when each one runs next." |
| **State** | How something looks in one condition: empty, filled, connected, error. | The component in that state. | Say what the state means: "A connected integration shows who connected it and when." |
| **Instruction** | An action hidden behind a click or hover (menu, dropdown, hover button). | The control already open. | Say what to do: "Use the ⋮ menu on a digest card to run, edit, or delete it." |

## 3. Capture

All sizes are the **viewport** (the page area, not the browser window) in CSS pixels. Image files are twice that, because we capture at 2× on Retina.

- **Viewport:** set it so the UI you're capturing is about **650–700 px wide**. The docs column is 441–648 px wide and stretches every image to fit, so this width shows at about real size. Reference: `digest-card-menu-10-20-26.png`. For wide pages, narrow the browser so the UI reflows to that width. Don't capture a wide layout and let it shrink.
- **Crop:** the subject plus enough of its surroundings to show where it lives, like a menu inside its card. Zoom in tighter only when the subject would be too small to see in context, such as an unlabelled icon or a control that only appears on hover. Leave out the dimmed backdrop behind dialogs.
- **Tall pages:** capture the top of the page plus the relevant card or section, not the whole scrolling list.
- **Never scale an image up.**
- **App state:** dark mode, demo org, realistic demo data (never lorem ipsum or real customer data), internal dev bar off.
- **CleanShot:** use region capture (⌘⇧4, then drag). Window capture (⌘⇧4, then Space) adds 240 px of wallpaper on every side, so use it only when the whole window is the point.
- **Chrome:** collapse the vertical tab sidebar while capturing. If it's open, it takes about 240 px, so window width = viewport + 240. Check the viewport with the ruler: https://claude.ai/artifact/9hjDA6WbugYUp5a1N3Z2DX. Inside the artifact viewer it reads a little narrower than the real viewport.

### Capturing as an agent (Claude in Chrome)

The Chrome tool's own screenshots are 1×, so don't use them in the docs. Instead:

1. Keep the tab in its own window and in front. A background tab reports a stale 850 × 1241.
2. Resize the window to the target viewport plus the interface (outer minus inner size). Then measure the subject with `getBoundingClientRect()` and adjust until it's 650–700 px wide.
3. Find the window's ID (CGWindowList, matched on `screenX`/`screenY`/`outerWidth`/`outerHeight`) and run `screencapture -x -o -l<id> out.png`. That captures the window at 2× with no shadow, even if something overlaps it.
4. Crop: the page starts at (outerWidth − innerWidth, outerHeight − innerHeight) inside the window. Multiply everything by 2 and leave a 14 px margin (CSS) around the subject. Check the edges for a neighbouring element's border.

### Capturing from Storybook

Most integration screenshots come from Storybook stories of the real app pages, rendered with made-up demo data. That means no workspace to connect and no real data to hide. The stories are in the cerebro repo under **Features / Settings / Integrations** (Index, Connect dialogs and one page per integration), and the scripts in `scripts/storybook/` capture them at 2×, dark, with the 14 px margin.

1. In cerebro, start Storybook: `bun run --cwd src/webapp/core storybook --port 6007`.
2. Find the story's ID: open it, then click **Open canvas in new tab**. The ID is the `id=` in the URL, like `features-settings-integrations-pages-microsoft-sharepoint--connected`.
3. Run the script that fits. Pass Playwright from cerebro (`<cerebro>/node_modules/playwright/index.js`) and the Storybook URL (`http://localhost:6007`). Use a width of **760** for pages: the content is then 680 px wide.

| Script | Captures | Arguments after Playwright and the URL |
|---|---|---|
| `capture-section.cjs` | One section of a page, from its heading down to a table or a named element | `<story-id> <width> "<heading>" table <out.png>`, or `"text:<exact text>"` in place of `table` |
| `capture-dialog.cjs` | The open dialog, with the page behind it hidden | `<story-id> <width> <out.png>`. Widen the viewport (e.g. 1100) for dialogs with wide tables. |
| `capture-stories.cjs` | Whole pages, one file per story | `<out-dir> <width> <story-id>...` |

For example:

```bash
node scripts/storybook/capture-section.cjs ~/Projects/endgame/cerebro/node_modules/playwright/index.js \
  http://localhost:6007 features-settings-integrations-pages-microsoft-sharepoint--connected 760 \
  "Synced document libraries" table mintlify/images/sharepoint-synced-document-libraries-MM-DD-YY.png
```

If a story's data is wrong for what the docs need, fix the story in cerebro rather than editing the image. Stories must only show states the real app can reach.

## 4. Highlights

Rarely needed. A good crop usually does the job.

- One per image: an arrow (3 px line) or a rounded outline (2 px). Double both in 2× files. If you need two, use two images or a numbered list.
- Colour **`#b5455d`** (Terminus `red.600`, the red solid background) in light and dark mode.
- No blur, glow, spotlight or dimming.
- No text inside the image. Explanations go in the caption or the page text.

## 5. Write the text around it

- **Say where, then what:** "On the digest card, click the toggle."
- **Start steps with a verb.** Use a numbered list for three or more steps, and a sentence or bullets for one or two.
- **UI names** in bold, spelled exactly as they appear in the app.
- **Paths:** **Settings** > **You** > **Digests**, with each name bold and the `>` plain. Never `→`. Always include the group: You, Organization or Developers.
- **Headings** name the task: "Create a digest", not "Digest creation".
- **Tone:** plain and friendly, like a helpful teammate. Not clinical, not cute.
- **Captions** are one full sentence ending in a period, worded for the image's job (see the table). Never say "the image above".
- **Alt text** is always required. Under 155 characters, leading with what the image is there to show.

## 6. Files

- PNG, about 500 KB or less.
- Name: `what-it-shows-MM-DD-YY.png`.

## 7. Never show secrets or confidential info

Check every image before committing it. These must never appear, not even partly or masked with dots:

- API keys, client secrets, tokens, passwords, private keys, or webhook URLs.
- Tenant, instance or account identifiers, like a Salesforce instance URL, a Snowflake account ID or a Seismic tenant.
- Customer names, deal data, or anything from a real customer's records.
- People's names and emails, unless they're demo data. This includes "Connected … by [name]" in the Connection section.

To show a credentials dialog, capture it **empty**. Never type real values to make a screenshot. Hide anything else with a solid block, not a blur. If you're unsure, leave it out and ask.

## Framing (not decided yet)

The leading option is a dimmed aurora background on a fixed-width canvas. It keeps on-page scale consistent, so small crops don't get stretched. Third-party screens like Microsoft or Notion sign-in stay unframed. Options: https://claude.ai/artifact/2B94ydFuSxPjqeoPv5vZcU. Until this is decided, commit plain captures.

## Open items on this branch

- **Digests** (`features/digests.mdx`): done. `digest-card-menu-10-20-26.png` was retaken at an 860 px viewport (card 670 px). `edit-digest-10-16-26.png` is no longer used.
- **Consistency pass** over every Settings page: bold `>` path format, and captions as full sentences.
