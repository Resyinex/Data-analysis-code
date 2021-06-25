WITH newco AS (
				SELECT country, COUNT(event_type) AS totall 
				FROM events
				GROUP BY country
				),
	inst AS (
				SELECT country, COUNT(event_type) AS installs
				FROM events
				WHERE event_type = 'install'
				GROUP BY country),
	tri AS (
				SELECT country, COUNT(event_type) AS trials
				FROM events
				WHERE event_type = 'trial'
				GROUP BY country),
	pur AS (
				SELECT country, COUNT(event_type) AS purchases
				FROM events
				WHERE event_type = 'purchase'
				GROUP BY country)

SELECT newco.country, inst.installs, tri.trials, pur.purchases, -- newco.totall
((COALESCE(tri.trials, 0) + COALESCE(pur.purchases, 0))*100/newco.totall) AS conversion_rate_on_trial ,
(COALESCE(pur.purchases, 0)*100/newco.totall) AS conversion_rate_to_purchase
FROM newco
LEFT JOIN inst
ON newco.country = inst.country
LEFT JOIN tri 
ON newco.country = tri.country
LEFT JOIN pur
ON newco.country = pur.country
;