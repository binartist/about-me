# Olilo — SEC 13F portfolio analytics

**Period:** April 2026–Present  
**Ownership:** Founder-led personal product  
**Role:** Founder / full-stack product engineer  

## Introduction

Olilo is a financial data analysis platform that ingests, enriches, and visualizes **SEC Form 13F** institutional holdings filings. Users explore and compare portfolios of major institutional investors by sector allocation, asset concentration, and holdings across reporting quarters.

The platform automates downloading, parsing, and classifying 13F XML from SEC EDGAR; resolves securities via OpenFIGI; classifies into GICS sectors; and serves a REST API consumed by an interactive web app with charts, tables, and **LLM-powered insight reports**.

## Architecture (summary)

- **Data plumber pipeline:** async ETL from SEC EDGAR → OpenFIGI resolution → multi-strategy GICS classification → PostgreSQL upserts (idempotent, concurrent)  
- **API:** FastAPI with session-based OIDC (AWS Cognito), pagination, CSV exports, LLM insight generation  
- **Web:** SvelteKit (Svelte 5), ECharts, Skeleton UI  
- **Deploy:** multi-stage Docker, Compose, Nginx/SWAG reverse proxy with TLS  

## My contribution

Sole developer for architecture, implementation, and deployment:

- Async ETL with concurrent accession processing and GICS resolver chain  
- FastAPI backend, PostgreSQL schema (Alembic migrations), Cognito OIDC  
- SvelteKit frontend with sector/asset visualizations and entity comparison  
- Containerized deploy path with TLS-terminated reverse proxy  

**Key technologies:** Python, FastAPI, SQLAlchemy, Alembic, PostgreSQL, asyncio, SvelteKit, Svelte 5, TypeScript, ECharts, Tailwind, Docker, Nginx, AWS Cognito (OIDC), OpenFIGI API
