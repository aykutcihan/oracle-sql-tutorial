-- Active: 1779203852153@@127.0.0.1@5444@learning

-- JOIN: Combines rows from two or more tables based on a related column
-- Used when data is spread across multiple tables
-- Oracle and PostgreSQL syntax is identical for all JOIN types
--
-- We use two tables defined in 01_create_table.sql and populated in 02_insert_into.sql:
--   Student     → ID, Name, Age, Gender, Marks, SEM, DeptID
--   Department  → DeptID, DeptName, HOD
-- The common column is DeptID — this links the two tables

-- ─── INNER JOIN ───────────────────────────────────────────────────────────────

-- INNER JOIN: returns only rows where the join condition matches in BOTH tables
-- Rows with no match are excluded from the result
-- Syntax: SELECT ... FROM table1 INNER JOIN table2 ON table1.col = table2.col

SELECT Student.Name, Student.Marks, Department.DeptName
FROM Student
INNER JOIN Department ON Student.DeptID = Department.DeptID;
-- RAHUL is excluded — his DeptID is NULL, no match in Department table

-- Using table aliases to shorten the query
SELECT s.Name, s.Marks, s.SEM, d.DeptName, d.HOD
FROM Student s
INNER JOIN Department d ON s.DeptID = d.DeptID;

-- ─── LEFT JOIN (LEFT OUTER JOIN) ──────────────────────────────────────────────

-- LEFT JOIN: returns ALL rows from the LEFT table
-- If no match in the right table, NULL is shown for right table columns
-- Syntax: SELECT ... FROM table1 LEFT JOIN table2 ON table1.col = table2.col

SELECT s.Name, s.Marks, d.DeptName
FROM Student s
LEFT JOIN Department d ON s.DeptID = d.DeptID;
-- RAHUL appears with NULL for DeptName — he has no department

-- ─── RIGHT JOIN (RIGHT OUTER JOIN) ────────────────────────────────────────────

-- RIGHT JOIN: returns ALL rows from the RIGHT table
-- If no match in the left table, NULL is shown for left table columns

SELECT s.Name, s.Marks, d.DeptName
FROM Student s
RIGHT JOIN Department d ON s.DeptID = d.DeptID;
-- All departments appear even if no student is assigned to them

-- ─── FULL OUTER JOIN ──────────────────────────────────────────────────────────

-- FULL OUTER JOIN: returns ALL rows from BOTH tables
-- NULLs appear where there is no match on either side

SELECT s.Name, s.Marks, d.DeptName
FROM Student s
FULL OUTER JOIN Department d ON s.DeptID = d.DeptID;

-- ─── NATURAL JOIN ────────────────────────────────────────────────────────────

-- NATURAL JOIN: automatically joins tables using columns with the SAME NAME and data type
-- You do NOT write the ON condition — SQL finds the matching column automatically
-- Oracle: NATURAL JOIN   PostgreSQL: NATURAL JOIN  ← identical
--
-- Both Student and Department have a column named DeptID → SQL joins on that automatically

SELECT s.Name, s.Marks, d.DeptName
FROM Student s
NATURAL JOIN Department d;
-- Automatically uses DeptID as the join column (same name in both tables)
-- Behaves like INNER JOIN — only matching rows returned
-- RAHUL excluded (DeptID is NULL)

-- WARNING: NATURAL JOIN is risky — if two tables happen to share a column name
-- that you did NOT intend to join on, SQL will join on it anyway silently.
-- Prefer INNER JOIN with explicit ON condition for safety.

-- ─── CROSS JOIN ───────────────────────────────────────────────────────────────

-- CROSS JOIN: returns every possible combination of rows from both tables
-- Also called Cartesian Product
-- No ON condition — every row from table1 is paired with every row from table2
-- Result row count = rows in table1 × rows in table2
-- Oracle: CROSS JOIN   PostgreSQL: CROSS JOIN  ← identical

SELECT s.Name, d.DeptName
FROM Student s
CROSS JOIN Department d;
-- 7 students × 3 departments = 21 rows
-- Every student is paired with every department regardless of actual assignment

-- CROSS JOIN is rarely used in practice — mainly for generating all combinations

-- ─── JOIN TYPES SUMMARY ───────────────────────────────────────────────────────
--
--   INNER JOIN       → only matching rows from both tables
--   LEFT JOIN        → all rows from left  + matching from right (NULL if no match)
--   RIGHT JOIN       → all rows from right + matching from left  (NULL if no match)
--   FULL OUTER JOIN  → all rows from both tables (NULL where no match)
--   NATURAL JOIN     → like INNER JOIN but join column found automatically by name
--   CROSS JOIN       → every combination of rows (table1 rows × table2 rows)