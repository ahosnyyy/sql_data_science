-- Exercise 2

-- 1. Query that returns all customer purchases of product IDs 4 and 9:
SELECT *
FROM farmers_market.customer_purchases
WHERE product_id = 4
OR product_id = 9;

-- 2. BETWEEN vs. Two conditions:
SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id >= 8
AND vendor_id <= 10;

SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

-- 3. Ways to return purchases from days when it wasn’t raining:
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE
	market_date NOT IN
		(
		SELECT market_date
		FROM farmers_market.market_date_info
		WHERE market_rain_flag = 1
		);
        
-- Another way
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE
	market_date IN
		(
		SELECT market_date
		FROM farmers_market.market_date_info
		WHERE market_rain_flag = 0
		);