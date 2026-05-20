-- Active: 1779203852153@@127.0.0.1@5444@learning

-- GROUP BY: Groups rows that have the same value in a column
-- Then applies aggregate functions to each group separately
-- Without GROUP BY, aggregate functions return ONE result for the whole table
-- With GROUP BY, aggregate functions return ONE result PER GROUP
--
-- Syntax:
--   SELECT column, AGG_FUNC(column)
--   FROM table
--   GROUP BY column;
--
-- Rule: every column in SELECT must either be:
--   1. Inside an aggregate function (COUNT, SUM, AVG, MIN, MAX)
--   2. Listed in the GROUP BY clause

-- ─── BASIC GROUP BY ───────────────────────────────────────────────────────────

-- Without GROUP BY: one total for the whole table
SELECT COUNT(*) FROM Student;              -- → 7

-- With GROUP BY: count per gender
SELECT Gender, COUNT(*) AS Total
FROM Student
GROUP BY Gender;
-- → MALE   3
-- → FEMALE 3

-- Average marks per semester
SELECT SEM, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
GROUP BY SEM;

-- Total marks per semester
SELECT SEM, SUM(Marks) AS Total_Marks
FROM Student
GROUP BY SEM;

-- ─── MULTIPLE AGGREGATE FUNCTIONS WITH GROUP BY ───────────────────────────────

-- Full summary per gender
SELECT
    Gender,
    COUNT(*)            AS Total_Students,
    ROUND(AVG(Marks),2) AS Avg_Marks,
    MIN(Marks)          AS Min_Marks,
    MAX(Marks)          AS Max_Marks
FROM Student
GROUP BY Gender;

-- Full summary per semester
SELECT
    SEM,
    COUNT(*)            AS Total_Students,
    ROUND(AVG(Marks),2) AS Avg_Marks,
    MIN(Marks)          AS Min_Marks,
    MAX(Marks)          AS Max_Marks
FROM Student
GROUP BY SEM;

-- ─── GROUP BY WITH WHERE ──────────────────────────────────────────────────────

-- WHERE filters rows BEFORE grouping
-- Only include students with marks above 85, then group
SELECT Gender, COUNT(*) AS Total, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
WHERE Marks > 85
GROUP BY Gender;

-- ─── GROUP BY WITH ORDER BY ───────────────────────────────────────────────────

-- ORDER BY can be used after GROUP BY to sort the groups
SELECT SEM, COUNT(*) AS Total, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
GROUP BY SEM
ORDER BY Avg_Marks DESC;

-- ─── QUERY EXECUTION ORDER ────────────────────────────────────────────────────
-- SQL processes clauses in this order (not the order you write them):
--   1. FROM    → which table
--   2. WHERE   → filter rows
--   3. GROUP BY → form groups
--   4. SELECT  → compute aggregates
--   5. ORDER BY → sort results
