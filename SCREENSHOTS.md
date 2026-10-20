# Screenshot guide

Working decisions for docs.endgame.io screenshots. We're testing these on the Settings update (Linear project "Docs: settings update"), which covers 37 pages and 110 of the 136 images in use. Once they hold up there, we'll apply them to the rest of the docs.

## Pick the image's job first

Each screenshot does one of three jobs. The job decides what to capture and how to write the caption.

| Job | What it shows | Capture | Caption |
|---|---|---|---|
| **Signpost** | "You're in the right place." Helps the reader find where they are, or what to look for. It can be a whole page or just part of one, like a section, a panel or one integration's Connection area. | Only as much as the reader needs to recognise the spot, at rest. Don't crop to the full page by default. | Name the place or the thing: "Settings > You > Digests", "The Connection section on an integration's page". |
| **State** | What something looks like in a given condition: empty form, filled form, connected, error, confirmation. | The component in that state, filled with realistic demo data. | Name the state: "A connected integration, with Update credentials and Disconnect". |
| **Instruction** | An action that isn't obvious from the page, especially one hidden behind a click or hover, like a "…" menu, a hover action or a dropdown. | The control already opened, so the hidden part is visible. | Say what to do: "Open the … menu on a digest to edit, run or delete it". |

When choosing an image, prefer one that answers several things on the page at once. For example, one open overflow menu can show edit, run and delete together.

## Captions and alt text

- **Captions** are for sighted readers. They match the image's job (see the table).
- **Alt text** describes what's in the image for screen readers. Lead with the thing the image is there to show.

## Width (rough guess, revisit after the Settings update)

The docs stretch every image to fill the content column. On desktop that column is **441–648 px wide** (CSS px, measured on the local preview at 1280, 1440 and 1920 px browser widths). So:

- **Aim for about 650–700 px of UI (1300–1400 px at 2×).** It then shows at roughly its real size, so text on the page matches what people see in the app. `digest-card-menu-10-20-26.png` (1418 px) is the reference.
- **Wider captures shrink.** A 1,972 px users table shows at about 60%, which makes small text hard to read. Narrow the browser so the UI reflows to about 700 px, rather than capturing a wide layout and letting it shrink.
- **Narrower captures get blown up.** A 542 px zoomed-in crop is stretched about 2.4×, so it looks huge and soft. Put small crops on the fixed-width canvas instead of letting them stretch (see Framing).
- **Prefer context over zoom.** For a menu or button, show it inside its card or section (like the digest card with its menu open). Zoom in tighter only when the control would be too small to see in context, such as one icon on a busy page.
- **Tall captures:** a full Settings window with a list is very tall. Usually a Signpost of the top of the page plus the relevant card is enough.

## Capture

- Dark mode, demo org, 2× (Retina). Turn off the internal dev bar.
- Use the region capture (⌘⇧4, then drag). It has no background, so the framing script adds one later. Window capture (⌘⇧4, then Space) includes the desktop wallpaper, so use it only when the whole window is the point.
- Crop to the thing being explained. Leave out the dimmed backdrop behind dialogs.
- Never scale up.
- Name files `what-it-shows-MM-DD-YY.png`.

## Framing (not decided yet)

The options are compared at https://claude.ai/artifact/2B94ydFuSxPjqeoPv5vZcU. The leading option is a quiet, dimmed aurora background on a fixed-width canvas, so on-page scale stays consistent. Third-party screens like Microsoft or Notion sign-in stay unframed.

## Open items on this branch

- **Digests** (`features/digests.mdx`): done. The new "Manage a digest" section covers the toggle, editing, Run digest and Delete. It uses `digest-card-menu-10-20-26.png`, a rough hand crop to retake at the final capture settings. `edit-digest-10-16-26.png` is no longer used.
