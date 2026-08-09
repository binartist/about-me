# about-me (portfolio)

Static portfolio published via **GitHub Pages**:  
https://binartist.github.io/about-me/

## Featured set (locked)

1. **Tutored** — education product  
2. **Olilo** — finance/data product  
3. **Mohiguide** — commerce O2O product (**plan:** fold AIHub GenAI SaaS functions into Mohiguide enrichment)  
4. **DeployBot** — DevOps tooling (**open-source**)  
5. **DefectDrainer** — quality channel tooling (**open-source**)  
6. **Skill Forge** — agent skills platform (**open-source**)  
7. **MapGenie** — enterprise AI delivery (IBM / Maersk)  
8. **KONE Connected Services** — cloud-native IoT ops / migration (IBM / KONE)  
9. **Global e-commerce** — enterprise localization / integration (IBM / Oriflame)  

**Not featured as flagship cards:** AIHub (folded into Mohiguide plan — lineage page only).
## Source of truth

Primary facts for MapGenie, Olilo, Tutored, Mohiguide, DeployBot: private **cv-playground** notes:

`../cv-playground/references/projects/**`  
`../cv-playground/references/professional-experience/**`  
`../cv-playground/references/skills/**`

DefectDrainer and Skill Forge: curated from live repos (`../defect-drainer`, `../skill-forge`) until mirrored into `references/projects/**`.

Rules when editing:

- No over-state, miss-state, or under-state relative to those notes  
- Label ownership: **IBM client delivery** vs **founder-led**  
- Prefer “adopting / under active development / planned” when that is the truth  

## Homepage

**Product-focused catalog:** `index.html` (tabs + tags). Minimal header—no long self-intro.

| Tab | Products |
|---|---|
| **Products** | Tutored, Olilo, Mohiguide |
| **Tooling** | DeployBot, DefectDrainer, Skill Forge |
| **Enterprise** | MapGenie, KONE, Global e-commerce |

Tags (3 types only): **language** · **tech stack** · **business domain**. Domain chips filter the grid.

Edit the `PRODUCTS` array in `index.html` to change cards.

## Build (project detail pages)

```bash
./build.sh
```

Requires `pandoc`. Renders `project-*.md` → HTML only — **does not overwrite `index.html`**.
## Japanese pages

`index-ja.md` / `project-*-ja.*` may lag the English rebase. Prefer English as the current factual baseline until JA is retranslated.

## Deploy

Commit HTML + Markdown on `main`; GitHub Pages serves the repo root for `binartist.github.io/about-me/`.
