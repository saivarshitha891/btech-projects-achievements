-- 1. Check for NULLs
SELECT 
  COUNT(*) AS total_rows,
  SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount
FROM synthetic_transactions;

-- 2. Remove duplicates if any
DELETE FROM synthetic_transactions
WHERE transaction_id IN (
  SELECT transaction_id
  FROM (
    SELECT transaction_id, COUNT(*) 
    FROM synthetic_transactions
    GROUP BY transaction_id
    HAVING COUNT(*) > 1
  )
);
