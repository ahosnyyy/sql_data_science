-- Exercise 4

-- 1. INNER JOINs the vendor table to the vendor_booth_assignments table:
SELECT *
FROM vendor AS v
	INNER JOIN vendor_booth_assignments AS vba
		ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date;

-- 2. LEFT JOIN to produce output identical to the output of this exercise’s query:
SELECT c.*, cp.*
FROM customer_purchases AS cp
	LEFT JOIN customer AS c
		ON cp.customer_id = c.customer_id;