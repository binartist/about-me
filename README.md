# about-me (portfolio)

Static portfolio published via **GitHub Pages**:  
https://binartist.github.io/about-me/

## Featured set (locked)

1. **Tutored** — education product  
2. **Olilo** — finance/data product  
3. **Mohiguide** — commerce O2O product  
4. **DeployBot** — DevOps tooling (**open-source**)  
5. **Defect Drainer** — quality channel tooling (**open-source**)  
6. **Skill Forge** — agent skills platform (**open-source**)  
7. **MapGenie** — enterprise AI delivery (IBM / Maersk)  
8. **KONE Connected Services** — cloud-native IoT ops / migration (IBM / KONE)  
9. **Global e-commerce** — enterprise localization / integration (IBM / Oriflame)  

**Also in the catalog (not in the locked flagship nine):**
- **Sketch Forge** — founder-led native iOS / Swift / SwiftUI iPad client for Tutored sticker QA  
- **IBM Internal OA** — IBM internal pre-sales / office-automation iOS app (Swift, UIKit, 2015–2017)  

**Also in the product tree (not a catalog card):** AIHub — GenAI marketing SaaS.
## Source of truth

Primary facts for MapGenie, Olilo, Tutored, Mohiguide, DeployBot: private **cv-playground** notes:

`../cv-playground/references/projects/**`  
`../cv-playground/references/professional-experience/**`  
`../cv-playground/references/skills/**`

Defect Drainer and Skill Forge: curated from live repos (`../defect-drainer`, `../skill-forge`) until mirrored into `references/projects/**`.

Rules when editing:

- No over-state, miss-state, or under-state relative to those notes  
- Label ownership: **IBM client delivery** vs **founder-led**  
- Prefer “adopting / under active development / planned” when that is the truth  

## Homepage

**Product-focused catalog:** `index.html` (tabs + tags). Minimal header—no long self-intro.

| Tab | Items (a product can appear in more than one) |
|---|---|
| **Mobile** | Tutored, Mohiguide, Sketch Forge, Global e-commerce, IBM Internal OA |
| **Web** | Tutored, Olilo, Mohiguide, DeployBot, Defect Drainer, MapGenie, Global e-commerce |
| **Cloud-Native** | Tutored, Olilo, Mohiguide, DeployBot, Defect Drainer, MapGenie, KONE, Global e-commerce |
| **AI** | Tutored, Olilo, DeployBot, Defect Drainer, Skill Forge, Sketch Forge, MapGenie |

Tags (3 types only): **language** · **tech stack** · **business domain**. Domain chips filter the grid.

Edit the `PRODUCTS` array in `index.html` to change cards.

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

Commit HTML + Markdown on `main`; GitHub Pages serves the repo root for `binartist.github.io/about-me/`.
