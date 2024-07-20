-- A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
 

-- | name   | continent |
-- |--------|-----------|
-- | Jack   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jane   | America   |
 

-- Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
 

-- For the sample input, the output is:
 

-- | America | Asia | Europe |
-- |---------|------|--------|
-- | Jack    | Xi   | Pascal |
-- | Jane    |      |        |

-- Solution

CREATE TABLE student (
    name VARCHAR(50),
    continent VARCHAR(50)
);

INSERT INTO student (name, continent) VALUES ('Jack', 'America');
INSERT INTO student (name, continent) VALUES ('Pascal', 'Europe');
INSERT INTO student (name, continent) VALUES ('Xi', 'Asia');
INSERT INTO student (name, continent) VALUES ('Jane', 'America');


with 
america as (select row_number() over (order by name asc) as rn, name as America from student where continent = 'America'),
Europe as (select row_number() over (order by name asc) as rn, name as Europe from student where continent = 'Europe'),
Asia as (select row_number() over (order by name asc) as rn, name as Asia from student where continent = 'Asia')
select 
A.America,
B.Europe,
C.Asia
from America A
full outer join Europe B on A.rn = B.rn
full outer join Asia C on A.rn = C.rn

select
min(case when continent = 'America' then name else NULL end) as america,
min(case when continent = 'Asia' then name else NULL end) as Asia,
min(case when continent = 'Europe' then name else NULL end) as Europe
from
(select
*, 
row_number() over (partition by continent order by name asc) as rn
from student) A
group by rn
order by rn


