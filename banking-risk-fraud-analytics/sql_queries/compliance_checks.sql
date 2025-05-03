-- Flag transactions over $10,000 (suspicious threshold)
SELECT * FROM synthetic_transactions
WHERE amount > 10000;
