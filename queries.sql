---Database Eksploration---
SELECT * 
FROM orders 
LIMIT 5;

---List Products & Their Categories---
SELECT 
p.product_name,
c.category_name
FROM products p
JOIN categories c
ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

---Top 5 Products by Revenue---
SELECT 
p.product_name,
c.category_name,
SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY total_revenue DESC
LIMIT 5;

---Top 5 Products by Sales Volume---
SELECT 
p.product_name,
c.category_name,
SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

---Top 5 Customers by Revenue---
SELECT 
c.company_name,
SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY total_revenue DESC
LIMIT 5;

---Top 5 Countries with the Most Costumers---
SELECT 
country,
COUNT(customer_id) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC
LIMIT 5;

---Top 5 Employees Handling the Most Orders---
SELECT 
e.first_name || ' ' || e.last_name AS employee_name,
COUNT(o.order_id) AS total_orders
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY employee_name
ORDER BY total_orders DESC
LIMIT 5;

---Monthly Revenue Trend in 1997---
SELECT 
EXTRACT(MONTH FROM o.order_date) AS month,
SUM(od.quantity * od.unit_price * (1 - od.discount)) AS monthly_revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997
GROUP BY month
ORDER BY month;

---Discount VS Non-Discount Sales Volume--
SELECT 
CASE 
WHEN discount > 0 THEN 'Discounted'
ELSE 'Non-Discounted'
END AS discount_status,
SUM(quantity) AS total_quantity
FROM order_details
GROUP BY discount_status;

---Product Affinity---
SELECT 
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(*) AS times_bought_together
FROM order_details od1
JOIN order_details od2 
    ON od1.order_id = od2.order_id
    AND od1.product_id < od2.product_id
JOIN products p1 
    ON od1.product_id = p1.product_id
JOIN products p2 
    ON od2.product_id = p2.product_id
GROUP BY 
    p1.product_name,
    p2.product_name
ORDER BY 
    times_bought_together DESC
LIMIT 5;