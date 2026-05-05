-- Week 1 SQL analysis queries
-- Engine: DuckDB

-- Q1. Monthly revenue and margin trend
SELECT
  date_trunc('month', order_date) AS month,
  ROUND(SUM(revenue), 2) AS total_revenue,
  ROUND(SUM(revenue - cost), 2) AS total_margin,
  ROUND(SUM(revenue - cost) / NULLIF(SUM(revenue), 0), 4) AS margin_pct
FROM orders
GROUP BY 1
ORDER BY 1;

-- Q2. Month over month revenue growth (window function)
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) AS month,
    SUM(revenue) AS revenue
  FROM orders
  GROUP BY 1
)
SELECT
  month,
  ROUND(revenue, 2) AS revenue,
  ROUND(LAG(revenue) OVER (ORDER BY month), 2) AS prev_month_revenue,
  ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 4) AS mom_growth_pct
FROM monthly
ORDER BY month;

-- Q3. Segment performance snapshot
SELECT
  segment,
  ROUND(SUM(revenue), 2) AS revenue,
  ROUND(SUM(revenue - cost), 2) AS margin,
  ROUND(AVG(discount_pct), 4) AS avg_discount,
  ROUND(AVG(CAST(is_returned AS DOUBLE)), 4) AS return_rate
FROM orders
GROUP BY 1
ORDER BY revenue DESC;

-- Q4. Channel efficiency and return risk
SELECT
  channel,
  ROUND(SUM(revenue), 2) AS revenue,
  ROUND(SUM(revenue - cost), 2) AS margin,
  ROUND(SUM(revenue - cost) / NULLIF(SUM(revenue), 0), 4) AS margin_pct,
  ROUND(AVG(CAST(is_returned AS DOUBLE)), 4) AS return_rate
FROM orders
GROUP BY 1
ORDER BY margin_pct DESC;

-- Q5. Top categories by region (window function)
WITH region_category AS (
  SELECT
    region,
    category,
    SUM(revenue) AS revenue,
    SUM(revenue - cost) AS margin
  FROM orders
  GROUP BY 1, 2
), ranked AS (
  SELECT
    region,
    category,
    revenue,
    margin,
    ROW_NUMBER() OVER (PARTITION BY region ORDER BY margin DESC) AS rn
  FROM region_category
)
SELECT
  region,
  category,
  ROUND(revenue, 2) AS revenue,
  ROUND(margin, 2) AS margin
FROM ranked
WHERE rn <= 2
ORDER BY region, margin DESC;

-- Q6. Revenue concentration by customer (80/20 style)
WITH customer_revenue AS (
  SELECT
    customer_id,
    SUM(revenue) AS revenue
  FROM orders
  GROUP BY 1
), cumulative AS (
  SELECT
    customer_id,
    revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue,
    SUM(revenue) OVER () AS total_revenue
  FROM customer_revenue
)
SELECT
  customer_id,
  ROUND(revenue, 2) AS revenue,
  ROUND(cumulative_revenue / NULLIF(total_revenue, 0), 4) AS cumulative_revenue_share
FROM cumulative
ORDER BY revenue DESC;

-- Q7. Repeat customer behavior
WITH monthly_orders AS (
  SELECT
    customer_id,
    COUNT(DISTINCT date_trunc('month', order_date)) AS active_months,
    SUM(revenue) AS lifetime_revenue
  FROM orders
  GROUP BY 1
)
SELECT
  CASE
    WHEN active_months >= 3 THEN 'high_repeat'
    WHEN active_months = 2 THEN 'medium_repeat'
    ELSE 'low_repeat'
  END AS repeat_band,
  COUNT(*) AS customers,
  ROUND(AVG(lifetime_revenue), 2) AS avg_lifetime_revenue
FROM monthly_orders
GROUP BY 1
ORDER BY avg_lifetime_revenue DESC;

-- Q8. Discount policy impact on profitability
SELECT
  CASE
    WHEN discount_pct <= 0.05 THEN '0_to_5_pct'
    WHEN discount_pct <= 0.10 THEN '5_to_10_pct'
    WHEN discount_pct <= 0.15 THEN '10_to_15_pct'
    ELSE 'over_15_pct'
  END AS discount_band,
  COUNT(*) AS orders,
  ROUND(AVG(revenue), 2) AS avg_revenue,
  ROUND(AVG(revenue - cost), 2) AS avg_margin,
  ROUND(AVG((revenue - cost) / NULLIF(revenue, 0)), 4) AS avg_margin_pct,
  ROUND(AVG(CAST(is_returned AS DOUBLE)), 4) AS return_rate
FROM orders
GROUP BY 1
ORDER BY 1;

-- Q9. Segment + channel combinations with weak quality
SELECT
  segment,
  channel,
  COUNT(*) AS orders,
  ROUND(SUM(revenue), 2) AS revenue,
  ROUND(SUM(revenue - cost) / NULLIF(SUM(revenue), 0), 4) AS margin_pct,
  ROUND(AVG(CAST(is_returned AS DOUBLE)), 4) AS return_rate
FROM orders
GROUP BY 1, 2
HAVING COUNT(*) >= 2
ORDER BY return_rate DESC, margin_pct ASC;

-- Q10. Two-month moving average baseline (window function)
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) AS month,
    SUM(revenue) AS revenue
  FROM orders
  GROUP BY 1
)
SELECT
  month,
  ROUND(revenue, 2) AS revenue,
  ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 1 PRECEDING AND CURRENT ROW), 2) AS moving_avg_2m
FROM monthly
ORDER BY month;
