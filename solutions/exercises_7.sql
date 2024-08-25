-- 1
SELECT customer_id,
	EXTRACT(MONTH FROM market_date) AS purchase_month,
	EXTRACT(YEAR FROM market_date) AS purchase_year
FROM farmers_market.customer_purchases;

-- 2
SELECT MIN(market_date) AS sales_since_date,
	SUM(quantity * cost_to_customer_per_qty) AS total_sales
FROM farmers_market.customer_purchases
WHERE DATEDIFF('2019-03-31', market_date) <= 14;

-- 2
SELECT MIN(market_date) AS sales_since_date,
SUM(quantity * cost_to_customer_per_qty) AS total_sales
FROM farmers_market.customer_purchases
WHERE DATEDIFF(CURDATE(), market_date) <= 14