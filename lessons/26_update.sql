-- Active: 1779203852153@@127.0.0.1@5444@learning

-- UPDATE: Modifies existing rows in a table
-- Syntax: UPDATE table SET column = value WHERE condition;
-- WARNING: Always use WHERE — without it, ALL rows are updated
--
-- Oracle / PostgreSQL: same syntax

-- ─── BASIC UPDATE ─────────────────────────────────────────────────────────────

-- Update one column for one row:
UPDATE Student SET Marks = 90 WHERE ID = 1;

-- Update multiple columns at once:
UPDATE Student SET Marks = 85, SEM = 6 WHERE ID = 2;

-- ─── UPDATE WITH CONDITION ────────────────────────────────────────────────────

-- Update all students in semester 7:
UPDATE Student SET Marks = Marks + 5 WHERE SEM = 7;

-- Update using multiple conditions:
UPDATE Student SET Marks = 100 WHERE SEM = 8 AND Gender = 'Female';

-- ─── UPDATE ALL ROWS (no WHERE) ───────────────────────────────────────────────

-- No WHERE → every row is updated — use with caution!
UPDATE Student SET SEM = 1;

-- ─── UPDATE WITH SUBQUERY ─────────────────────────────────────────────────────

-- Set DeptID based on a value from another table:
UPDATE Student
SET DeptID = (SELECT DeptID FROM Department WHERE DeptName = 'Computer Science')
WHERE Name = 'Alice';

-- ─── UPDATE SUMMARY ───────────────────────────────────────────────────────────
--
--  UPDATE Student SET col = val            → updates ALL rows (dangerous!)
--  UPDATE Student SET col = val WHERE ...  → updates matching rows only
--  SET multiple columns: SET a = 1, b = 2  → comma-separated
--  Use expressions: SET Marks = Marks + 10 → relative change
