# DefectDrainer — Agent harness for product defect fixing

**Period:** 2026–Present  
**Ownership:** Founder-led · **open-source**  
**Role:** Founder / full-stack platform engineer  

## Business problem

Product bugs pile up as screenshots and chat notes while day-to-day work lives in other trackers. Unstructured backlog is hard to triage, unsafe to hand to an AI coding agent on a live checkout, and easy to “resolve” without proof.

DefectDrainer treats defects as a **durable inventory SSOT**, then runs **bounded batch-fix jobs** so coding agents edit only isolated worktrees, attach **fix evidence**, and ship through host **git / PR** actions—not free-form ticket chat.

## Function (one loop)

```
Report → Inventory → Harness (batch job) → Prove → Ship → Close
```

| Stage | Outcome |
|---|---|
| **Report** | Screenshot + notes → structured defect + report evidence (console, HTTP API, or agent) |
| **Inventory** | SQLite SSOT; triage/select by app and severity; no code changes yet |
| **Batch fix** | Coding-agent job on `git worktree`s; branches under `defect-drainer/<BATCH-…>` |
| **Prove** | **fix_evidence** required before resolve |
| **Ship** | Create PR / refresh merge status via host `gh` (merge stays on GitHub) |
| **Close** | Resolve only when fix is evidence-backed |

Product language is **runner-agnostic** (“AI coding agent”, “batch fix job”); the harness owns inventory, gates, and deterministic git/PR ops. The agent is a **worker inside the harness**, not the product.

## Architecture overview

```mermaid
flowchart LR
  subgraph Surfaces
    Console[Operator console]
    API[HTTP API]
  end
  subgraph Inventory
    SQLite[(SQLite SSOT)]
    Evidence[Evidence files]
  end
  subgraph Harness
    Batch[Batch job]
    WT[Git worktrees]
    Agent[Coding agent]
    PR[Create / refresh PRs]
  end
  GH[GitHub]
  Console --> API
  API --> SQLite
  API --> Evidence
  API --> Batch
  Batch --> WT
  Batch --> Agent
  Agent --> WT
  Batch --> PR
  PR -->|gh create / view / list| GH
  GH -->|PR state merge status| PR
  PR --> SQLite
```

| Component | Role |
|---|---|
| **defect-drainer-backend** | Fastify harness API: apps, intake, defects, evidence, batch agent jobs, worktree setup, job logs, Create/Refresh PR |
| **defect-drainer-console** | React + MUI operator UI: report, defects, jobs, evidence |
| **SQLite** | SSOT for apps, defects, batches (`backend/.data/defect-drainer.db`) |
| **evidence/** | Screenshot/binaries on disk; paths in SQLite |
| **Apps registry** | Per product surface; multi-repo URLs; operators select **app** (seeded: Tutored web + mobile) |

**Harness concerns:** workspace isolation (worktrees; primary checkouts not edited), sandbox profiles, BRIEF/handoff payloads, job observability, stop/re-run, fail-closed if worktree setup fails.

**Surfaces (same inventory):** console (day-to-day), HTTP API (scripts / future SDKs), coding agent (may write defects in-schema).

**Planned:** TypeScript / Dart client SDKs; shared chat via sibling **chat-canvas** (MCP into the harness—does not replace it).

## My contribution

- Framed and built the **agent harness** workflow (report → inventory → batch fix → prove → PR → resolve)  
- Fastify backend: SQLite inventory, multi-repo clone/worktree isolation, batch jobs, fix-evidence gates, host PR lifecycle  
- React operator console for report, triage, jobs, and evidence review  
- App-centric multi-repo model so one product surface can span web/mobile/backends  

**Key technologies:** TypeScript, Fastify, React, MUI, SQLite, git worktrees, GitHub CLI (`gh`), Docker-friendly local operator loop  
