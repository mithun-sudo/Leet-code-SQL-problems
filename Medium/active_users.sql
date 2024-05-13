-- Table Accounts:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.
 

-- Table Logins:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

-- Write an SQL query to find the id and the name of active users.

-- Active users are those who logged in to their accounts for 5 or more consecutive days.

-- Return the result table ordered by the id.

-- The query result format is in the following example:

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

-- Solution

-- Table definition for Accounts
CREATE TABLE Accounts (
    id INT PRIMARY KEY,
    name VARCHAR
);

-- Insert statements for Accounts
INSERT INTO Accounts (id, name) VALUES
(1, 'Winston'),
(7, 'Jonathan');

-- Table definition for Logins
CREATE TABLE Logins (
    id INT,
    login_date DATE
);

-- Insert statements for Logins
INSERT INTO Logins (id, login_date) VALUES
(7, '2020-05-30'),
(1, '2020-05-30'),
(7, '2020-05-31'),
(7, '2020-06-01'),
(7, '2020-06-02'),
(7, '2020-06-02'),
(7, '2020-06-03'),
(1, '2020-06-07'),
(7, '2020-06-10');


select 
c.id,
name
from 
(select
*,
case when date_difference = lead(date_difference) over (partition by id) then 1 else 0 end as flag
from
(select 
*,
lead(login_date) over (partition by id order by login_date asc) as next_login_date,
(lead(login_date) over (partition by id order by login_date asc)) - login_date as date_difference
from (
	select 
	* 
	from logins
	group by id, login_date
)A)B)C
inner join accounts on C.id = accounts.id
group by c.id, accounts.name
having sum(flag) >= 3
;