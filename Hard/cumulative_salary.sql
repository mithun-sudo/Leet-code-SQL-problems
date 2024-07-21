-- The Employee table holds the salary information in a year.

-- Write a SQL to get the cumulative sum of an employee's salary over a period of 3 months but exclude the most recent month.

-- The result should be displayed by 'Id' ascending, and then by 'Month' descending.

-- Example
-- Input

-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 1  | 1     | 20     |
-- | 2  | 1     | 20     |
-- | 1  | 2     | 30     |
-- | 2  | 2     | 30     |
-- | 3  | 2     | 40     |
-- | 1  | 3     | 40     |
-- | 3  | 3     | 60     |
-- | 1  | 4     | 60     |
-- | 3  | 4     | 70     |
-- Output

-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 1  | 3     | 90     |
-- | 1  | 2     | 50     |
-- | 1  | 1     | 20     |
-- | 2  | 1     | 20     |
-- | 3  | 3     | 100    |
-- | 3  | 2     | 40     |
 

-- Explanation
-- Employee '1' has 3 salary records for the following 3 months except the most recent month '4': salary 40 for month '3', 30 for month '2' and 20 for month '1'
-- So the cumulative sum of salary of this employee over 3 months is 90(40+30+20), 50(30+20) and 20 respectively.

-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 1  | 3     | 90     |
-- | 1  | 2     | 50     |
-- | 1  | 1     | 20     |
-- Employee '2' only has one salary record (month '1') except its most recent month '2'.
-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 2  | 1     | 20     |
 

-- Employ '3' has two salary records except its most recent pay month '4': month '3' with 60 and month '2' with 40. So the cumulative salary is as following.
-- | Id | Month | Salary |
-- |----|-------|--------|
-- | 3  | 3     | 100    |
-- | 3  | 2     | 40     |

-- Solution


CREATE TABLE Employee (
    Id INT,
    Month INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employee (Id, Month, Salary) VALUES (1, 1, 20.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (2, 1, 20.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 2, 30.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (2, 2, 30.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 2, 40.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 3, 40.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 3, 60.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (1, 4, 60.00);
INSERT INTO Employee (Id, Month, Salary) VALUES (3, 4, 70.00);


select
id, 
month,
sum(salary) over (partition by id order by month rows between 2 preceding and 0 following) as cumulative_sum
from
(select
*,
row_number() over (partition by id order by month desc) as rn
from employee) A
where rn != 1
order by id asc, month desc
