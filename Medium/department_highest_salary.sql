-- The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- The Department table holds all departments of the company.

-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+
-- Write a SQL query to find employees who have the highest salary in each of the departments. 
-- For the above tables, your SQL query should return the following rows (order of rows does not matter).

-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- +------------+----------+--------+
-- Explanation:

-- Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

-- Solution

CREATE TABLE Department (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    DepartmentId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
);

-- Insert statements for Department table
INSERT INTO Department (Id, Name) VALUES (1, 'IT');
INSERT INTO Department (Id, Name) VALUES (2, 'Sales');

-- Insert statements for Employee table
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (1, 'Joe', 70000, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (2, 'Jim', 90000, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (3, 'Henry', 80000, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (4, 'Sam', 60000, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId) VALUES (5, 'Max', 90000, 1);


select 
department.name,
B.name, 
salary
from
department 
inner join
(select
*
from
(select 
*,
salary = max(salary) over (partition by departmentid order by salary desc) as flag
from employee) A
where flag is true) B on B.departmentid = department.id 

