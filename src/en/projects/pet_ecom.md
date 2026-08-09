# Mohiguide — Pet Services O2O Platform

**Period:** February 2022–Present  
**Ownership:** Founder-led product  
**Role:** Founder / full-stack product engineer  

## Introduction

Mohiguide is an **online-to-offline (O2O)** platform for the pet services industry: content, shops, events, vouchers, commerce, and engagement. Surfaces include a **Flutter** mobile app, a **SvelteKit** next-generation web channel (replacing legacy Nuxt/Vue), a **React** admin console, and a **Go** microservices backend with a GraphQL BFF pattern.

## Planned function enrichment (AIHub lineage)

**Plan (not claimed as already shipped on Mohiguide):** fold the **GenAI SaaS / agentic workflow** capabilities proven on **AIHub** into Mohiguide as product function enrichment—e.g. brand-aware knowledge, RAG-assisted content, multi-tenant-style governance patterns, and agentic draft → review → publish flows adapted to pet-commerce and ops surfaces.

| | |
|---|---|
| **Today (grounded)** | Multi-surface O2O commerce platform (mobile, web, admin, Go services, AWS) |
| **AIHub (prior / parallel founder work)** | Multi-tenant GenAI marketing SaaS: RAG, agentic workflows, Spring Boot microservices, RBAC/audit/publishing |
| **Direction** | Refactor Mohiguide so those GenAI SaaS functions enrich Mohiguide capabilities rather than remaining a separate public flagship |

Until enrichment lands, do **not** describe Mohiguide as a live multi-tenant marketing GenAI SaaS. Historical AIHub detail remains under [AIHub (folded)](aihub.html) for architecture reference only.

## Architecture (summary)

- **Mobile:** Flutter (iOS/Android) — content, booking, enrollment, payments  
- **Web:** SvelteKit + Vite + Tailwind (`mo-webapp-next` modernization path)  
- **Admin:** React/TypeScript (Redux Toolkit, Apollo GraphQL, MUI, Vite)  
- **Backend:** Go microservices (Gin/gqlgen/gRPC patterns) — users, pets, events, vouchers, orders, messaging, etc.  
- **Deploy:** Docker Compose multi-service stack; AWS EC2 / container services, ALB, CloudFront, S3, CloudWatch, IAM, CDK  
- **CI/CD:** GitHub Actions (incl. path-filtered admin CI); CodeQL and Copilot code review where enabled  
- **Observability direction:** adopting Prometheus & Grafana alongside CloudWatch  

## My contribution

- Flutter mobile delivery and API-backed product flows  
- Web modernization (SvelteKit path) and React admin operations console  
- Go services + GraphQL gateway unifying mobile/web/admin  
- AWS cloud-native operations, Compose deploy definitions, GitHub Actions CI/CD  
- Integrations: Stripe, Firebase messaging, object storage, commerce/content connectors  

**Key technologies:** Flutter, Dart, SvelteKit, React, TypeScript, GraphQL, Golang, MongoDB, Redis, Docker, Compose, nginx, AWS (EC2, Fargate-style workloads, ELB, CloudFront, S3, CloudWatch, IAM, CDK, WAF/SSM patterns, RDS PostgreSQL when required), GitHub Actions, Stripe, Firebase  

## Grounded outcomes (as recorded)

- ~**3×** event capacity without proportional headcount growth  
- Monetization uplift from cross-selling into event participants  
- Clearer service boundaries and more repeatable founder-team releases
