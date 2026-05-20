-- Active: 1779203852153@@127.0.0.1@5444@learning

-- TRANSACTIONS: A group of SQL operations treated as one unit
-- Either ALL succeed (COMMIT) or ALL are undone (ROLLBACK)
-- Ensures data stays consistent even if something goes wrong mid-operation
--
-- Commands: COMMIT, ROLLBACK, SAVEPOINT
-- Oracle / PostgreSQL: same syntax

-- ─── THE PROBLEM TRANSACTIONS SOLVE ──────────────────────────────────────────

-- Bank transfer example:
--   Step 1: Deduct 1000 from Account A
--   Step 2: Add    1000 to   Account B
--
-- If Step 1 succeeds but Step 2 crashes → money disappears.
-- With a transaction: if Step 2 fails → Step 1 is also undone. Safe.

-- ─── COMMIT ───────────────────────────────────────────────────────────────────

-- Saves all changes made since the last COMMIT permanently to the database
-- After COMMIT, changes cannot be rolled back

BEGIN;                                              -- PostgreSQL: start transaction
  UPDATE Student SET Marks = 95 WHERE ID = 1;
  UPDATE Student SET Marks = 80 WHERE ID = 2;
COMMIT;                                             -- save both updates permanently

-- Oracle: no BEGIN needed — each session is always in a transaction
--   UPDATE Student SET Marks = 95 WHERE ID = 1;
--   UPDATE Student SET Marks = 80 WHERE ID = 2;
--   COMMIT;

-- ─── ROLLBACK ─────────────────────────────────────────────────────────────────

-- Undoes all changes made since the last COMMIT
-- Use when something goes wrong and you want to cancel all pending changes

BEGIN;
  DELETE FROM Student WHERE SEM = 1;
  -- Oops, wrong condition — cancel everything:
ROLLBACK;                                           -- Student table is unchanged

-- ─── SAVEPOINT ────────────────────────────────────────────────────────────────

-- Creates a named checkpoint inside a transaction
-- You can ROLLBACK to a SAVEPOINT without undoing the entire transaction
-- Oracle / PostgreSQL: same syntax

BEGIN;
  INSERT INTO Student (ID, Name, Age, Gender, Marks, SEM, DeptID)
  VALUES (10, 'Alice', 20, 'Female', 85, 5, 1);

  SAVEPOINT after_alice;                            -- checkpoint saved here

  INSERT INTO Student (ID, Name, Age, Gender, Marks, SEM, DeptID)
  VALUES (11, 'Bob', 22, 'Male', 70, 5, 1);

  -- Bob's insert was a mistake — roll back only to the savepoint:
  ROLLBACK TO after_alice;                          -- Bob is gone, Alice stays

COMMIT;                                             -- only Alice is saved

-- ─── AUTOCOMMIT ───────────────────────────────────────────────────────────────

-- PostgreSQL default: AUTOCOMMIT is ON
--   → every statement is automatically committed immediately
--   → no ROLLBACK possible unless you explicitly use BEGIN

-- Oracle default: AUTOCOMMIT is OFF
--   → changes are pending until you COMMIT or ROLLBACK
--   → session end without COMMIT → changes are rolled back

-- In most SQL clients (DBeaver, SQL*Plus) you can toggle autocommit manually.

-- ─── TRANSACTION SUMMARY ──────────────────────────────────────────────────────
--
--  COMMIT              → save all pending changes permanently
--  ROLLBACK            → undo all pending changes since last COMMIT
--  SAVEPOINT name      → create a checkpoint inside the transaction
--  ROLLBACK TO name    → undo back to the savepoint only
--
--  Golden rule: if all steps succeed → COMMIT. If any step fails → ROLLBACK.
