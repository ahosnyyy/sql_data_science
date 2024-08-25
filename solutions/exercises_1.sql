-- Exercise 1

-- 1. This query returns everything in the customer table:
SELECT *
FROM farmers_market.customer;

-- 2. This query displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_name:
SELECT *
FROM farmers_market.customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

-- 3. This query lists all customer IDs and first names in the customer table, sorted by first_name:
SELECT
	customer_id,
	customer_first_name
FROM farmers_market.customer
ORDER BY customer_first_name;
