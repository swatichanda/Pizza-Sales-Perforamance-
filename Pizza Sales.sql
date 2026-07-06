CREATE TABLE pizza_sales (
    pizza_id INTEGER PRIMARY KEY,
    order_id INTEGER ,
    pizza_name_id TEXT ,
    quantity INTEGER ,
    order_date DATE ,
    order_time TIME ,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(10,2) ,
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name TEXT
);

SELECT * FROM pizza_sales

SET datestyle ='ISO','DMY';

-- Import data with the help of import export option
COPY PIZZA_SALES
FROM'D:/Swati/Power BI/Pizza Sales/pizza_sales.csv'
WITH (FORMAT CSV, HEADER TRUE);

-- KPI
-- 1. TOTAL REVENUE
SELECT SUM(total_price) AS total_revenue 
FROM pizza_sales

-- 2. TOTAL ORDERS
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales

-- 3. AVERAGE ORDER VALUE
SELECT ROUND(ROUND (SUM(total_price),2)/
ROUND (COUNT(DISTINCT order_id),2),2) AS avg_order_value
FROM pizza_sales

--4. TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS total_pizza_sold 
FROM pizza_sales

--5. AVERAGE PIZZAS PER ORDER
SELECT ROUND(ROUND(SUM(quantity),2)/
ROUND(COUNT(DISTINCT order_id),2),2) AS Avg_Pizzas_per_order
FROM pizza_sales;

--ANALYSIS
-- 1. Monthly Trend for Total Revenue
SELECT TO_CHAR (order_date, 'month') AS month,
SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY month;

-- 2. Daily Trend for Total Orders
SELECT TO_CHAR(order_date, 'day') AS daily_trend,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY daily_trend

--3. Percentage of Sales by Pizza Category
SELECT pizza_category, 
ROUND(SUM(total_price),2) AS total_revenue,
ROUND(SUM(total_price)* 100 / (SELECT SUM(total_price)FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_category; 

--4.Percentage of Sales by Pizza Size
SELECT pizza_size, 
ROUND(SUM(total_price),2) AS total_revenue,
ROUND(SUM(total_price)* 100 / (SELECT SUM(total_price)FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 5.Total Pizzas Sold by Pizza Size and Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- 6. Revenue by Pizza Name
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY total_revenue DESC
LIMIT 5;

-- Top & Bottom Analysis
-- 1. Top Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC 
LIMIT 5

-- 2. Bottom Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5

-- 3. Top Pizza by Orders
SELECT pizza_name, COUNT(order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC 
LIMIT 5

-- 4. Bottom Pizza by Orders
SELECT pizza_name, COUNT(order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC 
LIMIT 5

-- 5.Top Pizza by Quantity Sold
SELECT pizza_name, SUM(quantity) AS quantity_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity_sold DESC 
LIMIT 5

-- 6. Bottom Pizza by Quantity Sold
SELECT pizza_name, SUM(quantity) AS quantity_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY quantity_sold ASC
LIMIT 5



















