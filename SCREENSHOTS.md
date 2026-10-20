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

## Capture

- Dark mode, demo org, 2× (Retina). Turn off the internal dev bar.
- Browser window at 1440 × 900, so text renders at one size every time.
- Crop to the thing being explained. Leave out the dimmed backdrop behind dialogs.
- Never scale up.
- Name files `what-it-shows-MM-DD-YY.png`.

## Framing (not decided yet)

The options are compared at https://claude.ai/artifact/2B94ydFuSxPjqeoPv5vZcU. The leading option is a quiet, dimmed aurora background on a fixed-width canvas, so on-page scale stays consistent. Third-party screens like Microsoft or Notion sign-in stay unframed.

## Open items on this branch

- **Digests** (`features/digests.mdx`): replace `edit-digest-10-16-26.png` with an Instruction shot of a digest card's "…" menu open. That one image covers Run now, editing and deleting, and the page doesn't currently say how to delete. Confirm the menu's items in the app before writing the caption.
