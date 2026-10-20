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
| **Signpost** | Where you are or what to look for. A whole page or just part of one. | Only enough to recognise the spot. | A short phrase naming it: "The Connection section of an integration" |
| **State** | How something looks in one condition: empty, filled, connected, error. | The component in that state. | A short phrase naming the state: "A connected integration" |
| **Instruction** | An action hidden behind a click or hover (menu, dropdown, hover button). | The control already open. | An instruction: "Use the ⋮ menu on a digest card to run, edit, or delete it" |

## 3. Capture

All sizes are the **viewport** (the page area, not the browser window) in CSS pixels. Image files are twice that, because we capture at 2× on Retina.

- **Viewport:** set it so the UI you're capturing is about **650–700 px wide**. The docs column is 441–648 px wide and stretches every image to fit, so this width shows at about real size. Reference: `digest-card-menu-10-20-26.png`.
- **Crop:** the subject plus enough of its surroundings to show where it lives, like a menu inside its card. Zoom in tighter only when the subject would be too small to see in context. Leave out the dimmed backdrop behind dialogs.
- **Never scale an image up.**
- **App state:** dark mode, demo org, realistic demo data (never lorem ipsum or real customer data), internal dev bar off.
- **CleanShot:** use region capture (⌘⇧4, then drag). Window capture (⌘⇧4, then Space) adds 240 px of wallpaper on every side, so use it only when the whole window is the point.
- **Chrome:** the vertical tab sidebar takes about 240 px, so window width = viewport + 240. Check the viewport with the ruler: https://claude.ai/artifact/9hjDA6WbugYUp5a1N3Z2DX.

## 4. Highlights

Rarely needed. A good crop usually does the job.

- One per image: an arrow (3 px line) or a rounded outline (2 px). Double both in 2× files.
- Colour **`#b5455d`** (Terminus `red.600`, the red solid background) in light and dark mode.
- No blur, glow, spotlight, dimming or text inside the image.

## 5. Write the text around it

- **Say where, then what:** "On the digest card, click the toggle."
- **Start steps with a verb.** Use a numbered list for three or more steps.
- **UI names** in bold, spelled exactly as they appear in the app.
- **Paths:** **Settings** > **You** > **Digests**, with each name bold and the `>` plain. Never `→`. Always include the group: You, Organization or Developers.
- **Headings** name the task: "Create a digest", not "Digest creation".
- **Tone:** plain and friendly, like a helpful teammate. Not clinical, not cute.
- **Captions** follow the job table. Never say "the image above".
- **Alt text** is always required. Under 155 characters, leading with what the image is there to show.

## 6. Files

- PNG, about 500 KB or less.
- Name: `what-it-shows-MM-DD-YY.png`.
- Hide anything personal with a solid block, not a blur.

## Framing (not decided yet)

The leading option is a dimmed aurora background on a fixed-width canvas. It keeps on-page scale consistent, so small crops don't get stretched. Third-party screens like Microsoft or Notion sign-in stay unframed. Options: https://claude.ai/artifact/2B94ydFuSxPjqeoPv5vZcU. Until this is decided, commit plain captures.

## Open items on this branch

- **Digests** (`features/digests.mdx`): done, except retaking `digest-card-menu-10-20-26.png` (a rough hand crop) at the final capture settings. `edit-digest-10-16-26.png` is no longer used.
- **Paths:** apply the bold `>` path format to every Settings page in the consistency pass.
