-- Active: 1779203852153@@127.0.0.1@5444@learning

-- DELETE: Removes rows from a table
-- Syntax: DELETE FROM table WHERE condition;
-- WARNING: Always use WHERE — without it, ALL rows are deleted
-- Table structure stays intact (unlike DROP TABLE)
--
-- Oracle / PostgreSQL: same syntax

-- ─── BASIC DELETE ─────────────────────────────────────────────────────────────

-- Delete one specific row:
DELETE FROM Student WHERE ID = 1;

-- Delete rows matching a condition:
DELETE FROM Student WHERE SEM = 1;

-- Delete with multiple conditions:
DELETE FROM Student WHERE Marks < 40 AND SEM = 3;

-- ─── DELETE ALL ROWS (no WHERE) ───────────────────────────────────────────────

-- No WHERE → every row is deleted — table stays, data is gone
DELETE FROM Student;

-- ─── DELETE WITH SUBQUERY ─────────────────────────────────────────────────────

-- Delete students who belong to a specific department:
DELETE FROM Student
WHERE DeptID = (SELECT DeptID FROM Department WHERE DeptName = 'History');

-- ─── DELETE vs TRUNCATE vs DROP ───────────────────────────────────────────────
--
--                  DELETE              TRUNCATE            DROP
--  Removes         specific rows       all rows            table + data
--  WHERE filter?   YES                 NO                  NO
--  Table stays?    YES                 YES                 NO
--  Undoable?       YES (ROLLBACK)      NO (Oracle)         NO
--                                      YES (PostgreSQL)
--  Speed           slowest             very fast           fast
--
--  Use DELETE when you need WHERE (remove specific rows)
--  Use TRUNCATE when you want to empty the whole table fast
--  Use DROP when you no longer need the table at all

-- ─── DELETE SUMMARY ───────────────────────────────────────────────────────────
--
--  DELETE FROM Student                → deletes ALL rows (dangerous!)
--  DELETE FROM Student WHERE ...      → deletes matching rows only
--  Deleted rows can be recovered with ROLLBACK (before COMMIT)
