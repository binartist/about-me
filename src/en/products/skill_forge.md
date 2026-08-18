# Skill Forge — Agent skills registry

**Period:** 2026–Present  
**Ownership:** Founder-led · open-source (MIT)  
**Role:** Founder / platform engineer  

Skill Forge is how agent skills, instructions, and subagents are stored, installed, and kept consistent across tools. The registry is the source of truth. Consumer repos (and a home profile) declare what they need; `skf sync` vendors exact copies. Tool runtime folders are install targets, not the system of record.

## Platform

- Registry with an integrity lock (package-lock style)  
- Project and home profile sync  
- Composed instructions for Codex, Copilot CLI, Claude Code, Grok, and similar  
- Managed subagent definitions  
- Validate metadata, paths, and lock freshness; diff before overwrite  

## My contribution

- Registry and lock model  
- Profile sync CLI  
- Multi-tool instruction composition and install targets  
- Validation so agent craft stays reproducible

**Key technologies:** Node.js, CLI, registry/lock JSON, skill frontmatter
