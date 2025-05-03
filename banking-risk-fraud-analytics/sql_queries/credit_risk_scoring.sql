-- Simulated credit score logic
SELECT customer_id,
       COUNT(*) AS total_transactions,
       SUM(amount) AS total_spent,
       CASE
         WHEN SUM(amount) > 50000 THEN 'Low Risk'
         WHEN SUM(amount) BETWEEN 20000 AND 50000 THEN 'Medium Risk'
         ELSE 'High Risk'
       END AS credit_risk_score
FROM synthetic_transactions
GROUP BY customer_id;
