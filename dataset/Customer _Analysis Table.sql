CREATE TABLE customer_analysis AS
SELECT
 customer_id,
customer_name,
SUM(Sales) AS total_spend,
COUNT(DISTINCT Order_Id) AS purchase_frequency,
SUM(Sales) / COUNT(DISTINCT Order_Id) AS avg_order_value,
CASE
    WHEN SUM(Sales) > 10000 THEN 'High Value'
    WHEN SUM(Sales) BETWEEN 5000 AND 10000 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment
FROM sales_dataset
GROUP BY  customer_id,customer_name;