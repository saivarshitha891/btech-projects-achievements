-- Flag transactions over $10,000
SELECT * FROM synthetic_transactions
WHERE amount > 10000;

-- Identify customers with frequent withdrawals (e.g., more than 10 withdrawals)
SELECT customer_id, COUNT(*) AS withdrawal_count
FROM synthetic_transactions
WHERE transaction_type = 'withdrawal'
GROUP BY customer_id
HAVING COUNT(*) > 10;

