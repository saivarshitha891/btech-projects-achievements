-- Simulate credit risk score based on total spending
SELECT customer_id,
       SUM(amount) AS total_spent,
       CASE
         WHEN SUM(amount) > 50000 THEN 'Low Risk'
         WHEN SUM(amount) BETWEEN 20000 AND 50000 THEN 'Medium Risk'
         ELSE 'High Risk'
       END AS credit_risk_score
FROM synthetic_transactions
GROUP BY customer_id;

-- Score credit risk based on the frequency of fraud
SELECT customer_id,
       COUNT(*) AS fraud_count,
       CASE
         WHEN COUNT(*) > 5 THEN 'High Risk'
         WHEN COUNT(*) BETWEEN 2 AND 5 THEN 'Medium Risk'
         ELSE 'Low Risk'
       END AS fraud_risk_score
FROM synthetic_transactions
WHERE status = 'fraud'
GROUP BY customer_id;
