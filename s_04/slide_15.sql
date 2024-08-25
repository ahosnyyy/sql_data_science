WITH
customer_markets_attended AS
(
SELECT DISTINCT
	customer_id,
	market_date,
	MIN(market_date) OVER(PARTITION BY cp.customer_id) AS first_purchase_date
FROM farmers_market.customer_purchases cp
)
SELECT
	md.market_year,
	md.market_week,
	COUNT(customer_id) AS customer_visit_count,
	COUNT(DISTINCT customer_id) AS distinct_customer_count,
	COUNT(DISTINCT
		CASE WHEN cma.market_date = cma.first_purchase_date
		THEN customer_id
		ELSE NULL
	END) AS new_customer_count,
	COUNT(DISTINCT
		CASE WHEN cma.market_date = cma.first_purchase_date
		THEN customer_id
		ELSE NULL
		END)
	/ COUNT(DISTINCT customer_id)
	AS new_customer_percent
FROM customer_markets_attended AS cma
LEFT JOIN farmers_market.market_date_info AS md
	ON cma.market_date = md.market_date
GROUP BY md.market_year, md.market_week
ORDER BY md.market_year, md.market_week