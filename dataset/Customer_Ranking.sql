-- customer ranking
SELECT
customer_id,
customer_name,
total_spend,
RANK() OVER (ORDER BY total_spend DESC) AS revenue_rank
FROM customer_analysis;