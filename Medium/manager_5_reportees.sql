-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

-- +------+----------+-----------+----------+
-- |Id    |Name 	  |Department |ManagerId |
-- +------+----------+-----------+----------+
-- |101   |John 	  |A 	      |null      |
-- |102   |Dan 	  |A 	      |101       |
-- |103   |James 	  |A 	      |101       |
-- |104   |Amy 	  |A 	      |101       |
-- |105   |Anne 	  |A 	      |101       |
-- |106   |Ron 	  |B 	      |101       |
-- +------+----------+-----------+----------+
-- Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

-- +-------+
-- | Name  |
-- +-------+
-- | John  |
-- +-------+
-- Note:
-- No one would report to himself.

-- Solution


CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Department VARCHAR(255),
    ManagerId INT,
    FOREIGN KEY (ManagerId) REFERENCES Employee(Id)
);

INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (101, 'John', 'A', NULL);
INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (102, 'Dan', 'A', 101);
INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (103, 'James', 'A', 101);
INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (104, 'Amy', 'A', 101);
INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (105, 'Anne', 'A', 101);
INSERT INTO Employee (Id, Name, Department, ManagerId) VALUES (106, 'Ron', 'B', 101);


select
name
from employee e1
where
(select count(*) from employee e2 where e2.managerid = e1.id) >= 5 