// Capture Storybook stories at 2x for the docs.
// Usage: node capture-stories.cjs <playwright-module-dir> <storybook-url> <out-dir> <width> <story-id>...
const path = require("node:path");
const [, , pwDir, base, outDir, width, ...ids] = process.argv;
const { chromium } = require(pwDir);

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    viewport: { width: Number(width), height: 900 },
    deviceScaleFactor: 2,
    colorScheme: "dark",
  });
  const page = await context.newPage();
  for (const id of ids) {
    await page.goto(`${base}/iframe.html?id=${id}&viewMode=story`, {
      waitUntil: "networkidle",
    });
    // Wait for the page header, then for loading skeletons and spinners to clear.
    await page
      .waitForSelector("#storybook-root h1, #storybook-root h2", { timeout: 20000 })
      .catch(async () => {
        const err = await page.locator(".sb-errordisplay").innerText().catch(() => "");
        console.warn(`${id}: no heading rendered. ${err.slice(0, 600)}`);
      });
    await page
      .waitForFunction(
        () =>
          !document.querySelector(
            '[data-scope="skeleton"], .chakra-skeleton, [data-part="spinner"], [aria-busy="true"]',
          ),
        null,
        { timeout: 10000 },
      )
      .catch(() => console.warn(`${id}: still loading after 10s`));
    await page.evaluate(() => document.fonts.ready);
    // Let any play function (clicks, typing) finish before capturing.
    await page.waitForTimeout(2500);
    const file = path.join(outDir, `${id}.png`);
    // The story's own frame, so short pages don't carry empty canvas below.
    await page.locator("[data-story-frame]").first().screenshot({ path: file });
    console.log(file);
  }
  await browser.close();
})();
