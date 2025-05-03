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
