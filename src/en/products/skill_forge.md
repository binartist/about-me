# Skill Forge — Agent Skills Registry & Craft Platform

**Period:** Active (ongoing)  
**Ownership:** Founder-led developer platform · **open-source (MIT)**  
**Role:** Founder / platform engineer  

## Introduction

Skill Forge manages how **agent tools and artifacts**—skills, managed instructions, subagents—are stored, installed, and evolved. Substrate:

- **Skills** — reusable task guidance  
- **Managed agent instruction overlays** — Codex, Copilot CLI, Claude Code, Grok, etc.  
- **Managed subagent definitions** for supported tools  

The **repository is the source of truth**. Consumer repos (and `$HOME` for machine-wide skills) declare a profile in `skill-forge.json`; `skf sync` vendors exact copies. Runtime tool directories are **deployment targets**, never the SSOT.

A longer-term arc evaluates agent + artifact performance across SDLC lenses and evolves artifacts from evidence (see product design docs).

## Capabilities (grounded in product README)

- Registry + integrity lock (SHA-256 style package lock)  
- Project and home profile sync (manifest + lock + vendored skills)  
- Compose managed agent instructions (core + tool overlay)  
- Validate registry metadata, skill frontmatter, paths, lock freshness  
- Diff inventory vs runtime without writing; confirm before overwrite  

## My contribution

- Source-of-truth registry model and consumer profile/sync CLI path  
- Multi-tool instruction composition and subagent install targets  
- Validation and lock integrity for agent craft supply chain  
- Design for evaluation-driven evolution of skills (roadmap-aware, not oversold as finished)  

**Key technologies:** Node.js CLI, registry/lock JSON, skill frontmatter, multi-tool runtime install, optional local observability stack (otel/compose)
