
-- ref tables, this data is only for the 2022 season
SELECT * 
FROM batting;
SELECT * 
FROM pitching;

-- this tells us the name, team, and batting average of players who 
-- have a batting average abve .300 
-- (this is an outstanding personal acheivement in the sport)
SELECT name, tm, BA
FROM batting
WHERE BA > .300;

-- the table is set up to duplicate players who played for more than 1 team 
-- in the single season, here we can use distinct for clarity but with limitations
SELECT DISTINCT name
FROM batting;

-- this is tells us what batters over 30 have hit more homeruns than 
-- how old they are, there aren't many! 
SELECT name, tm, age, HR
FROM batting
WHERE HR > 30 AND age > 30
ORDER BY age;

-- we can use the batters table to tell us the average homeruns (HR) accross
-- the league, this isn't official and would have some technical errors but is an
-- example of using ROUND and AVG in the select statement to generate a single answer
SELECT ROUND(AVG(HR), 2) AS league_avg_HRs
FROM BATTING;

-- this table tells us what pitchers have an ERA above 5 (averaging giving up 5 runs per game)
-- but have more than 5 saved games. Pitchers who didn't do so well but still won games
SELECT * 
FROM pitching
WHERE ERA > 5 AND SV > 5
ORDER BY SV DESC;

-- using the max function we can find out what is the highest number of games started
-- by one pitcher
SELECT MAX(GS) AS MOST_GAMES_STARTED_BY_ONE_PITCHER
FROM pitching;

-- using BETWEEN we can find out who is on the upper end of starting games
SELECT *
FROM pitching
WHERE GS BETWEEN 25 AND 33
ORDER BY GS DESC;

-- using IN we can find out every member who was on a single team, such as the Yankees 
-- in this example
SELECT *
FROM batting 
WHERE tm IN ('NYY');

-- this is an example of using HAVING to find out what players played for 3 or more 
-- teams last year, thats being traded a lot! we can find this out by getting a count for the number of teams
-- that appear with a single name
SELECT Name, COUNT(DISTINCT tm) AS teams_played_for
FROM batting 
GROUP BY name
HAVING COUNT(DISTINCT tm) >= 3
ORDER BY teams_played_for DESC;


-- A more simple version of HAVING to find out which pitchers
-- hit more than 15 batters. hbp = hit by pitch
SELECT name, hbp
FROM pitching
HAVING hbp > 15
ORDER BY hbp DESC;

-- this is where you can seperate the batting averages by team
-- turning singular player information in a table into team data
Select Tm AS Team_Name, ROUND(AVG(BA),3) AS TEAM_BA
FROM batting
GROUP BY Team_Name
ORDER BY TEAM_BA DESC;

-- who stole the most bases, but we also don't need to know who stole 10 or less
SELECT name, SB AS Stolen_Bases
FROM batting
WHERE SB > 10
ORDER BY Stolen_Bases DESC;

-- simple query we can look up one person by name if needed
SELECT *
From Pitching
WHERE Name IN ('Corbin Burnes');

-- Now we can use like to find out what pitchers have the same name as me, also using the wildcard character %
SELECT * 
FROM Pitching
Where Name LIKE ('Joe%');


-- This is using ANY as a way to locate who has over 20 stolen bases,
-- but has any amount of HRs
SELECT DISTINCT Name, HR
FROM batting
WHERE HR = ANY
(SELECT SB FROM batting WHERE SB > 20)


