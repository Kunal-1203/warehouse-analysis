-- Query 1: Basic Overview
SELECT 
  COUNT(*) AS total_orders,
  COUNT(DISTINCT customer_id) AS unique_customers,
  COUNT(DISTINCT warehouse_id) AS total_warehouses,
  MIN(order_date) AS earliest_order,
  MAX(order_date) AS latest_order
FROM `my-project-1203-492405.warehouse_orders.orders`;

-- Query 2: Total Orders Per Warehouse
SELECT 
  w.warehouse_alias,
  w.state,
  COUNT(o.order_id) AS total_orders
FROM `my-project-1203-492405.warehouse_orders.orders` o
JOIN `my-project-1203-492405.warehouse_orders.warehouse` w
  ON o.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_alias, w.state
ORDER BY total_orders DESC;

-- Query 3: Orders Per State
SELECT 
  w.state,
  COUNT(o.order_id) AS total_orders,
  COUNT(DISTINCT o.customer_id) AS unique_customers
FROM `my-project-1203-492405.warehouse_orders.orders` o
JOIN `my-project-1203-492405.warehouse_orders.warehouse` w
  ON o.warehouse_id = w.warehouse_id
GROUP BY w.state
ORDER BY total_orders DESC;

-- Query 4: Monthly Order Trend
SELECT 
  FORMAT_DATE('%Y-%m', order_date) AS order_month,
  COUNT(order_id) AS total_orders
FROM `my-project-1203-492405.warehouse_orders.orders`
GROUP BY order_month
ORDER BY order_month ASC;

-- Query 5: Average Shipping Time
SELECT 
  ROUND(AVG(DATE_DIFF(shipper_date, order_date, DAY)), 2) AS avg_shipping_days,
  MIN(DATE_DIFF(shipper_date, order_date, DAY)) AS min_days,
  MAX(DATE_DIFF(shipper_date, order_date, DAY)) AS max_days
FROM `my-project-1203-492405.warehouse_orders.orders`
WHERE shipper_date IS NOT NULL 
  AND order_date IS NOT NULL;

-- Query 6: Shipping Time By Warehouse
SELECT 
  w.warehouse_alias,
  w.state,
  ROUND(AVG(DATE_DIFF(o.shipper_date, o.order_date, DAY)), 2) AS avg_shipping_days,
  COUNT(o.order_id) AS total_orders
FROM `my-project-1203-492405.warehouse_orders.orders` o
JOIN `my-project-1203-492405.warehouse_orders.warehouse` w
  ON o.warehouse_id = w.warehouse_id
WHERE o.shipper_date IS NOT NULL
GROUP BY w.warehouse_alias, w.state
ORDER BY avg_shipping_days ASC;

-- Query 7: Warehouse Capacity vs Order Load
SELECT 
  w.warehouse_alias,
  w.state,
  w.maximum_capacity,
  w.employee_total,
  COUNT(o.order_id) AS total_orders,
  ROUND(COUNT(o.order_id) / w.maximum_capacity * 100, 2) AS capacity_utilization_pct
FROM `my-project-1203-492405.warehouse_orders.orders` o
JOIN `my-project-1203-492405.warehouse_orders.warehouse` w
  ON o.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_alias, w.state, w.maximum_capacity, w.employee_total
ORDER BY capacity_utilization_pct DESC;

-- Query 8: Top 10 Customers
SELECT 
  customer_id,
  COUNT(order_id) AS total_orders,
  MIN(order_date) AS first_order,
  MAX(order_date) AS latest_order
FROM `my-project-1203-492405.warehouse_orders.orders`
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- Query 9: Orders By Day Of Week
SELECT 
  FORMAT_DATE('%A', order_date) AS day_of_week,
  COUNT(order_id) AS total_orders
FROM `my-project-1203-492405.warehouse_orders.orders`
GROUP BY day_of_week
ORDER BY total_orders DESC;

-- Query 10: Warehouses Above Average Orders
SELECT 
  w.warehouse_alias,
  w.state,
  COUNT(o.order_id) AS total_orders
FROM `my-project-1203-492405.warehouse_orders.orders` o
JOIN `my-project-1203-492405.warehouse_orders.warehouse` w
  ON o.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_alias, w.state
HAVING COUNT(o.order_id) > (
  SELECT AVG(order_count) 
  FROM (
    SELECT COUNT(order_id) AS order_count 
    FROM `my-project-1203-492405.warehouse_orders.orders`
    GROUP BY warehouse_id
  )
)
ORDER BY total_orders DESC;