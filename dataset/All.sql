-- Getting the total spend of customer
SELECT
customer_id,
customer_name,
SUM(sales) AS total_spend
FROM sales_clean
GROUP BY customer_id, customer_name
ORDER BY total_spend DESC;
-- Getting the Purchase frequency=no of orders
SELECT
customer_id,
customer_name,
count(distinct order_id) AS Purchase_frequency
FROM sales_clean
GROUP BY customer_id, customer_name
ORDER BY Purchase_frequency DESC;
-- Average Order Value (AOV)
SELECT
customer_id,
SUM(sales) AS total_spend,
COUNT(DISTINCT order_id) AS total_orders,
SUM(sales)/COUNT(DISTINCT order_id) AS avg_order_value
FROM sales_clean
GROUP BY customer_id;
-- Using CTE
WITH customer_metrics AS (
SELECT
customer_id,
customer_name,
SUM(sales) AS total_spend,
COUNT(DISTINCT order_id) AS purchase_frequency,
SUM(sales)/COUNT(DISTINCT order_id) AS avg_order_value
FROM sales_clean
GROUP BY customer_id, customer_name
)

SELECT *
FROM customer_metrics
ORDER BY total_spend DESC;
-- Customer Ranking
WITH customer_metrics AS (
SELECT
customer_id,
customer_name,
SUM(sales) AS total_spend
FROM sales_clean
GROUP BY customer_id, customer_name
)

SELECT
customer_id,
customer_name,
total_spend,
RANK() OVER (ORDER BY total_spend DESC) AS customer_rank
FROM customer_metrics;
-- Customer Segmentation (High / Medium / Low)
WITH customer_metrics AS (
SELECT
customer_id,
customer_name,
SUM(sales) AS total_spend
FROM sales_clean
GROUP BY customer_id, customer_name
)

SELECT
customer_id,
customer_name,
total_spend,
CASE
WHEN total_spend > 10000 THEN 'High Value'
WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Medium Value'
ELSE 'Low Value'
END AS customer_segment
FROM customer_metrics;
-- Revenue Contribution (Pareto Analysis)
WITH customer_sales AS (
SELECT
customer_id,
SUM(sales) AS total_spend
FROM sales_clean
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spend,
SUM(total_spend) OVER() AS total_revenue,
SUM(total_spend) OVER(ORDER BY total_spend DESC) AS cumulative_revenue
FROM customer_sales
)

SELECT
customer_id,
total_spend,
cumulative_revenue/total_revenue AS revenue_contribution
FROM ranked_customers;

