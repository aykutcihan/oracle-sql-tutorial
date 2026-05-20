-- Active: 1779203852153@@127.0.0.1@5444@learning

-- SUBQUERY (Nested Query): A query written inside another query
-- The inner query runs FIRST, its result is used by the outer query
-- Subqueries are always written inside parentheses ()
--
-- Syntax:
--   SELECT * FROM table
--   WHERE column OPERATOR (SELECT column FROM table WHERE condition);
--
-- Why use subquery?
-- When you don't know the exact value to filter by,
-- but you know how to calculate it with another query

-- ─── SUBQUERY WITH WHERE ──────────────────────────────────────────────────────

-- Find students who have marks greater than the average marks
-- Step 1 (inner query): calculate the average marks
SELECT AVG(Marks) FROM Student;               -- → 89.17

-- Step 2 (outer query): use that result as the filter
SELECT * FROM Student WHERE Marks > 89.17;

-- Combined as a subquery (no need to know the average in advance):
SELECT * FROM Student
WHERE Marks > (SELECT AVG(Marks) FROM Student);

-- Find the student with the highest marks
SELECT * FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- Find the student with the lowest marks
SELECT * FROM Student
WHERE Marks = (SELECT MIN(Marks) FROM Student);

-- Find students with marks above the minimum marks
SELECT * FROM Student
WHERE Marks > (SELECT MIN(Marks) FROM Student);

-- ─── SUBQUERY WITH IN ─────────────────────────────────────────────────────────

-- Subquery can return multiple rows — use IN instead of =
-- Find all students who are in the same semester as ALKA
SELECT * FROM Student
WHERE SEM IN (SELECT SEM FROM Student WHERE Name = 'ALKA');

-- Find students who have the same marks as any female student
SELECT * FROM Student
WHERE Marks IN (SELECT Marks FROM Student WHERE Gender = 'FEMALE');

-- ─── SUBQUERY IN SELECT ───────────────────────────────────────────────────────

-- Show each student's marks and the overall average side by side
SELECT Name, Marks,
    (SELECT ROUND(AVG(Marks), 2) FROM Student) AS Overall_Avg
FROM Student;

-- Show how much each student's marks differ from the average
SELECT Name, Marks,
    Marks - (SELECT ROUND(AVG(Marks), 2) FROM Student) AS Diff_From_Avg
FROM Student
WHERE Marks IS NOT NULL;

-- ─── SUBQUERY EXECUTION ORDER ─────────────────────────────────────────────────
-- 1. Inner query runs first  → produces a value or a list
-- 2. Outer query uses that result to filter or compute
--
-- Example:
--   SELECT * FROM Student WHERE Marks > (SELECT AVG(Marks) FROM Student)
--   → First:  SELECT AVG(Marks) FROM Student  → 89.17
--   → Then:   SELECT * FROM Student WHERE Marks > 89.17
