
-- DATA CLEANING

-- 1. Total row count
SELECT COUNT(*) AS total_rows FROM synthetic_transactions;

-- 2. Count of duplicate transaction IDs
SELECT COUNT(*) - COUNT(DISTINCT transaction_id) AS duplicate_rows FROM synthetic_transactions;

-- 3. Count of NULLs in key columns
SELECT 
  SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
  SUM(CASE WHEN transaction_type IS NULL THEN 1 ELSE 0 END) AS null_transaction_type,
  SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS null_status
FROM synthetic_transactions;

-- FRAUD DETECTION

-- 4. Total fraud transactions
SELECT COUNT(*) AS total_frauds
FROM synthetic_transactions
WHERE status = 'fraud';

-- 5. Fraud count by transaction type
SELECT transaction_type, COUNT(*) AS fraud_count
FROM synthetic_transactions
WHERE status = 'fraud'
GROUP BY transaction_type;

-- 6. Outlier detection using 3σ method (manual stddev)
WITH stats AS (
  SELECT 
    AVG(amount) AS mean_amount,
    SQRT(SUM((amount - (SELECT AVG(amount) FROM synthetic_transactions)) * 
             (amount - (SELECT AVG(amount) FROM synthetic_transactions))) / COUNT(*)) AS stddev_amount
  FROM synthetic_transactions
)
SELECT COUNT(*) AS outlier_transactions
FROM synthetic_transactions, stats
WHERE amount > mean_amount + 3 * stddev_amount;

-- CUSTOMER SEGMENTATION

-- 7. Customer segmentation by transaction count
SELECT activity_segment, COUNT(*) AS customer_count FROM (
  SELECT customer_id,
         COUNT(*) AS txn_count,
         CASE
           WHEN COUNT(*) > 200 THEN 'High Activity'
           WHEN COUNT(*) BETWEEN 100 AND 200 THEN 'Medium Activity'
           ELSE 'Low Activity'
         END AS activity_segment
  FROM synthetic_transactions
  GROUP BY customer_id
);

-- 8. Customer segmentation by spending
SELECT spending_segment, COUNT(*) AS customer_count FROM (
  SELECT customer_id,
         SUM(amount) AS total_spent,
         CASE
           WHEN SUM(amount) > 50000 THEN 'High Spender'
           WHEN SUM(amount) BETWEEN 20000 AND 50000 THEN 'Medium Spender'
           ELSE 'Low Spender'
         END AS spending_segment
  FROM synthetic_transactions
  GROUP BY customer_id
);

-- CREDIT RISK SCORING

-- 9. Credit risk scoring based on total spend
SELECT credit_risk_score, COUNT(*) AS customer_count FROM (
  SELECT customer_id,
         SUM(amount) AS total_spent,
         CASE
           WHEN SUM(amount) > 50000 THEN 'Low Risk'
           WHEN SUM(amount) BETWEEN 20000 AND 50000 THEN 'Medium Risk'
           ELSE 'High Risk'
         END AS credit_risk_score
  FROM synthetic_transactions
  GROUP BY customer_id
);

-- 10. Credit risk scoring based on fraud history
SELECT fraud_risk_score, COUNT(*) AS customer_count FROM (
  SELECT customer_id,
         COUNT(*) AS fraud_count,
         CASE
           WHEN COUNT(*) > 5 THEN 'High Risk'
           WHEN COUNT(*) BETWEEN 2 AND 5 THEN 'Medium Risk'
           ELSE 'Low Risk'
         END AS fraud_risk_score
  FROM synthetic_transactions
  WHERE status = 'fraud'
  GROUP BY customer_id
);
