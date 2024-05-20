-- Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
 

-- Write a query to find the shortest distance between these points rounded to 2 decimals.
 

-- | x  | y  |
-- |----|----|
-- | -1 | -1 |
-- | 0  | 0  |
-- | -1 | -2 |
 

-- The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:
 

-- | shortest |
-- |----------|
-- | 1.00     |
 

-- Note: The longest distance among all the points are less than 10000.

-- Solution

CREATE TABLE point_2d (
    x INT,
    y INT
);

INSERT INTO point_2d (x, y) VALUES
(-1, -1),
(0, 0),
(-1, -2);

select
*
from 
(select
sqrt(power((B.x-A.x), 2) + power((B.y-A.y), 2)) as area
from point_2d A
cross join point_2d B) C
where area != 0 
order by area
limit 1

