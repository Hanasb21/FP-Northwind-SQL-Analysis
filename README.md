# NORTHWIND SQL DATA ANALYSIS

## 📋About the Northwind Database
The **Northwind** dataset is a sample database that represents a fictional specialty foods export-import company. It contains sales transaction data, customer profiles, product inventory, and supplier information. This project aims to extract actionable business insights using complex SQL queries and data exploration techniques.

## 🗺️ Entity-Relationship Diagram (ERD)
The database consists of 13 tables with complex relationships. Understanding these connections is crucial for performing deep-dive joins.
![Entity Relationship Diagram](./images/ER%20Diagram.png)

## 🚀 Business Analysis & Insights
### 1. 💰 Top 5 Products by Revenue
**Question:** Which products generate the highest financial contribution to the company?

<details>
  <summary>🔍 SQL Query</summary>

```sql
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
```

</details>

**Output:**
|product_name|category_name|total_revenue|
|------------|-------------|-------------|
|Côte de Blaye|Beverages|141396.73|
|Thüringer Rostbratwurst|Meat/Poultry|80368.67|
|Raclette Courdavault|Dairy Products|71155.70|
|Tarte au sucre|Confections|47234.97|
|Camembert Pierrot|Dairy Products|46825.48|

**💡 Insight:** 
Côte de Blaye is the superstar product, generating nearly double the revenue of the second-ranked item. Focus on maintaining stock for high-value categories like Beverages and Meat.

### 2. 📦 Top 5 Products by Sales Volume
**Question:** Which products are the most frequently sold in terms of quantity?

<details>
  <summary>🔍 SQL Query</summary>
  
```sql
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
```
</details>

**Output:**
|product_name|category_name|total_quantity_sold|
|------------|-------------|-------------------|
|Camembert Pierrot|Dairy Products|1577|
|Raclette Courdavault|Dairy Products|1496|
|Gorgonzola Telino|Dairy Products|1397|
|Gnocchi di nonna Alice|Grains/Cereals|1263|
|Pavlova|Confections|1158|

**💡 Insight:** 
The Dairy Products category dominates the sales volume, with Camembert Pierrot being the most popular item. High turnover in this category suggests a stable daily demand, making these products essential for maintaining consistent operational cash flow.

### 3. 👥 Top 5 Customers by Revenue
**Question:** Who are our most valuable clients (VVIP)?

<details>
  <summary>🔍 SQL Query</summary>

```sql
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
```
</details>

**Output:**
|company_name|total_revenue|
|------------|-------------|
|QUICK-Stop|110277.30|
|Ernst Handel|104874.98|
|Save-a-lot Markets|104361.95|
|Rattlesnake Canyon Grocery|51097.80|
|Hungry Owl All-Night Grocers|49979.90|

**💡 Insight:** 
The top 3 customers contribute significantly (over $100k each). Maintaining a loyalty program for these "High Spender" accounts is vital for revenue stability.

### 4. 🌍 Customer Geographic Distribution
**Question:** Which countries have the highest concentration of customers?

<details>
  <summary>🔍 SQL Query</summary>

```sql
SELECT 
country,
COUNT(customer_id) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC
LIMIT 5;
```
</details>

**Output:**
|country|total_customers|
|-------|---------------|
|USA|13|
|France|11|
|Germany|11|
|Brazil|9|
|UK|7|

**💡 Insight:** 
The **USA, France, and Germany** are our primary markets. Marketing campaigns should be localized for these regions to maximize engagement.
