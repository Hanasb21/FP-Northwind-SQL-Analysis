---Database Eksploration---
select
	*
from
	orders
limit 5;

---List Products & Their Categories---
select
	p.product_name,
	c.category_name
from
	products p
join categories c
on
	p.category_id = c.category_id
order by
	c.category_name,
	p.product_name;

---1. Top 5 Products by Revenue---
select
	p.product_name,
	c.category_name,
	SUM(od.quantity * od.unit_price * (1 - od.discount)) as total_revenue
from
	order_details od
join products p
on
	od.product_id = p.product_id
join categories c
on
	p.category_id = c.category_id
group by
	p.product_name,
	c.category_name
order by
	total_revenue desc
limit 5;

---2. Top 5 Products by Sales Volume---
select
	p.product_name,
	c.category_name,
	SUM(od.quantity) as total_quantity_sold
from
	order_details od
join products p
on
	od.product_id = p.product_id
join categories c
on
	p.category_id = c.category_id
group by
	p.product_name,
	c.category_name
order by
	total_quantity_sold desc
limit 5;

---3. Top 5 Customers by Revenue---
select
	c.company_name,
	SUM(od.quantity * od.unit_price * (1 - od.discount)) as total_revenue
from
	customers c
join orders o
on
	c.customer_id = o.customer_id
join order_details od
on
	o.order_id = od.order_id
group by
	c.company_name
order by
	total_revenue desc
limit 5;

---4. Top 5 Countries with the Most Costumers---
select
	country,
	COUNT(customer_id) as total_customers
from
	customers
group by
	country
order by
	total_customers desc
limit 5;

---5. Top 5 Employees Handling the Most Orders---
select
	e.first_name || ' ' || e.last_name as employee_name,
	COUNT(o.order_id) as total_orders
from
	employees e
join orders o
on
	e.employee_id = o.employee_id
group by
	employee_name
order by
	total_orders desc
limit 5;

---6. Monthly Revenue Trend in 1997---
select
	extract(month from o.order_date) as month,
	SUM(od.quantity * od.unit_price * (1 - od.discount)) as monthly_revenue
from
	orders o
join order_details od
on
	o.order_id = od.order_id
where
	extract(year from o.order_date) = 1997
group by
	month
order by
	month;

---7. Discount VS Non-Discount Sales Volume--
select
	case
		when discount > 0 then 'Discounted'
		else 'Non-Discounted'
	end as discount_status,
	SUM(quantity) as total_quantity
from
	order_details
group by
	discount_status;

---8. Product Affinity---
select
	p1.product_name as product_1,
	p2.product_name as product_2,
	COUNT(*) as times_bought_together
from
	order_details od1
join order_details od2 
    on
	od1.order_id = od2.order_id
	and od1.product_id < od2.product_id
join products p1 
    on
	od1.product_id = p1.product_id
join products p2 
    on
	od2.product_id = p2.product_id
group by
	p1.product_name,
	p2.product_name
order by
	times_bought_together desc
limit 5;
