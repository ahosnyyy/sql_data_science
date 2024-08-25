-- 1.a
select cp.*,
	DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM farmers_market.customer_purchases AS cp
ORDER BY customer_id, market_date;

-- OR 

select customer_id, market_date,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM farmers_market.customer_purchases
GROUP BY customer_id, market_date
ORDER BY customer_id, market_date;

-- 1.b
SELECT * FROM
(
	select customer_id, market_date,
		ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
	FROM farmers_market.customer_purchases
	GROUP BY customer_id, market_date
	ORDER BY customer_id, market_date
) x
where x.visit_number = 1;

-- OR
SELECT * FROM
(
select cp.*,
	DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
FROM farmers_market.customer_purchases AS cp
ORDER BY customer_id, market_date
) x
where x.visit_number = 1;

-- 2
select cp.*,
	COUNT(product_id) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count
FROM farmers_market.customer_purchases AS cp
ORDER BY customer_id, product_id, market_date;

-- 3
SELECT
	market_date,
	SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales,
	LEAD(SUM(quantity * cost_to_customer_per_qty), 1) OVER (ORDER BY market_date DESC) AS previous_market_date_total_sales
FROM farmers_market.customer_purchases
GROUP BY market_date
ORDER BY market_date
