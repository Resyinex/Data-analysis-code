SELECT ROUND(ROUND(SUM(sale_amount))/COUNT(*), 2) AS average -- при использовании * скорость выше
FROM orders;