-- Table: Teams

-- +---------------+----------+
-- | Column Name   | Type     |
-- +---------------+----------+
-- | team_id       | int      |
-- | team_name     | varchar  |
-- +---------------+----------+
-- team_id is the primary key of this table.
-- Each row of this table represents a single football team.
-- Table: Matches

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | host_team     | int     |
-- | guest_team    | int     | 
-- | host_goals    | int     |
-- | guest_goals   | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a finished match between two different teams. 
-- Teams host_team and guest_team are represented by their IDs in the teams table (team_id) and they scored host_goals and guest_goals goals respectively.
 

-- You would like to compute the scores of all teams after all matches. Points are awarded as follows:
-- A team receives three points if they win a match (Score strictly more goals than the opponent team).
-- A team receives one point if they draw a match (Same number of goals as the opponent team).
-- A team receives no points if they lose a match (Score less goals than the opponent team).
-- Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches. Result table should be ordered by num_points (decreasing order). In case of a tie, order the records by team_id (increasing order).

-- The query result format is in the following example:

-- Teams table:
-- +-----------+--------------+
-- | team_id   | team_name    |
-- +-----------+--------------+
-- | 10        | Leetcode FC  |
-- | 20        | NewYork FC   |
-- | 30        | Atlanta FC   |
-- | 40        | Chicago FC   |
-- | 50        | Toronto FC   |
-- +-----------+--------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 10           | 20            | 3           | 0            |
-- | 2          | 30           | 10            | 2           | 2            |
-- | 3          | 10           | 50            | 5           | 1            |
-- | 4          | 20           | 30            | 1           | 0            |
-- | 5          | 50           | 30            | 1           | 0            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +------------+--------------+---------------+
-- | team_id    | team_name    | num_points    |
-- +------------+--------------+---------------+
-- | 10         | Leetcode FC  | 7             |
-- | 20         | NewYork FC   | 3             |
-- | 50         | Toronto FC   | 3             |
-- | 30         | Atlanta FC   | 1             |
-- | 40         | Chicago FC   | 0             |
-- +------------+--------------+---------------+

-- Solution

CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100)
);

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT,
    FOREIGN KEY (host_team) REFERENCES Teams(team_id),
    FOREIGN KEY (guest_team) REFERENCES Teams(team_id)
);

INSERT INTO Teams (team_id, team_name) VALUES (10, 'Leetcode FC');
INSERT INTO Teams (team_id, team_name) VALUES (20, 'NewYork FC');
INSERT INTO Teams (team_id, team_name) VALUES (30, 'Atlanta FC');
INSERT INTO Teams (team_id, team_name) VALUES (40, 'Chicago FC');
INSERT INTO Teams (team_id, team_name) VALUES (50, 'Toronto FC');

INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES (1, 10, 20, 3, 0);
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES (2, 30, 10, 2, 2);
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES (3, 10, 50, 5, 1);
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES (4, 20, 30, 1, 0);
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES (5, 50, 30, 1, 0);

with temp as (select
*,
case 
when host_goals > guest_goals then 3 
when host_goals = guest_goals then 1
when host_goals < guest_goals then 0 end as points_per_match_of_host,
case 
when host_goals < guest_goals then 3 
when host_goals = guest_goals then 1
when host_goals > guest_goals then 0 end as points_per_match_of_guest
from matches)
select 
team_id,
team_name,
coalesce(points, 0) as points
from teams
left join 
(select
team,
sum(points) as points
from 
(select host_team as team, points_per_match_of_host as points from temp
union all
select guest_team, points_per_match_of_guest from temp) A
group by team) B on teams.team_id = B.team
order by points desc


