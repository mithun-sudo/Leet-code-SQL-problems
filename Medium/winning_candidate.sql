-- Table: Candidate

-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  
-- Table: Vote

-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.
-- Write a sql to find the name of the winning candidate, the above example will return the winner B.

-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+
-- Notes:

-- You may assume there is no tie, in other words there will be only one winning candidate

-- Solution

CREATE TABLE Candidate (
    id INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Vote (
    id INT PRIMARY KEY,
    CandidateId INT,
    FOREIGN KEY (CandidateId) REFERENCES Candidate(id)
);

INSERT INTO Candidate (id, Name) VALUES (1, 'A');
INSERT INTO Candidate (id, Name) VALUES (2, 'B');
INSERT INTO Candidate (id, Name) VALUES (3, 'C');
INSERT INTO Candidate (id, Name) VALUES (4, 'D');
INSERT INTO Candidate (id, Name) VALUES (5, 'E');

INSERT INTO Vote (id, CandidateId) VALUES (1, 2);
INSERT INTO Vote (id, CandidateId) VALUES (2, 4);
INSERT INTO Vote (id, CandidateId) VALUES (3, 3);
INSERT INTO Vote (id, CandidateId) VALUES (4, 2);
INSERT INTO Vote (id, CandidateId) VALUES (5, 5);

select
name
from candidate
where id in (select
candidateid
from vote
group by candidateid
order by count(candidateid) desc
limit 1) 

