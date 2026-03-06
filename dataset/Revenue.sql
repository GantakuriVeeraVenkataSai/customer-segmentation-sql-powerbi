-- revenue contribution
SELECT
customer_id,
total_spend,
SUM(total_spend) OVER() AS total_revenue,
total_spend / SUM(total_spend) OVER() AS revenue_contribution
FROM customer_metrics;
show tables;