SELECT transaction_id, datetime, amount, user_id, COUNT(*) AS repited 
FROM purchases
GROUP BY transaction_id, datetime, amount, user_id
HAVING COUNT(*)>1
ORDER BY transaction_id
;