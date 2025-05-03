-- 1. Flag unusually large transactions
SELECT * FROM synthetic_transactions
WHERE amount > (
  SELECT AVG(amount) + 3 * STDDEV(amount) FROM synthetic_transactions
);

-- 2. Count of frauds by transaction type
SELECT transaction_type, COUNT(*) AS fraud_count
FROM synthetic_transactions
WHERE status = 'fraud'
GROUP BY transaction_type;
