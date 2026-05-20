-- Active: 1779203852153@@127.0.0.1@5444@learning

-- IS NULL / IS NOT NULL
-- NULL means a field has NO value — it is unknown or missing
-- NULL is NOT the same as 0 or '' (empty string) — it means "nothing at all"
--
-- You CANNOT use = or != to check for NULL:
--   WHERE Age = NULL    → always returns nothing (WRONG)
--   WHERE Age != NULL   → always returns nothing (WRONG)
-- You MUST use IS NULL or IS NOT NULL instead.
--
-- Syntax:
--   WHERE column IS NULL       → rows where the column has no value
--   WHERE column IS NOT NULL   → rows where the column has a value

-- ─── IS NULL ──────────────────────────────────────────────────────────────────

-- Students where Age is NULL (no age recorded)
SELECT * FROM Student WHERE Age IS NULL;

-- Students where Marks is NULL
SELECT * FROM Student WHERE Marks IS NULL;

-- Students where SEM is NULL
SELECT * FROM Student WHERE SEM IS NULL;

-- ─── IS NOT NULL ──────────────────────────────────────────────────────────────

-- Students where Age has a value
SELECT * FROM Student WHERE Age IS NOT NULL;

-- Students where Marks has a value
SELECT * FROM Student WHERE Marks IS NOT NULL;

-- ─── COMBINING WITH OTHER CONDITIONS ─────────────────────────────────────────

-- Students where SEM is NULL OR Age is NULL
SELECT * FROM Student WHERE SEM IS NULL OR Age IS NULL;

-- Students where Marks is NOT NULL AND Marks > 90
SELECT * FROM Student WHERE Marks IS NOT NULL AND Marks > 90;

-- ─── WHY NULL EXISTS ──────────────────────────────────────────────────────────
-- NULL appears when a row is inserted without providing a value for a column
-- Example from our data:
--   INSERT INTO Student (ID, Name, Gender) VALUES (58, 'RAHUL', 'MALE');
--   → Age, Marks, SEM were not provided → stored as NULL
--
-- To verify: this query returns RAHUL because his SEM is NULL
SELECT * FROM Student WHERE SEM IS NULL;

-- ─── NULL IN CALCULATIONS ─────────────────────────────────────────────────────
-- Any arithmetic with NULL always returns NULL
--   NULL + 10  → NULL
--   NULL * 5   → NULL
-- This is why IS NULL checks matter before doing math on a column

-- Oracle has NVL() to replace NULL with a default value:
--   NVL(Marks, 0)  → if Marks is NULL, treat it as 0
-- PostgreSQL equivalent is COALESCE():
--   COALESCE(Marks, 0)
SELECT Name, COALESCE(Marks, 0) AS Marks, COALESCE(SEM, 0) AS SEM FROM Student;
