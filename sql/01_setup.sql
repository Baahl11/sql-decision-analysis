-- Week 1 setup for SQL Decision Analysis
-- Engine: DuckDB

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id INTEGER,
  order_date DATE,
  customer_id VARCHAR,
  segment VARCHAR,
  channel VARCHAR,
  region VARCHAR,
  category VARCHAR,
  revenue DOUBLE,
  cost DOUBLE,
  discount_pct DOUBLE,
  is_returned INTEGER
);

COPY orders FROM 'data/orders.csv' (AUTO_DETECT TRUE, HEADER TRUE);

SELECT 'orders_loaded' AS check_name, COUNT(*) AS row_count FROM orders;
