# SQL Decision Analysis

Portfolio project for Data Analyst / Data Science interviews.

## Project Goal
Answer one business question with SQL:
How should a subscription business grow revenue without hurting margin quality?

## What This Project Shows
- SQL fundamentals + advanced analytics patterns (CTEs, window functions)
- Business metric framing (revenue, margin, returns, concentration)
- Decision-ready communication (memo + interview script)

## Repository Structure
- data/orders.csv
- sql/01_setup.sql
- sql/02_queries.sql
- analysis/decision-memo.md
- analysis/query-output.txt
- TUTORIAL.md
- EXERCISES.md
- run.ps1

## Quick Start
From repository root:

```powershell
.\run.ps1
```

If DuckDB is not available, install local binary:

```powershell
pwsh -ExecutionPolicy Bypass -File tools/install-duckdb-local.ps1
.\run.ps1
```

## Main Findings (Current Dataset)
- Enterprise + Partner is the strongest absolute margin engine.
- SMB + Paid Search has the highest return risk and weak quality.
- Revenue concentration exists in top customers, so expansion should be balanced with diversification.

## Interview Assets
- Learning walkthrough: TUTORIAL.md
- Deliberate practice: EXERCISES.md
- Executive narrative: analysis/decision-memo.md

## Suggested Interview Pitch (30s)
I built a SQL decision analysis workflow to diagnose growth quality, not just growth volume. I used CTEs and window functions to evaluate trend, channel and segment quality, concentration risk, and discount leakage. The output was a decision memo recommending channel reallocation and discount guardrails backed by quantified evidence.

## Publish Checklist
See PUBLISH_CHECKLIST.md for the exact steps to push this as a standalone GitHub repository.
