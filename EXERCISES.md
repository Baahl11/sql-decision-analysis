# SQL Decision Analysis - Exercises

Use this file for deliberate practice after reading `TUTORIAL.md`.

## Guided Exercise 1 - Channel Quality Table
Goal: replicate channel quality logic from memory.

Task:
- Write a query that returns `channel`, `revenue`, `margin`, `margin_pct`, `return_rate`.
- Sort by `margin_pct` descending.

Hints:
- `margin = SUM(revenue - cost)`
- `return_rate = AVG(CAST(is_returned AS DOUBLE))`

Success criteria:
- All five columns are present.
- Values match the baseline output approximately.

## Guided Exercise 2 - Monthly Growth
Goal: practice window functions.

Task:
- Build monthly revenue summary.
- Add previous month revenue with `LAG`.
- Add MoM growth percentage.

Hints:
- First row should have NULL previous value.
- Divide by previous month with `NULLIF` to avoid division by zero.

Success criteria:
- Four rows (Jan-Apr 2026).
- MoM values match baseline trend direction.

## Guided Exercise 3 - Concentration Risk
Goal: calculate running share from top customers.

Task:
- Aggregate revenue by customer.
- Compute cumulative revenue share ordered by highest customer revenue.

Hints:
- Use two window expressions: running sum and total sum.

Success criteria:
- Top customer cumulative share is near 0.12.
- Last row cumulative share equals 1.0.

## Challenge Exercise 1 - Risky Discount Detection
Goal: create a risk alert query.

Task:
- Group by `segment` and `channel`.
- Return only combinations where:
  - average discount > 0.10
  - return rate >= 0.20
- Include `orders`, `avg_discount`, `return_rate`, `margin_pct`.

Expected reasoning:
- Focus on combinations that can destroy margin quality.

## Challenge Exercise 2 - Executive Recommendation Query
Goal: make SQL output decision-ready.

Task:
- Rank channels by a custom quality score:
  - `quality_score = margin_pct - return_rate`
- Return channel, margin_pct, return_rate, quality_score, and rank.

Expected reasoning:
- You are creating a simple decision rule leadership can understand.

## Interview Drill (Mandatory)
After each exercise, answer out loud in under 60 seconds:
1. What business decision does this query support?
2. Why did you choose this SQL pattern?
3. What limitation does this query have?

If you cannot answer all three clearly, repeat the exercise.