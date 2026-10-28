// Capture the open dialog of a story at 2x, dark, with a 14px margin.
// The page behind is hidden so no stray text shows around the dialog.
// Usage: node capture-dialog.cjs <playwright> <storybook-url> <story-id> <width> <out.png>
const [, , pwDir, base, id, width, out] = process.argv;
const { chromium } = require(pwDir);
const MARGIN = 14;
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({
    viewport: { width: Number(width), height: 1000 },
    deviceScaleFactor: 2,
    colorScheme: "dark",
  });
  await page.goto(`${base}/iframe.html?id=${id}&viewMode=story`, { waitUntil: "networkidle" });
  await page.waitForSelector('[role="dialog"][data-state="open"]', { timeout: 20000 });
  await page.evaluate(() => document.fonts.ready);
  await page.waitForTimeout(3000);
  await page.addStyleTag({ content: "[data-story-frame] { visibility: hidden !important; }" });
  const el = page.locator('[role="dialog"][data-state="open"]').last();
  const b = await el.boundingBox();
  await page.screenshot({
    path: out,
    clip: { x: b.x - MARGIN, y: b.y - MARGIN, width: b.width + 2 * MARGIN, height: b.height + 2 * MARGIN },
  });
  console.log(out, b);
  await browser.close();
})();
