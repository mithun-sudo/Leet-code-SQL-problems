-- The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+
-- The Department table holds all departments of the company.

-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+
-- Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+----------+--------+
-- Explanation:

-- In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, 
-- and Will earns the third highest salary. 
-- There are only two employees in the Sales department, 
-- Henry earns the highest salary while Sam earns the second highest salary.

-- Solution

CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2),
    DepartmentId INT
);

CREATE TABLE Department (
    Id INT,
    Name VARCHAR(50)
);

INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (1, 'Joe', 85000.00, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (2, 'Henry', 80000.00, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (3, 'Sam', 60000.00, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (4, 'Max', 90000.00, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (5, 'Janet', 69000.00, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (6, 'Randy', 85000.00, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (7, 'Will', 70000.00, 1);

INSERT INTO Department (Id, Name) VALUES (1, 'IT');
INSERT INTO Department (Id, Name) VALUES (2, 'Sales');


select
C.name as department_name,
B.name as name
from
(select
departmentid,
name
from
(select
*, 
dense_rank() over (partition by departmentid order by salary desc) as rn
from employee) A
where rn < 4) B
inner join department C on B.departmentid = C.id