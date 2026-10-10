-- ===== CREATE TABLES =====
CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT,
  category TEXT,
  price REAL
);

CREATE TABLE shop_customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT,
  city TEXT,
  signup_date TEXT
);

CREATE TABLE shop_orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  product_id INTEGER,
  quantity INTEGER,
  order_date TEXT
);

-- ===== INSERT DATA =====
INSERT INTO products VALUES
(1,'Laptop','Electronics',700),
(2,'Phone','Electronics',450),
(3,'Headphones','Accessories',60),
(4,'Keyboard','Accessories',35),
(5,'Monitor','Electronics',220),
(6,'Mouse','Accessories',20);

INSERT INTO shop_customers VALUES
(1,'Sara','Amman','2024-11-03'),
(2,'Omar','Irbid','2024-12-15'),
(3,'Lina','Amman','2025-01-08'),
(4,'Khaled','Zarqa','2025-01-20'),
(5,'Rami','Amman','2025-02-11'),
(6,'Dana','Aqaba','2025-02-25'),
(7,'Yazan','Irbid','2025-03-02'),
(8,'Hala','Zarqa','2025-03-14');

INSERT INTO shop_orders VALUES
(1,1,1,1,'2025-01-05'),(2,2,3,2,'2025-01-12'),
(3,3,2,1,'2025-01-25'),(4,1,6,3,'2025-02-02'),
(5,4,5,1,'2025-02-10'),(6,5,4,2,'2025-02-18'),
(7,2,2,1,'2025-02-27'),(8,3,3,1,'2025-03-03'),
(9,6,1,1,'2025-03-09'),(10,1,5,2,'2025-03-15'),
(11,7,6,4,'2025-03-20'),(12,4,3,3,'2025-03-28'),
(13,2,4,1,'2025-04-04'),(14,5,2,1,'2025-04-11'),
(15,1,3,2,'2025-04-19'),(16,3,1,1,'2025-04-26');

-- ===== QUESTIONS =====

-- Q1: Total revenue
SELECT SUM(shop_orders.quantity * products.price) AS total_revenue
FROM shop_orders
JOIN products ON shop_orders.product_id = products.product_id;

-- Q2: Revenue by category
SELECT products.category,
       SUM(shop_orders.quantity * products.price) AS revenue
FROM shop_orders
JOIN products ON shop_orders.product_id = products.product_id
GROUP BY products.category;

-- Q3: Top 3 customers by revenue
SELECT shop_customers.name,
       SUM(shop_orders.quantity * products.price) AS revenue
FROM shop_orders
JOIN shop_customers ON shop_orders.customer_id = shop_customers.customer_id
JOIN products ON shop_orders.product_id = products.product_id
GROUP BY shop_customers.name
ORDER BY revenue DESC
LIMIT 3;

-- Q4: Monthly revenue
SELECT strftime('%Y-%m', shop_orders.order_date) AS month,
       SUM(shop_orders.quantity * products.price) AS revenue
FROM shop_orders
JOIN products ON shop_orders.product_id = products.product_id
GROUP BY month
ORDER BY month;

-- Q5: Customers who signed up but never ordered
SELECT shop_customers.name
FROM shop_customers
LEFT JOIN shop_orders ON shop_customers.customer_id = shop_orders.customer_id
WHERE shop_orders.order_id IS NULL;

-- Q6: Best-selling product (by quantity) in each city
WITH city_products AS (
  SELECT shop_customers.city,
         products.product_name,
         SUM(shop_orders.quantity) AS total_qty
  FROM shop_orders
  JOIN shop_customers ON shop_orders.customer_id = shop_customers.customer_id
  JOIN products ON shop_orders.product_id = products.product_id
  GROUP BY shop_customers.city, products.product_name
),
ranked AS (
  SELECT city, product_name, total_qty,
         RANK() OVER (PARTITION BY city ORDER BY total_qty DESC) AS rnk
  FROM city_products
)
SELECT city, product_name, total_qty
FROM ranked
WHERE rnk = 1;

-- Q7: Customers with revenue above average
WITH customer_revenue AS (
  SELECT shop_customers.name,
         SUM(shop_orders.quantity * products.price) AS revenue
  FROM shop_orders
  JOIN shop_customers ON shop_orders.customer_id = shop_customers.customer_id
  JOIN products ON shop_orders.product_id = products.product_id
  GROUP BY shop_customers.name
)
SELECT name, revenue
FROM customer_revenue
WHERE revenue > (SELECT AVG(revenue) FROM customer_revenue)
ORDER BY revenue DESC;

-- Q8: Order size classification
SELECT shop_orders.order_id,
       shop_orders.quantity * products.price AS order_value,
       CASE
         WHEN shop_orders.quantity * products.price >= 500 THEN 'Large'
         WHEN shop_orders.quantity * products.price >= 100 THEN 'Medium'
         ELSE 'Small'
       END AS order_size
FROM shop_orders
JOIN products ON shop_orders.product_id = products.product_id;