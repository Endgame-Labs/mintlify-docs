// Capture one section of a story at 2x, from a heading down to an end element.
// Usage: node capture-section.cjs <playwright> <storybook-url> <story-id> <width> <heading-text> <end> <out.png>
//   <end> is "table" (the first table after the heading) or "text:<exact text>"
//   (the first element after the heading with that exact text, e.g. a button).
const [, , pwDir, base, id, width, heading, end, out] = process.argv;
const { chromium } = require(pwDir);
const MARGIN = 14; // CSS px of page around the section, per SCREENSHOTS.md

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({
    viewport: { width: Number(width), height: 1200 },
    deviceScaleFactor: 2,
    colorScheme: "dark",
  });
  await page.goto(`${base}/iframe.html?id=${id}&viewMode=story`, { waitUntil: "networkidle" });
  await page.waitForSelector("[data-story-frame] h2, [data-story-frame] h1", { timeout: 20000 });
  await page.evaluate(() => document.fonts.ready);
  // Let data load and any play function (clicks, typing) finish.
  await page.waitForTimeout(3000);
  const box = await page.evaluate(
    ({ text, end }) => {
      const frame = document.querySelector("[data-story-frame]");
      const leaves = [...frame.querySelectorAll("*")].filter((el) => el.children.length === 0);
      const head = leaves.find((el) => el.textContent.trim() === text);
      if (!head) return { error: `heading "${text}" not found` };
      const after = (el) => head.compareDocumentPosition(el) & Node.DOCUMENT_POSITION_FOLLOWING;
      let last;
      if (end === "table") {
        last = [...frame.querySelectorAll("table")].find(after);
      } else {
        const label = end.replace(/^text:/, "");
        last = [...frame.querySelectorAll("*")].find(
          (el) => after(el) && el.textContent.trim() === label && el.getBoundingClientRect().height > 0,
        );
      }
      if (!last) return { error: `end "${end}" not found` };
      const h = head.getBoundingClientRect();
      const l = last.getBoundingClientRect();
      const f = frame.getBoundingClientRect();
      return {
        top: h.top + window.scrollY,
        bottom: l.bottom + window.scrollY,
        // Full content width, so every section crops to the same width.
        left: f.left + 40,
        right: f.right - 40,
      };
    },
    { text: heading, end },
  );
  if (box.error) throw new Error(box.error);
  await page.screenshot({
    path: out,
    fullPage: true,
    clip: {
      x: box.left - MARGIN,
      y: box.top - MARGIN,
      width: box.right - box.left + 2 * MARGIN,
      height: box.bottom - box.top + 2 * MARGIN,
    },
  });
  console.log(out, box);
  await browser.close();
})();
