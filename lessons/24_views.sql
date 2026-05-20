-- Active: 1779203852153@@127.0.0.1@5444@learning

-- VIEWS: A saved SELECT query treated as a virtual table
-- A view does not store data — it runs the underlying query each time
-- Use views to simplify complex queries, restrict access, or reuse logic
--
-- Summary:
--   CREATE VIEW        → define a new view
--   CREATE OR REPLACE  → update an existing view without dropping it
--   DROP VIEW          → remove a view
--   SELECT from a view → same as selecting from a table

-- ─── CREATE VIEW ──────────────────────────────────────────────────────────────

-- Basic syntax:
-- CREATE VIEW view_name AS SELECT ...;
-- Oracle / PostgreSQL: same syntax

-- Simple view — students in semester 7:
CREATE VIEW SeniorStudents AS
SELECT ID, Name, Age, Marks
FROM Student
WHERE SEM = 7;

-- Use it like a table:
SELECT * FROM SeniorStudents;

-- Another example — join two tables into one view:
CREATE VIEW StudentDept AS
SELECT s.ID, s.Name, s.Marks, d.DeptName
FROM Student s
JOIN Department d ON s.DeptID = d.DeptID;

-- Query the view:
SELECT * FROM StudentDept WHERE DeptName = 'Computer Science';

-- ─── CREATE OR REPLACE VIEW ───────────────────────────────────────────────────

-- Updates the view definition without dropping and recreating
-- Oracle / PostgreSQL: same syntax

CREATE OR REPLACE VIEW SeniorStudents AS
SELECT ID, Name, Age, Marks, SEM
FROM Student
WHERE SEM = 7 AND Marks >= 60;

-- ─── DROP VIEW ────────────────────────────────────────────────────────────────

-- Removes the view — does NOT affect the underlying table data
-- Oracle / PostgreSQL: same syntax

DROP VIEW SeniorStudents;

-- PostgreSQL only:
DROP VIEW IF EXISTS SeniorStudents;

-- ─── UPDATABLE VIEWS ──────────────────────────────────────────────────────────

-- Simple views (single table, no GROUP BY / DISTINCT / aggregate) can be
-- used for INSERT, UPDATE, DELETE — the change goes to the real table.

CREATE VIEW StudentNames AS
SELECT ID, Name FROM Student;

-- This UPDATE affects the real Student table:
UPDATE StudentNames SET Name = 'Bob' WHERE ID = 1;

-- Views with JOIN, GROUP BY, aggregate functions → NOT updatable (read-only)

-- ─── WHY USE VIEWS ────────────────────────────────────────────────────────────

-- 1. Simplify complex queries — write once, reuse with a simple SELECT
-- 2. Security — show only specific columns, hide sensitive data (e.g. salary)
-- 3. Consistent interface — if the table structure changes, update the view
--    and all queries using the view still work

-- Example: hide salary column from regular users
CREATE VIEW PublicEmployee AS
SELECT ID, Name, Department FROM Employee;
-- Users query PublicEmployee and never see the Salary column

-- ─── VIEWS SUMMARY ────────────────────────────────────────────────────────────
--
--  Feature               Detail
--  Stores data?          NO — reruns the query each time
--  Can SELECT?           YES
--  Can INSERT/UPDATE?    Only simple single-table views
--  Survives DROP TABLE?  NO — view breaks if base table is dropped
--  Performance           Same as running the underlying query directly
