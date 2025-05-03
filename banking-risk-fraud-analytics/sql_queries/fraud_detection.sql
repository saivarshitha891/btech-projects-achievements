--Flag unusually large transactions (above 3 standard deviations)
-- Calculate mean and stddev manually and flag unusually large transactions
WITH stats AS (
  SELECT 
    AVG(amount) AS mean_amount, 
    SQRT(SUM((amount - (SELECT AVG(amount) FROM synthetic_transactions)) * (amount - (SELECT AVG(amount) FROM synthetic_transactions))) / COUNT(*)) AS stddev_amount
  FROM synthetic_transactions
)
SELECT * 
FROM synthetic_transactions, stats
WHERE amount > mean_amount + 3 * stddev_amount;


-- Count frauds by transaction type
SELECT transaction_type, COUNT(*) AS fraud_count
FROM synthetic_transactions
WHERE status = 'fraud'
GROUP BY transaction_type;
