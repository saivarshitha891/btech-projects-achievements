-- 1. Activity level by transaction count
SELECT customer_id,
       COUNT(*) AS total_transactions,
       CASE
         WHEN COUNT(*) > 200 THEN 'High Activity'
         WHEN COUNT(*) BETWEEN 100 AND 200 THEN 'Medium Activity'
         ELSE 'Low Activity'
       END AS activity_segment
FROM synthetic_transactions
GROUP BY customer_id;

-- Segment customers based on total spending
SELECT customer_id,
       SUM(amount) AS total_spent,
       CASE
         WHEN SUM(amount) > 50000 THEN 'High Spender'
         WHEN SUM(amount) BETWEEN 20000 AND 50000 THEN 'Medium Spender'
         ELSE 'Low Spender'
       END AS spending_segment
FROM synthetic_transactions
GROUP BY customer_id;
