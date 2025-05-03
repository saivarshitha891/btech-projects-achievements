-- Total fraud transactions
SELECT COUNT(*) AS total_frauds
FROM synthetic_transactions
WHERE status = 'fraud';

-- Fraud count by transaction type
SELECT transaction_type, COUNT(*) AS fraud_count
FROM synthetic_transactions
WHERE status = 'fraud'
GROUP BY transaction_type;

-- Calculate unusually large transactions using 3σ rule (manual stddev)
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
