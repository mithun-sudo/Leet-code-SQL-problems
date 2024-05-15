-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

-- The column id is continuous increment.
 

-- Mary wants to change seats for the adjacent students.
 

-- Can you write a SQL query to output the result for Mary?
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+

-- Solution

CREATE TABLE seat (
    id INT PRIMARY KEY,
    student VARCHAR(50)
);

INSERT INTO seat (id, student) VALUES (1, 'Abbot');
INSERT INTO seat (id, student) VALUES (2, 'Doris');
INSERT INTO seat (id, student) VALUES (3, 'Emerson');
INSERT INTO seat (id, student) VALUES (4, 'Green');
INSERT INTO seat (id, student) VALUES (5, 'Jeames');



select 
*
from
(select 
coalesce(case 
when id % 2 = 1 then lead(id) over (order by id asc)
when id % 2 = 0 then lag(id) over (order by id asc) end, id) as seat_no,
student
from seat) A
order by seat_no