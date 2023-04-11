-- for lookup
SELECT *
FROM batting;

-- Using the lag function we can make a column that shows the person who just beat
-- the player in the current row with a better batting average from a sample of the best
-- batters in the league
WITH Big_Hitters AS (
  SELECT DISTINCT
    name, tm, BA
  FROM batting
  WHERE
    BA >= .300 AND
    G > 20)
SELECT
  name, tm, BA,
  LAG(name) OVER (ORDER BY BA DESC) AS Just_Behind
FROM Big_Hitters
ORDER BY BA DESC;

-- Using Lead instead of of lag we can pull information in the opposite direction
-- in this situation we are looking at the HR leaders and showing the the person who they
-- are beating, note that because we are ordering these in descending order it will affect
-- how the data is displayed
WITH HR_Leaders AS (
  SELECT DISTINCT
    Name,
    HR
  FROM batting
  WHERE HR >= 30)
SELECT
  Name,
  HR,
  LEAD(Name) OVER (ORDER BY HR DESC) AS Just_Ahead_Of
FROM HR_Leaders
ORDER BY HR DESC;



-- Using FIRST_VALUE when can compare all qualifying batters for the batting champ title with the winning batting champ by
-- calculating the batter with the highest batting average (BA) and 500 plate apperences (PA)
WITH All_Qualifying_Batters AS (
  SELECT DISTINCT
    Name, BA
  FROM Batting
  WHERE PA >= 500)
SELECT
  name, BA,
  FIRST_VALUE(name) OVER (
    ORDER BY BA DESC
  ) AS Batting_Champ
FROM All_Qualifying_Batters;


-- Using DENSE_RANK we can rank home run leaders
WITH HR_Leaders AS (
  SELECT DISTINCT
    Name,
    HR
  FROM batting
  WHERE HR >= 30)
SELECT
Name, HR,
  DENSE_RANK() OVER (ORDER BY HR DESC) AS Rank_Num
FROM HR_Leaders
ORDER BY HR DESC, RANK_Num ASC;


-- Using Ntile you are able to break up groups to see a spread of data of your choosing
-- because HRs have a short spread from 1-62 we can see where someone falls within 
-- 4 seperate groups, and excluding those who didn't hit a home run
With Everyone_Who_Homered AS (
  SELECT Name, HR
  FROM batting
  WHERE HR >=1)
SELECT
  Name, HR,
  NTILE(4) OVER (ORDER BY HR DESC) AS Quartile
FROM Everyone_Who_Homered
ORDER BY HR DESC, Quartile ASC;

