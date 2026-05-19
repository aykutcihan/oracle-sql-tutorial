-- Active: 1779203852153@@127.0.0.1@5444@learning

-- HAVING: Filters groups AFTER GROUP BY has been applied
-- WHERE filters individual rows BEFORE grouping
-- HAVING filters grouped results AFTER grouping
--
-- Rule: HAVING is always used together with GROUP BY
-- You cannot use aggregate functions (COUNT, AVG, SUM...) in WHERE — use HAVING instead
--
-- Syntax:
--   SELECT column, AGG_FUNC(column)
--   FROM table
--   WHERE condition          ← filters rows (before grouping)
--   GROUP BY column
--   HAVING AGG_FUNC condition ← filters groups (after grouping)
--   ORDER BY column;

-- ─── BASIC HAVING ─────────────────────────────────────────────────────────────

-- Groups with more than 2 students
SELECT Gender, COUNT(*) AS Total
FROM Student
GROUP BY Gender
HAVING COUNT(*) > 2;

-- Semesters where average marks is above 85
SELECT SEM, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
GROUP BY SEM
HAVING AVG(Marks) > 85;

-- Semesters where total students is exactly 2
SELECT SEM, COUNT(*) AS Total
FROM Student
GROUP BY SEM
HAVING COUNT(*) = 2;

-- ─── HAVING WITH MULTIPLE CONDITIONS ─────────────────────────────────────────

-- Semesters with average marks above 80 AND more than 1 student
SELECT SEM, COUNT(*) AS Total, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
GROUP BY SEM
HAVING AVG(Marks) > 80 AND COUNT(*) > 1;

-- ─── WHERE vs HAVING TOGETHER ────────────────────────────────────────────────

-- WHERE runs first (filters rows), then GROUP BY, then HAVING (filters groups)
-- Only male students, grouped by SEM, show only groups with avg marks above 85
SELECT SEM, COUNT(*) AS Total, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
WHERE Gender = 'MALE'        -- step 1: keep only MALE rows
GROUP BY SEM                 -- step 2: group remaining rows by SEM
HAVING AVG(Marks) > 85;      -- step 3: keep only groups where avg > 85

-- ─── WHERE vs HAVING — KEY DIFFERENCE ───────────────────────────────────────
-- WHERE  → filters ROWS    → runs BEFORE grouping → cannot use aggregate functions
-- HAVING → filters GROUPS  → runs AFTER grouping  → must use aggregate functions
--
-- WRONG — cannot use aggregate in WHERE:
--   SELECT Gender, AVG(Marks) FROM Student WHERE AVG(Marks) > 85 GROUP BY Gender;
--
-- CORRECT — use HAVING for aggregate conditions:
--   SELECT Gender, AVG(Marks) FROM Student GROUP BY Gender HAVING AVG(Marks) > 85;

SELECT Gender, ROUND(AVG(Marks), 2) AS Avg_Marks
FROM Student
GROUP BY Gender
HAVING AVG(Marks) > 85;

-- ─── QUERY EXECUTION ORDER (complete) ────────────────────────────────────────
--   1. FROM      → which table
--   2. WHERE     → filter rows
--   3. GROUP BY  → form groups
--   4. HAVING    → filter groups
--   5. SELECT    → compute output
--   6. ORDER BY  → sort results
