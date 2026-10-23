# Tutored — multi-surface language-learning SaaS

**Period:** January 2026–Present  
**Ownership:** Founder-led  
**Role:** Founder / platform owner  
**Live:** [tutored.app](https://tutored.app)  

A language tutor that turns chat, a photographed page, or past mistakes into an approved practice set, then remembers what the learner got wrong. Web and mobile share one API. Course authoring is a separate publish pipeline from the learner product.

## Platform

SvelteKit is a same-origin BFF for the **web** (httpOnly cookies, streamed LLM). Fastify is the system of record — auth, plans, quota, speech, and data. **Mobile talks to Fastify directly** with bearer tokens — it does not go through the BFF. Hashed web assets sit on a CDN; SSR stays in-region next to the API.

```mermaid
flowchart LR
  Browser -->|cookie / same origin| BFF[SvelteKit BFF]
  CDN[CDN static] --> Browser
  Mobile[Mobile] -->|bearer| API[Fastify]
  BFF --> API
  API --> PG[(PostgreSQL)]
  API --> Auth[Better Auth]
  API --> Pay[Stripe / plan]
  API -->|LLM STT TTS| AI[AI providers]
```

- **Identity:** Better Auth — email register / verify / reset and Google, one model for web cookie and mobile bearer.  
- **Plans:** Stripe drives `request.plan`; Fastify hooks enforce Free vs Pro and usage quota (LLM / STT / TTS).  
- **Data:** PostgreSQL (Drizzle) for multi-tenant accounts, usage, and learning records.  
- **Ops:** request-correlated logs, product events, metrics; automated backup and restore; CI/CD to Vercel, with data on Supabase.

## Features

- **Practice modes** — Read Aloud (the tutor speaks, the learner answers by voice), Dictation (typed, or a photo of handwriting) and Translation (typed or voice).  
- **Photo to practice** — a photographed page or word list becomes practice items.  
- **Study log** — every session records outcomes, weaknesses and improvement directions.  
- **Four strategies** — ad hoc drills, mistake re-test, paced review on a spaced-repetition schedule, and extended exercises that add new items on the same theme.  
- **Library and learning content** — courses, dictionary, stickers, and a private library of documents, images and videos.  
- **Tutor personas** — a cast of characters with their own families, hobbies and stickers.  
- **Languages and access** — interface in English, Japanese, French and Chinese (Simplified and Traditional); guest mode to try it without an account.  
- **Mobile** — a native client on the same API, in progress.

## Content ops

Curriculum is a publish pipeline, not an in-app CMS.

```text
author packs  →  validate  →  publish  →  catalog / enroll / study
```

A pack is one enrollable SKU (`pack.json` + assets). Studio: React console, Fastify authoring API, Zod schema and CLI. Example series: **NZ School English**.

## Product design

- The tutor **proposes**; the learner **approves** — no silent tool side-effects.  
- Read-aloud grading is a local text diff; TTS is cached. Model spend stays on generation and explanation.  
- Agent tools are allowlisted and owner-scoped. Learner notes are data, not instructions.

## My contribution

- SaaS topology: Fastify API, thin SvelteKit BFF for web, mobile on the same API (not via BFF).  
- Auth, plan, and quota as middleware — not per-handler special cases.  
- Content factory: pack model, validate/publish, catalog sync.  
- Speech and agent path designed so cost and data scope stay bounded.

**Key technologies:** TypeScript, Fastify, SvelteKit, Mobile, PostgreSQL, Better Auth, Stripe, Vercel, Supabase
