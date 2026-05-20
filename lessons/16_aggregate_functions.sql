-- Active: 1779203852153@@127.0.0.1@5444@learning

-- AGGREGATE FUNCTIONS: Perform a calculation on a set of rows and return a single value
-- They summarize many rows into one result
-- Oracle and PostgreSQL syntax is identical for all of these
--
-- Key behavior:
--   - NULL values are IGNORED by all aggregate functions (except COUNT(*))
--   - They collapse all rows into a single row
--   - Commonly used with GROUP BY to summarize groups of rows

-- ─── COUNT ────────────────────────────────────────────────────────────────────

-- COUNT(*): counts ALL rows including rows with NULL values
SELECT COUNT(*) FROM Student;                    -- → 7 (all rows)

-- COUNT(column): counts rows where that column is NOT NULL
SELECT COUNT(Marks) FROM Student;                -- → 6 (RAHUL has NULL Marks, excluded)
SELECT COUNT(Age) FROM Student;                  -- → 6 (RAHUL has NULL Age, excluded)

-- COUNT with WHERE: counts rows matching a condition
SELECT COUNT(*) FROM Student WHERE Gender = 'FEMALE';   -- → 3
SELECT COUNT(*) FROM Student WHERE Marks > 90;          -- → 3

-- ─── SUM ──────────────────────────────────────────────────────────────────────

-- SUM: adds up all values in a column (NULL values are ignored)
SELECT SUM(Marks) FROM Student;                  -- → total of all marks
SELECT SUM(Marks) FROM Student WHERE Gender = 'MALE';   -- → total marks of males

-- ─── AVG ──────────────────────────────────────────────────────────────────────

-- AVG: calculates the average (NULL values are ignored — not counted in denominator)
SELECT AVG(Marks) FROM Student;                  -- → average of all non-NULL marks
SELECT ROUND(AVG(Marks), 2) FROM Student;        -- → rounded to 2 decimal places
SELECT AVG(Marks) FROM Student WHERE SEM = 8;    -- → average marks of sem 8 students

-- ─── MIN ──────────────────────────────────────────────────────────────────────

-- MIN: returns the smallest value (NULL values are ignored)
SELECT MIN(Marks) FROM Student;                  -- → lowest mark
SELECT MIN(Age) FROM Student;                    -- → youngest age
SELECT MIN(Marks) FROM Student WHERE Gender = 'FEMALE';  -- → lowest female mark

-- ─── MAX ──────────────────────────────────────────────────────────────────────

-- MAX: returns the largest value (NULL values are ignored)
SELECT MAX(Marks) FROM Student;                  -- → highest mark
SELECT MAX(Age) FROM Student;                    -- → oldest age
SELECT MAX(Marks) FROM Student WHERE SEM = 7;   -- → highest mark in sem 7

-- ─── COMBINING AGGREGATES ─────────────────────────────────────────────────────

-- Multiple aggregate functions in one query
SELECT
    COUNT(*)            AS Total_Students,
    COUNT(Marks)        AS Students_With_Marks,
    SUM(Marks)          AS Total_Marks,
    ROUND(AVG(Marks),2) AS Average_Marks,
    MIN(Marks)          AS Lowest_Mark,
    MAX(Marks)          AS Highest_Mark
FROM Student;

-- ─── IMPORTANT: CANNOT MIX WITH REGULAR COLUMNS ──────────────────────────────
-- You CANNOT select a regular column alongside an aggregate without GROUP BY
-- This query will cause an ERROR:
--   SELECT Name, MAX(Marks) FROM Student;   ← ERROR
-- Because MAX returns 1 row, but Name has 7 rows — they cannot combine
-- Solution: use GROUP BY (covered in next file)
