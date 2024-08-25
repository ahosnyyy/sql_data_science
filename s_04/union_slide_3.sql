WITH product_quantity_by_date AS (
    SELECT
        vi.market_date,
        vi.product_id,
        p.product_name,
        SUM(vi.quantity) AS total_quantity_available,
        p.product_qty_type
    FROM
        farmers_market.vendor_inventory vi
    LEFT JOIN
        farmers_market.product p ON vi.product_id = p.product_id
    GROUP BY
        vi.market_date, vi.product_id, p.product_name, p.product_qty_type
)

SELECT
    market_date,
    product_id,
    product_name,
    total_quantity_available,
    product_qty_type
FROM (
    SELECT
        market_date,
        product_id,
        product_name,
        total_quantity_available,
        product_qty_type,
        RANK() OVER (PARTITION BY market_date ORDER BY total_quantity_available DESC) AS quantity_rank
    FROM
        product_quantity_by_date
    WHERE
        product_qty_type = 'unit'

    UNION ALL

    SELECT
        market_date,
        product_id,
        product_name,
        total_quantity_available,
        product_qty_type,
        RANK() OVER (PARTITION BY market_date ORDER BY total_quantity_available DESC) AS quantity_rank
    FROM
        product_quantity_by_date
    WHERE
        product_qty_type = 'lbs'
) ranked_products
WHERE
    ranked_products.quantity_rank = 1
ORDER BY
    market_date;
