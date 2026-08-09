# DefectDrainer — Defect Inventory & Channel

**Period:** 2026–Present (active / planned)  
**Ownership:** Founder-led platform tooling · **open-source**  
**Role:** Founder / full-stack platform engineer  

## Introduction

DefectDrainer is an umbrella workspace for **defect inventory + channel**, designed as a sibling to product workspaces (e.g. Tutored). The model is deliberate:

1. **Collect first** — screenshot + comment (console today; SDK later)  
2. Store structured defect records  
3. **Batch-fix later** — not live work-tracking chaos  

It is a **quality channel and inventory**, not a full Jira replacement or public end-user app store product.

## Architecture (current)

| Component | Role |
|---|---|
| `backend/` (defect-drainer-backend) | Fastify API — intake, normalize, CRUD, evidence HTTP (~:8788) |
| `console/` (defect-drainer-console) | React + MUI operator UI — report, status, evidence (~:5173) |
| Inventory SSOT | `open/` · `resolved/` · `evidence/` · `batches/` + structured `DEF-*.md` |
| App registry | Product apps registered for multi-product intake (seeded with Tutored) |

**Planned extensions:** TypeScript / Dart SDKs for in-product capture.

## My contribution

- Designed inventory-first quality channel (collect → structure → batch)  
- Built Fastify intake/normalize API and React operator console  
- Multi-app registry so defects bind to product `app_id`  
- Evidence and batch layout for deferred fix waves  

**Key technologies:** TypeScript, Fastify, React, MUI, structured Markdown inventory, local operator deploy
