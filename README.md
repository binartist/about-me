# about-me (portfolio)

Static portfolio published via **GitHub Pages**:  
https://binartist.github.io/about-me/

The English homepage (`src/en/index.html`) is a short narrative profile of Joe Zhou that links to selected product pages inline. Product detail pages live in `src/en/products/*.md`; the build also generates a product index at `en/products/index.html`.

## Featured set (locked)

1. **Briefed** — AI career agent (founder-led, live at briefed.cv)  
2. **Tutored** — education product  
3. **Sketch Forge** — founder-led native iOS / Swift / SwiftUI iPad client  
4. **Olilo** — finance/data product  
5. **Mohiguide** — commerce O2O product (independent commercial contract)  
6. **Deploybot** — self-hosted deploy & operations platform with an AI-agent gateway (**public repos**)  
7. **Defect Drainer** — quality channel tooling (**open-source**)  
8. **Skill Forge** — agent skills platform (**open-source**)  
9. **MapGenie** — enterprise AI delivery (IBM / Maersk)  
10. **Global e-commerce** — enterprise localization / integration (IBM / Oriflame)  

**Also in the product pages (not in the locked flagship ten):**
- **Cloud Migration: IBM Watson IoT to AWS IoT Platform** — cloud-native IoT ops / migration (IBM / KONE)  
- **Gan Ai Bang (敢爱邦)** — Infiniti China owner app; whole native iOS app in Swift/UIKit, China App Store (independent contract, 2017–2018)  
- **IBM Enterprise OA** — IBM internal pre-sales / office-automation iOS app (2015–2017)  

**Also in the product tree (not a catalog card):** AIHub — GenAI marketing SaaS.
## Source of truth

Primary facts for MapGenie, Olilo, Tutored, Mohiguide, Deploybot, Briefed: private **cv-playground** notes:

`../cv-playground/references/projects/**`  
`../cv-playground/references/professional-experience/**`  
`../cv-playground/references/skills/**`

Defect Drainer and Skill Forge: curated from live repos (`../defect-drainer`, `../skill-forge`) until mirrored into `references/projects/**`.

Authoring workflow and public-page voice: `.agents/skills/about-me-author/SKILL.md`.

Rules when editing:

- No over-state, miss-state, or under-state relative to those notes  
- Label ownership: **IBM client delivery** vs **founder-led** vs **IBM internal**  

## Homepage

**Narrative profile:** `src/en/index.html` — header (Joe Zhou, LinkedIn) plus a few short paragraphs on who Joe is and what he does, linking selected product pages inline. It no longer lists every project as a card.

## Build (product detail pages)

```bash
npm run build
# or: ./scripts/build.sh
```

Requires `pandoc`. Renders `src/{en,ja}/products/*.md` → `dist/.../products/*.html`.  
Catalog: `src/en/index.html` → `dist/en/index.html`.  
Legacy URLs under `…/projects/` get thin meta-refresh redirects to `…/products/`.

## Japanese pages

`src/ja/**` may lag the English rebase. Prefer English as the current factual baseline until JA is retranslated.

## Deploy

`.github/workflows/deploy.yml` runs on push to `main`: it runs `scripts/build.sh` and deploys the built `dist/` to GitHub Pages (`binartist.github.io/about-me/`).
