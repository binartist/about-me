---
name: about-me-author
description: Author and refine the about-me portfolio (GitHub Pages catalog and product pages). Use when the user asks to update about-me, the product catalog, a product brief, portfolio copy, or tabs/cards; or runs /about-me-author.
---

# Skill: Author about-me

Edit the **about-me** repo (this repo, or `../about-me` from cv-playground). Public pages are for **HR and hiring companies**, not internal notes.

Inventory, tabs, and featured-set membership live in the repo `README.md`. Do not duplicate that list here. Read it before adding or retabbing a card.

## Audience and voice

Write as if a recruiter has 20 seconds.

- Present the **mature product architecture** (including the product’s own design-doc target when that is the brief they want on the site).
- Do **not** mention plans, actions, phases, cutovers, or “not shipped yet”.
- Do **not** frame weak or early-stage ops: invite/closed testing, single host, EBS, SQLite WAL, “adopting”, “honesty”, “grounded”, “do not claim”, “folded”, “lineage”, “roadmap”.
- Do **not** compare products to defend identity (“same career as…”, “not a Flutter wrapper”).
- Label ownership: **founder-led** vs **IBM client delivery** vs **IBM internal**.
- Prefer **Mobile** over a framework name (Flutter) on catalog cards and briefs when the surface is the point. Web BFF vs mobile-direct-to-API is worth stating when true.

Facts still have to exist in a source. Do not invent metrics, employers, dates, or awards. You may describe designed platform shape without advertising that it is unfinished.

## Grounding

Read the product’s **live repo** first when the user names one (`../tutored`, `../tutored-ops`, `../defect-drainer`, `../sketch-forge`, `../skill-forge`, `../mohiguide`, …). Then `../cv-playground/references/projects/**` and professional-experience if needed.

No over-state, miss-state, or under-state relative to those sources — except the voice rule above (omit caveats; do not invent).

## Files

| Edit | Path |
|---|---|
| Catalog cards + tabs | `src/en/index.html` (`PRODUCTS` array) |
| Product brief | `src/en/products/<slug>.md` |
| Featured set / tab membership | `README.md` |
| Older long CV page | `src/en/index.md` only if the user still uses it |
| JA | `src/ja/**` only if the user asks; English is the factual baseline |

`dist/` is build output (gitignored). GitHub Pages deploys via `.github/workflows/deploy.yml` on **push to `main`**.

## Product page shape

Keep it short. Typical order:

1. `# Name — one-line identity`
2. Period, ownership, role (bold labels)
3. One paragraph: what it is
4. `## Platform` — mermaid + a few bullets
5. Optional `## How it works` / content pipeline
6. `## My contribution`
7. `**Key technologies:**` one line
8. Optional `## Outcomes` (only sourced numbers)

Use mermaid for architecture. Avoid screenshot galleries unless the user asks.

## Catalog card

```js
{
  id, name, href, blurb, tabs, languages, stack, domain, meta
  // optional: image, imageAlt
}
```

`tabs` is an array. Allowed values: `mobile`, `web`, `cloud`, `ai` (plus implicit All). A product may appear in more than one. Do not restore Customer-facing / SDLC / Enterprise tabs.

The locked featured nine stay unless the user changes membership. Extra catalog cards (e.g. Sketch Forge, IBM OA) are allowed.

## Steps

1. Read `README.md` and the current product page + card.
2. Read the live sibling repo (and cv-playground refs) for the named product.
3. Patch the smallest set of files. Align blurb, tabs, and stack with the brief.
4. `npm run build` in the about-me repo. Confirm the HTML exists.
5. Do not commit or push unless asked. This repo ships from `main` — confirm before committing there.

## Done when

- Page and card match, no plan/caveat wording
- Build succeeded
- You report paths changed and whether GitHub Pages still needs a push
