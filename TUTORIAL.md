# SQL Decision Analysis - Step by Step Tutorial

This guide teaches the Week 1 project as a learning path, not only as a final deliverable.

## Learning Goals
By the end of this tutorial you should be able to:
- Build a clean order-level dataset in DuckDB.
- Use CTEs and window functions for trend analysis.
- Diagnose margin and return risk by segment and channel.
- Convert SQL output into business recommendations.
- Explain your technical decisions in interview format.

## Prerequisites
- Basic SQL: SELECT, WHERE, GROUP BY, ORDER BY.
- Basic business metrics: revenue, margin, return rate.
- PowerShell basics.

## Project Files
- `data/orders.csv`
- `sql/01_setup.sql`
- `sql/02_queries.sql`
- `analysis/decision-memo.md`
- `analysis/query-output.txt`
- `EXERCISES.md`

## Lesson 0 - Run the Project End to End
### Why this matters
Before editing queries, verify baseline reproducibility.

### Run
From repo root:
```powershell
.\run.ps1
```

### Validate
- You should see `orders_loaded` with 40 rows.
- Output should be saved at `analysis/query-output.txt`.

### Interview line
"First I made sure the analysis was reproducible end-to-end, then I iterated query logic."

## Lesson 1 - Understand the Business Question
### Goal
Frame SQL work around decisions, not around syntax.

### Question
"How should we grow revenue while protecting margin and reducing return leakage?"

### Output needed
- Trend by month
- Segment and channel quality
- Concentration risk
- Discount risk

### Interview line
"I designed each query to answer one decision, not to show random SQL features."

## Lesson 2 - Inspect Data Model and Load Logic
### Goal
Understand each column before analysis.

### Key columns
- `revenue`, `cost`: gross economics.
- `discount_pct`: pricing pressure.
- `is_returned`: quality/risk signal.
- `segment`, `channel`: allocation decisions.

### What to check
Open `sql/01_setup.sql` and explain:
- table schema
- CSV load command
- row count validation

### Interview line
"I validated schema assumptions first so downstream metrics were trustworthy."

## Lesson 3 - Trend Query (Aggregation)
### Goal
Measure baseline business trajectory.

### Query block
`Q1` in `sql/02_queries.sql`

### Learn
- `date_trunc('month', order_date)`
- Margin formula: `revenue - cost`
- Margin percent: `SUM(margin)/SUM(revenue)`

### Ask yourself
- Is revenue increasing?
- Is margin percent improving or degrading?

### Interview line
"Revenue grew, but margin percent softened, so growth quality needed investigation."

## Lesson 4 - MoM Growth (Window Function)
### Goal
Quantify acceleration/slowdown month to month.

### Query block
`Q2` in `sql/02_queries.sql`

### Learn
- `LAG(revenue) OVER (ORDER BY month)`
- MoM growth formula

### Ask yourself
- Which month slowed down and why?
- Did growth recover later?

### Interview line
"I used LAG to detect growth deceleration and avoid judging trend from raw totals only."

## Lesson 5 - Segment and Channel Quality
### Goal
Find where the business wins or leaks value.

### Query blocks
- `Q3` segment snapshot
- `Q4` channel efficiency

### Learn
- Revenue is not enough; compare margin and return rate together.
- A channel can be high volume but low quality.

### Ask yourself
- Which segment deserves more investment?
- Which channel requires controls?

### Interview line
"I compared volume, margin, and returns together to avoid single-metric decisions."

## Lesson 6 - Regional and Category Priorities
### Goal
Find local product opportunities.

### Query block
`Q5` top categories per region using ranking.

### Learn
- CTE for intermediate aggregation.
- `ROW_NUMBER() OVER (PARTITION BY region ORDER BY margin DESC)`.

### Ask yourself
- Which category should each region prioritize?

### Interview line
"I ranked category performance per region to support localized GTM decisions."

## Lesson 7 - Concentration and Retention Risk
### Goal
Evaluate dependency on top customers.

### Query blocks
- `Q6` cumulative revenue share.
- `Q7` repeat behavior bands.

### Learn
- Running totals with windows.
- Risk framing beyond short-term growth.

### Ask yourself
- How much revenue depends on top accounts?
- Is repeat behavior healthy?

### Interview line
"I identified concentration risk early so leadership could balance expansion and diversification."

## Lesson 8 - Pricing and Return Leakage
### Goal
Assess discount policy quality.

### Query blocks
- `Q8` discount band analysis.
- `Q9` weak segment-channel combinations.

### Learn
- Banding logic with CASE.
- High discount + high return can destroy margin quality.

### Ask yourself
- Which discount bands are unsafe?
- Where should discount guardrails be added?

### Interview line
"I used discount bands to translate SQL findings into concrete pricing guardrails."

## Lesson 9 - Forecast Baseline for Planning
### Goal
Create a planning baseline without overfitting.

### Query block
`Q10` two-month moving average.

### Learn
- Simple moving average with window frames.
- Communicate baseline vs. prediction limitations.

### Interview line
"I used a simple baseline for planning and documented limitations before proposing complex models."

## Lesson 10 - Convert Analysis to Executive Narrative
### Goal
Translate technical output into decisions.

### Steps
1. Open `analysis/query-output.txt`.
2. Select 3 insights with numeric evidence.
3. Update `analysis/decision-memo.md` in this order:
   - Problem
   - Method
   - Findings
   - Recommended Actions
   - Expected Business Impact

### Interview line
"I finished by converting analysis into decision-ready actions with quantified trade-offs."

## Practice Path
Use `EXERCISES.md`:
- Guided practice first.
- Challenge section second.
- Explain your answer out loud after each exercise.

## Mastery Checklist
You are ready for interviews when you can:
- Rebuild this project from zero in under 90 minutes.
- Explain every window function in plain language.
- Defend one trade-off decision from the memo.
- Deliver 30-second and 2-minute project explanations.

## Next Step
After mastery, mirror this starter as a standalone public repo named `sql-decision-analysis` and keep this tutorial as its learning section.