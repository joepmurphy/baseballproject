
-- basic window function where you can create a number for each row
SELECT *,
ROW_NUMBER() OVER() AS Row_Num
FROM pitching
ORDER BY Row_Num;

-- If you wanted to reverse the way rows are numbered
SELECT *,
row_number() OVER(ORDER BY Rk DESC) AS Row_Num
FROM pitching
Order by Row_Num DESC;

-- This will list ages and tell you the count of pitchers in the MLB
-- with that age
SELECT Age,
COUNT(*) AS Players
FROM pitching
GROUP BY Age
ORDER BY Age;

-- A running total can be used with the age query 
WITH Pitcher_Ages AS (
SELECT Age, Count(*) AS Players
FROM pitching
GROUP BY Age
ORDER BY Age)
SELECT Age, Players, SUM(Players) OVER (ORDER BY Age ASC) As Running_Total_Ages
FROM Pitcher_Ages
ORDER BY Age;


-- Using Partition we can take a look at who has over 15 wins and 
-- how many pitchers also have that same amount of wins
WITH HIGH_WIN_PITCHERS AS (
SELECT *
FROM pitching
WHERE W >= 15)
SELECT Name, W, COUNT(Name) OVER (PARTITION BY W ORDER BY W DESC) AS group_segment
FROM HIGH_WIN_PITCHERS
ORDER BY W DESC;

-- The data set is seperated into the two leagues (american and national)
-- but it does not seperate them into divisions, this allows us to look at just the 
-- NL Central divsion, with a basic query using 2 ORDER BY factors. 
WITH NL_CENTRAL AS (
SELECT *
FROM pitching
WHERE Tm IN ('PIT', 'CHI', 'CIN', 'MIL', 'STL'))
SELECT Name, W, tm
FROM NL_CENTRAL
ORDER BY tm, W DESC;
