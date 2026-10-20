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

## Does it need an image at all?

Screenshots go stale, screen readers can't read them, and every one is something to keep up to date. Add one only when text can't do the job as well.

- **A labelled button or link usually needs no image.** Say where it is in the text: "At the top right of the Digests page, click **New digest**." An isolated button doesn't help people find it, because it has lost the page around it.
- **Show what an action opens, not the control that opens it.** For example, show the New digest form (a State image), not the New digest button.
- **Isolate something only when it's hard to find or hard to describe**, like an unlabelled icon or a control that only appears on hover. Even then, keep enough surrounding context to show where it lives (see the digest card menu).

## Writing around images

- **Say where, then what:** "On the digest card, click the toggle." "In **Settings** > **You** > **Digests**, click **New digest**."
- **Start steps with a verb.** Use a numbered list for three or more steps, and a sentence or bullets for one or two.
- **Paths:** write **Settings** > **You** > **Digests**, with the names bold and the `>` plain. Don't use `→`. Always include the group (You, Organization or Developers).
- **UI names in bold**, spelled exactly as they appear in the app ("Run digest", not "Run now", if that's what the menu says).
- **Headings name the task:** "Create a digest", "Manage a digest", not "Digest creation".
- **No text inside images.** Explanations go in the caption or the page text.
- **Tone:** plain and friendly, the way a helpful teammate would explain it. Not clinical, not cute.

## Captions and alt text

- **Captions** are for sighted readers. They match the image's job (see the table) and are written as plain sentences. Don't say "the image above".
- **Alt text** describes what's in the image for screen readers. Lead with the thing the image is there to show, and keep it under 155 characters. If the image only repeats steps already in the text, alt text can be empty (`alt=""`).

## Highlights

Use them rarely. A good crop usually does the job.

- **One style:** a single arrow or a rounded outline in **`#b5455d`** (Terminus `red.600`, the red solid background). It's the same in light and dark mode.
- **Arrow line 3 px, outline 2 px** at 1× (6 px and 4 px in a 2× file).
- **One highlight per image.** If you need two, it's probably two images or a numbered list.
- No blur, glow, spotlight or dimming effects.

## Files

- PNG, not JPEG (UI text stays sharp).
- Aim for about 500 KB or less after compression. If one is much bigger, it's usually too much UI or the wrong format.
- Use realistic demo data, never lorem ipsum or real customer data. Hide anything personal with a solid block, not a blur.

## Width (rough guess, revisit after the Settings update)

**Convention:** every dimension in this guide is the **viewport** (the page area inside the browser) in CSS pixels, unless it says otherwise. A "1440 px capture" means a 1440 px viewport, not a 1440 px window. The image file is twice that at 2× (Retina).

The docs stretch every image to fill the content column. On desktop that column is **441–648 px wide** (CSS px, measured on the local preview at 1280, 1440 and 1920 px viewport widths). So:

- **Aim for about 650–700 px of UI (1300–1400 px at 2×).** It then shows at roughly its real size, so text on the page matches what people see in the app. `digest-card-menu-10-20-26.png` (1418 px) is the reference.
- **Wider captures shrink.** A 1,972 px users table shows at about 60%, which makes small text hard to read. Narrow the browser so the UI reflows to about 700 px, rather than capturing a wide layout and letting it shrink.
- **Narrower captures get blown up.** A 542 px zoomed-in crop is stretched about 2.4×, so it looks huge and soft. Put small crops on the fixed-width canvas instead of letting them stretch (see Framing).
- **Prefer context over zoom.** For a menu or button, show it inside its card or section (like the digest card with its menu open). Zoom in tighter only when the control would be too small to see in context, such as one icon on a busy page.
- **Tall captures:** a full Settings window with a list is very tall. Usually a Signpost of the top of the page plus the relevant card is enough.

## Capture

- Dark mode, demo org, 2× (Retina). Turn off the internal dev bar.
- Use the region capture (⌘⇧4, then drag). It has no background, so the framing script adds one later. Window capture (⌘⇧4, then Space) includes the desktop wallpaper, so use it only when the whole window is the point. At the current CleanShot setting, window capture adds 240 px of wallpaper on every side at 2× (120 pt), with the window shadow inside that border.
- Set the **viewport** to the size you want, not the window (see the convention above). Chrome's vertical tab sidebar takes about 240 px, so a window 1680 px wide gives a viewport of about 1440 px. Collapse the sidebar while capturing, or account for it. To check the viewport, open the ruler page (https://claude.ai/artifact/9hjDA6WbugYUp5a1N3Z2DX). Inside the artifact viewer it reads the frame's width, which is slightly narrower than the viewport.
- Crop to the thing being explained. Leave out the dimmed backdrop behind dialogs.
- Never scale up.
- Name files `what-it-shows-MM-DD-YY.png`.

## Framing (not decided yet)

The options are compared at https://claude.ai/artifact/2B94ydFuSxPjqeoPv5vZcU. The leading option is a quiet, dimmed aurora background on a fixed-width canvas, so on-page scale stays consistent. Third-party screens like Microsoft or Notion sign-in stay unframed.

## Open items on this branch

- **Digests** (`features/digests.mdx`): done. The new "Manage a digest" section covers the toggle, editing, Run digest and Delete. It uses `digest-card-menu-10-20-26.png`, a rough hand crop to retake at the final capture settings. `edit-digest-10-16-26.png` is no longer used.
