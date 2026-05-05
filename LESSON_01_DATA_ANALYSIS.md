# Lesson 1 - Data Analysis Basics (SQL)

This lesson teaches the first building blocks before advanced SQL.

## Step 1
Goal:
- Understand data size and time coverage.

Command:
- Push-Location sql-decision-analysis
- $duck = if (Get-Command duckdb -ErrorAction SilentlyContinue) { (Get-Command duckdb).Source } elseif (Test-Path '..\\tools\\duckdb\\duckdb.exe') { '..\\tools\\duckdb\\duckdb.exe' } else { '.\\tools\\duckdb\\duckdb.exe' }
- & $duck -ascii -table -header sql_decision_analysis.duckdb -c "select count(*) as total_rows, count(distinct customer_id) as customers, min(order_date) as min_date, max(order_date) as max_date from orders;"
- Pop-Location

Why this matters:
- Before analysis, you must know volume, entity count, and time window.

Expected output:
- total_rows = 40
- customers = 20
- date range around Jan 2026 to Apr 2026

Validation:
- If counts/dates differ, stop and debug before continuing.

## Step 2
Goal:
- Inspect raw rows and understand columns.

Command:
- Push-Location sql-decision-analysis
- & $duck -ascii -table -header sql_decision_analysis.duckdb -c "select * from orders limit 5;"
- Pop-Location

Why this matters:
- Good analysts learn schema semantics before writing complex queries.

Expected output:
- Columns: order_id, order_date, customer_id, segment, channel, region, category, revenue, cost, discount_pct, is_returned

Validation:
- Explain each column in your own words.

## Step 3
Goal:
- Build your first business metric.

Command:
- Push-Location sql-decision-analysis
- & $duck -ascii -table -header sql_decision_analysis.duckdb -c "select round(sum(revenue),2) as total_revenue, round(sum(revenue-cost),2) as total_margin, round(sum(revenue-cost)/nullif(sum(revenue),0),4) as margin_pct from orders;"
- Pop-Location

Why this matters:
- Revenue alone is incomplete. Margin quality is essential.

Expected output:
- total_revenue close to 116650
- total_margin close to 45440
- margin_pct around 0.3895

Validation:
- Be able to explain margin_pct formula without notes.

## Step 4
Goal:
- Compare channel quality.

Command:
- Push-Location sql-decision-analysis
- & $duck -ascii -table -header sql_decision_analysis.duckdb -c "select channel, round(sum(revenue),2) as revenue, round(sum(revenue-cost)/nullif(sum(revenue),0),4) as margin_pct, round(avg(cast(is_returned as double)),4) as return_rate from orders group by 1 order by margin_pct desc;"
- Pop-Location

Why this matters:
- You need multi-metric ranking for decision quality.

Expected output:
- Organic and Referral show strong margin quality.
- Paid Search shows weaker quality and higher return risk.

Validation:
- State one action leadership should take based on this table.

## Step 5
Goal:
- Practice interview explanation.

Prompt:
- In 30 seconds explain: problem, method, finding, impact.

Validation:
- If explanation sounds like SQL syntax only, rewrite in business language.
