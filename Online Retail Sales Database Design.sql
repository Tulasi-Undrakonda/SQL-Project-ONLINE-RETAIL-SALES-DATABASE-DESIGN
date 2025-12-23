CREATE DATABASE OnlineRetailSalesDatabaseDesign;
USE OnlineRetailSalesDatabaseDesign;

-- TABLES
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50)
);

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category_id INT NOT NULL,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT uq_order_product UNIQUE (order_id, product_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    shipping_status VARCHAR(30) NOT NULL,
    delivery_date DATE,
    CONSTRAINT fk_shipping_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- INSERT DATA INTO TABLES
INSERT INTO Customers (first_name, last_name, email, phone, address, city) VALUES
('Ravi','Kumar','ravi1@gmail.com','9000000001','MG Road','Bangalore'),
('Anita','Sharma','anita2@gmail.com','9000000002','Andheri East','Mumbai'),
('Suresh','Reddy','suresh3@gmail.com','9000000003','Banjara Hills','Hyderabad'),
('Priya','Singh','priya4@gmail.com','9000000004','Sector 18','Noida'),
('Amit','Verma','amit5@gmail.com','9000000005','Civil Lines','Delhi'),
('Neha','Gupta','neha6@gmail.com','9000000006','Salt Lake','Kolkata'),
('Rahul','Mehta','rahul7@gmail.com','9000000007','Satellite','Ahmedabad'),
('Kiran','Patel','kiran8@gmail.com','9000000008','Alkapuri','Vadodara'),
('Vikas','Jain','vikas9@gmail.com','9000000009','Vijay Nagar','Indore'),
('Pooja','Nair','pooja10@gmail.com','9000000010','Kakkanad','Kochi'),
('Arjun','Iyer','arjun11@gmail.com','9000000011','T Nagar','Chennai'),
('Sneha','Joshi','sneha12@gmail.com','9000000012','Kothrud','Pune'),
('Manoj','Das','manoj13@gmail.com','9000000013','Patia','Bhubaneswar'),
('Deepak','Yadav','deepak14@gmail.com','9000000014','Alambagh','Lucknow'),
('Swati','Kulkarni','swati15@gmail.com','9000000015','Nashik Road','Nashik');

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Sports');

INSERT INTO Products (product_name, price, category_id) VALUES
('Laptop',55000,1),
('Smartphone',25000,1),
('Headphones',1999,1),
('T-Shirt',799,2),
('Jeans',1599,2),
('Jacket',2999,2),
('SQL Book',599,3),
('Java Book',699,3),
('Python Book',749,3),
('Washing Machine',18000,4),
('Microwave Oven',12000,4),
('Refrigerator',28000,4),
('Cricket Bat',2499,5),
('Football',1299,5),
('Badminton Racket',1799,5);

INSERT INTO Inventory (product_id, stock_quantity) VALUES
(1,20),(2,50),(3,100),(4,200),(5,150),
(6,80),(7,60),(8,70),(9,90),(10,25),
(11,40),(12,30),(13,110),(14,130),(15,95);

INSERT INTO Orders (customer_id, order_status) VALUES
(1,'Placed'),(2,'Shipped'),(3,'Delivered'),
(4,'Placed'),(5,'Cancelled'),(6,'Delivered'),
(7,'Shipped'),(8,'Placed'),(9,'Delivered'),
(10,'Placed'),(11,'Delivered'),(12,'Shipped'),
(13,'Placed'),(14,'Delivered'),(15,'Placed');

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1,1,1,55000),(2,2,1,25000),(3,4,2,799),
(4,7,1,599),(5,5,1,1599),(6,10,1,18000),
(7,3,2,1999),(8,6,1,2999),(9,8,1,699),
(10,12,1,28000),(11,9,2,749),(12,14,1,1299),
(13,13,1,2499),(14,15,1,1799),(15,11,1,12000);

INSERT INTO Payments (order_id, payment_method, payment_status) VALUES
(1,'Credit Card','Completed'),
(2,'UPI','Completed'),
(3,'Debit Card','Completed'),
(4,'UPI','Pending'),
(5,'Credit Card','Failed'),
(6,'Net Banking','Completed'),
(7,'UPI','Completed'),
(8,'Cash on Delivery','Pending'),
(9,'Debit Card','Completed'),
(10,'Credit Card','Completed'),
(11,'UPI','Completed'),
(12,'Net Banking','Completed'),
(13,'UPI','Pending'),
(14,'Debit Card','Completed'),
(15,'Cash on Delivery','Pending');

INSERT INTO Shipping (order_id, shipping_address, shipping_status, delivery_date) VALUES
(1,'MG Road, Bangalore','In Transit',NULL),
(2,'Andheri East, Mumbai','Shipped',NULL),
(3,'Banjara Hills, Hyderabad','Delivered','2025-01-10'),
(4,'Sector 18, Noida','Processing',NULL),
(5,'Civil Lines, Delhi','Cancelled',NULL),
(6,'Salt Lake, Kolkata','Delivered','2025-01-08'),
(7,'Satellite, Ahmedabad','In Transit',NULL),
(8,'Alkapuri, Vadodara','Processing',NULL),
(9,'Vijay Nagar, Indore','Delivered','2025-01-09'),
(10,'Kakkanad, Kochi','Shipped',NULL),
(11,'T Nagar, Chennai','Delivered','2025-01-11'),
(12,'Kothrud, Pune','In Transit',NULL),
(13,'Patia, Bhubaneswar','Processing',NULL),
(14,'Alambagh, Lucknow','Delivered','2025-01-12'),
(15,'Nashik Road, Nashik','Processing',NULL);

-- QUERIES
-- 1. Display all customers
SELECT * FROM Customers;

-- 2. Display all products with their category names
SELECT p.product_id, p.product_name, p.price, c.category_name
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;

-- 3. List all orders with customer names
SELECT o.order_id, o.order_date, o.order_status,
       c.first_name, c.last_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- 4.Show order details with products and quantity
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- 5.Find total amount for each order 
SELECT o.order_id,
       SUM(oi.quantity * oi.unit_price) AS total_amount
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- 6.List customers who placed more than one order 
SELECT c.customer_id, c.first_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 1;

-- 7. Show payment status for each order
SELECT o.order_id, p.payment_method, p.payment_status
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id;

-- 8. Find top 5 highest-priced products 
SELECT product_name, price
FROM Products
ORDER BY price DESC
LIMIT 5;

-- 9. Find total sales by category 
SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

-- 10. Find customers who have not placed any orders
SELECT c.customer_id, c.first_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 11. Show delivered orders with delivery date 
SELECT o.order_id, s.delivery_date
FROM Orders o
JOIN Shipping s ON o.order_id = s.order_id
WHERE s.shipping_status = 'Delivered'; 

 -- 12. Find products with low stock (less than 50)
SELECT p.product_name, i.stock_quantity
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
WHERE i.stock_quantity < 50;

 -- 13. Find customers who purchased Electronics 
SELECT DISTINCT c.first_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE p.category_id = (
    SELECT category_id FROM Categories WHERE category_name = 'Electronics'
);

-- 14. Find the most sold product 
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 1;

 -- 15. Calculate average order value 
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT SUM(oi.quantity * oi.unit_price) AS order_total
    FROM Order_Items oi
    GROUP BY oi.order_id
) AS order_totals;

-- JOIN QUERIES FOR SALES REPORTS 
-- 1. Order-wise Sales Report 
SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, c.first_name, c.last_name;

-- 2. Customer-wise Total Sales 
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 3. Product-wise Sales Report 
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 4. Category-wise Sales Report 
SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS category_sales
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.category_name; 

-- 5. Daily Sales Report 
SELECT 
    DATE(o.order_date) AS order_day,
    SUM(oi.quantity * oi.unit_price) AS daily_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY DATE(o.order_date)
ORDER BY order_day;

 -- 6. Payment Status Sales Report 
SELECT 
    p.payment_status,
    SUM(oi.quantity * oi.unit_price) AS total_amount
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY p.payment_status; 

 -- VIEWS FOR SALES REPORTING 
 -- View 1: Order Sales Summary 
 CREATE VIEW vw_order_sales_summary AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, c.customer_id, customer_name; 

SELECT * FROM vw_order_sales_summary; 

-- View 2: Customer Sales Report 
CREATE VIEW vw_customer_sales AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name;

SELECT * FROM vw_customer_sales; 

-- View 3: Product Sales Report 
CREATE VIEW vw_product_sales AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT * FROM vw_product_sales; 

-- View 4: Category Sales Report 
CREATE VIEW vw_category_sales AS
SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

SELECT * FROM vw_category_sales; 

-- View 5: Monthly Sales Report 
CREATE VIEW vw_monthly_sales AS
SELECT 
    YEAR(o.order_date) AS sales_year,
    MONTH(o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date);

SELECT * FROM vw_monthly_sales; 