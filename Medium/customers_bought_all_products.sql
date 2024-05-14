-- Table: Customer

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- product_key is a foreign key to Product table.
-- Table: Product

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key column for this table.
 

-- Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.

-- For example:

-- Customer table:
-- +-------------+-------------+
-- | customer_id | product_key |
-- +-------------+-------------+
-- | 1           | 5           |
-- | 2           | 6           |
-- | 3           | 5           |
-- | 3           | 6           |
-- | 1           | 6           |
-- +-------------+-------------+

-- Product table:
-- +-------------+
-- | product_key |
-- +-------------+
-- | 5           |
-- | 6           |
-- +-------------+

-- Result table:
-- +-------------+
-- | customer_id |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+
-- The customers who bought all the products (5 and 6) are customers with id 1 and 3.

-- Solution


CREATE TABLE Product (
    product_key INT PRIMARY KEY
);

CREATE TABLE Customer (
    customer_id INT,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES Product(product_key)
);

-- Insert statements for Product table
INSERT INTO Product (product_key) VALUES (5);
INSERT INTO Product (product_key) VALUES (6);

-- Insert statements for Customer table
INSERT INTO Customer (customer_id, product_key) VALUES (1, 5);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 6);
INSERT INTO Customer (customer_id, product_key) VALUES (3, 5);
INSERT INTO Customer (customer_id, product_key) VALUES (3, 6);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 6);

select
customer_id
from
(select
customer_id,
count(distinct product_key) = (select count(*) from product) as flag
from
customer
group by 
customer_id) A
where flag is true


