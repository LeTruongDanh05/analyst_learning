-- Revenue trends by month - year
SELECT TO_CHAR(o.order_purchase_timestamp, 'MM-YYYY') AS month_year,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(p.payment_value)::NUMERIC, 2) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY month_year
ORDER BY month_year;

-- Analyze actual and projected delivery times by state
SELECT c.customer_state AS customer_state,
COUNT(o.order_id) AS number_of_orders,
ROUND(AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)))::NUMERIC, 1) AS average_delivery_time,
COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END) AS number_of_late_deliveries
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY number_of_late_deliveries DESC;

-- Find the most frequently purchased product categories together
SELECT p1.product_category_name AS product_category_A,
p2.product_category_name AS product_category_B,
COUNT(*) AS number_of_times_purchased_together
FROM olist_order_items_dataset i1
JOIN olist_order_items_dataset i2 ON i1.order_id = i2.order_id AND i1.product_id < i2.product_id
JOIN olist_products_dataset p1 ON i1.product_id = p1.product_id
JOIN olist_products_dataset p2 ON i2.product_id = p2.product_id
WHERE p1.product_category_name IS NOT NULL 
AND p2.product_category_name IS NOT NULL
AND p1.product_category_name <> p2.product_category_name
GROUP BY p1.product_category_name, p2.product_category_name
ORDER BY number_of_times_purchased_together DESC
LIMIT 10;

-- Verify the Pareto Principle for sellers
WITH seller_revenue AS (
    SELECT seller_id, SUM(price) AS total_revenue
    FROM olist_order_items_dataset
    GROUP BY seller_id
),
seller_cum_revenue AS (
    SELECT seller_id, total_revenue, 
        SUM(total_revenue) OVER(ORDER BY total_revenue DESC) AS cumulative_revenue,
        SUM(total_revenue) OVER() AS global_revenue,
        ROW_NUMBER() OVER(ORDER BY total_revenue DESC) AS seller_rank,
        COUNT(*) OVER() AS total_sellers
    FROM seller_revenue
)
SELECT seller_rank, seller_id,
    ROUND(total_revenue::numeric, 2) AS seller_revenue,
    ROUND((cumulative_revenue / global_revenue * 100)::numeric, 2) AS cumulative_revenue_percentage,
    ROUND((seller_rank::numeric / total_sellers * 100)::numeric, 2) AS seller_rank_percentage
FROM seller_cum_revenue
ORDER BY seller_rank
LIMIT 20;

WITH seller_revenue AS (
    SELECT seller_id, SUM(price) AS total_revenue FROM olist_order_items_dataset GROUP BY seller_id
),
seller_cum AS (
    SELECT 
        seller_id,
        SUM(total_revenue) OVER(ORDER BY total_revenue DESC) / SUM(total_revenue) OVER() * 100 AS cum_perc,
        ROW_NUMBER() OVER(ORDER BY total_revenue DESC)::numeric / COUNT(*) OVER() * 100 AS seller_perc
    FROM seller_revenue
)
SELECT 
    ROUND(MIN(seller_perc), 2) AS percentage_of_sellers
FROM seller_cum
WHERE cum_perc >= 80.0; 