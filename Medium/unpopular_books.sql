-- Table: Books

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | book_id        | int     |
-- | name           | varchar |
-- | available_from | date    |
-- +----------------+---------+
-- book_id is the primary key of this table.
-- Table: Orders

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | order_id       | int     |
-- | book_id        | int     |
-- | quantity       | int     |
-- | dispatch_date  | date    |
-- +----------------+---------+
-- order_id is the primary key of this table.
-- book_id is a foreign key to the Books table.
 

-- Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23.

-- The query result format is in the following example:

-- Books table:
-- +---------+--------------------+----------------+
-- | book_id | name               | available_from |
-- +---------+--------------------+----------------+
-- | 1       | "Kalila And Demna" | 2010-01-01     |
-- | 2       | "28 Letters"       | 2012-05-12     |
-- | 3       | "The Hobbit"       | 2019-06-10     |
-- | 4       | "13 Reasons Why"   | 2019-06-01     |
-- | 5       | "The Hunger Games" | 2008-09-21     |
-- +---------+--------------------+----------------+

-- Orders table:
-- +----------+---------+----------+---------------+
-- | order_id | book_id | quantity | dispatch_date |
-- +----------+---------+----------+---------------+
-- | 1        | 1       | 2        | 2018-07-26    |
-- | 2        | 1       | 1        | 2018-11-05    |
-- | 3        | 3       | 8        | 2019-06-11    |
-- | 4        | 4       | 6        | 2019-06-05    |
-- | 5        | 4       | 5        | 2019-06-20    |
-- | 6        | 5       | 9        | 2009-02-02    |
-- | 7        | 5       | 8        | 2010-04-13    |
-- +----------+---------+----------+---------------+

-- Result table:
-- +-----------+--------------------+
-- | book_id   | name               |
-- +-----------+--------------------+
-- | 1         | "Kalila And Demna" |
-- | 2         | "28 Letters"       |
-- | 5         | "The Hunger Games" |
-- +-----------+--------------------+

-- Solution

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    name VARCHAR(255),
    available_from DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    dispatch_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Books (book_id, name, available_from) VALUES (1, 'Kalila And Demna', '2010-01-01');
INSERT INTO Books (book_id, name, available_from) VALUES (2, '28 Letters', '2012-05-12');
INSERT INTO Books (book_id, name, available_from) VALUES (3, 'The Hobbit', '2019-06-10');
INSERT INTO Books (book_id, name, available_from) VALUES (4, '13 Reasons Why', '2019-06-01');
INSERT INTO Books (book_id, name, available_from) VALUES (5, 'The Hunger Games', '2008-09-21');

INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (1, 1, 2, '2018-07-26');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (2, 1, 1, '2018-11-05');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (3, 3, 8, '2019-06-11');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (4, 4, 6, '2019-06-05');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (5, 4, 5, '2019-06-20');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (6, 5, 9, '2009-02-02');
INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES (7, 5, 8, '2010-04-13');


select
book_id, 
name
from books
where 
book_id 
not in
(select 
book_id
from orders
where extract('year' from cast('2019-06-23' as date)) - 1 = extract('year' from cast(dispatch_date as date))
group by book_id
having count(quantity) >= 10)
and available_from < cast('2019-06-23' as date) - 30



