WITH row_num AS (
				SELECT sale_amount, row_number() OVER (ORDER BY sale_amount) AS r_n
				FROM orders
				),
     row_cnt AS (
		 		SELECT count(*) AS r_c
		 		FROM row_num
	 			)
SELECT CASE WHEN row_cnt.r_c%2 = 0 
			THEN
				(ROUND((
				(SELECT sale_amount
				 FROM row_num
				 WHERE row_num.r_n = (row_cnt.r_c/2)) 
				+ 
				(SELECT sale_amount
				 FROM row_num
				 WHERE row_num.r_n = (row_cnt.r_c/2+1)))
				/2, 2)
				)
			ELSE
				(SELECT sale_amount
				 FROM row_num
				 WHERE row_num.r_n = FLOOR(row_cnt.r_c/2)
				)
			END
FROM row_cnt;