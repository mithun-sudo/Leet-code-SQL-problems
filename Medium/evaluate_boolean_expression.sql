-- Table Variables:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | name          | varchar |
-- | value         | int     |
-- +---------------+---------+
-- name is the primary key for this table.
-- This table contains the stored variables and their values.
 

-- Table Expressions:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | left_operand  | varchar |
-- | operator      | enum    |
-- | right_operand | varchar |
-- +---------------+---------+
-- (left_operand, operator, right_operand) is the primary key for this table.
-- This table contains a boolean expression that should be evaluated.
-- operator is an enum that takes one of the values ('<', '>', '=')
-- The values of left_operand and right_operand are guaranteed to be in the Variables table.
 

-- Write an SQL query to evaluate the boolean expressions in Expressions table.

-- Return the result table in any order.

-- The query result format is in the following example.

-- Variables table:
-- +------+-------+
-- | name | value |
-- +------+-------+
-- | x    | 66    |
-- | y    | 77    |
-- +------+-------+

-- Expressions table:
-- +--------------+----------+---------------+
-- | left_operand | operator | right_operand |
-- +--------------+----------+---------------+
-- | x            | >        | y             |
-- | x            | <        | y             |
-- | x            | =        | y             |
-- | y            | >        | x             |
-- | y            | <        | x             |
-- | x            | =        | x             |
-- +--------------+----------+---------------+

-- Result table:
-- +--------------+----------+---------------+-------+
-- | left_operand | operator | right_operand | value |
-- +--------------+----------+---------------+-------+
-- | x            | >        | y             | false |
-- | x            | <        | y             | true  |
-- | x            | =        | y             | false |
-- | y            | >        | x             | true  |
-- | y            | <        | x             | false |
-- | x            | =        | x             | true  |
-- +--------------+----------+---------------+-------+
-- As shown, you need find the value of each boolean exprssion in the table using the variables table.

-- Solution

CREATE TABLE Variables (
    name VARCHAR(50) PRIMARY KEY,
    value INT
);

CREATE TABLE Expressions (
    left_operand VARCHAR(50),
    operator ENUM('<', '>', '='),
    right_operand VARCHAR(50),
    PRIMARY KEY (left_operand, operator, right_operand)
);


-- Insert statements for Variables table
INSERT INTO Variables (name, value) VALUES ('x', 66);
INSERT INTO Variables (name, value) VALUES ('y', 77);

-- Insert statements for Expressions table
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '>', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '<', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('y', '>', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('y', '<', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'x');


select 
B.value as left_value,
operator,
C.value as right_value,
case 
when operator = '>' then B.value > C.value
when operator = '<' then B.value < C.value
when operator = '=' then B.value = C.value
end as flag
from expressions A
inner join variables B 
on
A.left_operand = B.name
inner join variables C 
on
A.right_operand = C.name;