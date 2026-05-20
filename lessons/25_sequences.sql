-- Active: 1779203852153@@127.0.0.1@5444@learning

-- SEQUENCES: Auto-generated sequential numbers
-- Used to automatically assign unique IDs to rows on INSERT
-- Oracle: uses SEQUENCE objects explicitly
-- PostgreSQL: uses SERIAL / BIGSERIAL shorthand (or CREATE SEQUENCE)
--
-- Summary:
--   CREATE SEQUENCE → define a sequence object
--   NEXTVAL         → get the next number (increments the counter)
--   CURRVAL         → get the current number (Oracle only)
--   ALTER SEQUENCE  → change sequence settings
--   DROP SEQUENCE   → remove a sequence

-- ─── THE PROBLEM SEQUENCES SOLVE ─────────────────────────────────────────────

-- Without sequences, you must track IDs yourself:
-- INSERT INTO Student VALUES (1, 'Alice', ...);
-- INSERT INTO Student VALUES (2, 'Bob',   ...);
-- INSERT INTO Student VALUES (3, 'Carol', ...);
-- → Error-prone. Two sessions can insert the same ID.

-- Sequences solve this — the database generates a unique number each time.

-- ─── POSTGRESQL: SERIAL (shorthand) ──────────────────────────────────────────

-- SERIAL automatically creates a sequence and links it to the column
-- No need to write CREATE SEQUENCE manually
-- PostgreSQL only — does not exist in Oracle

CREATE TABLE Student_Serial
(
  ID     SERIAL PRIMARY KEY,   -- auto-increment: 1, 2, 3, ...
  Name   VARCHAR(30) NOT NULL,
  Age    INTEGER
);

-- INSERT without specifying ID — database fills it automatically:
INSERT INTO Student_Serial (Name, Age) VALUES ('Alice', 20);
INSERT INTO Student_Serial (Name, Age) VALUES ('Bob',   22);
INSERT INTO Student_Serial (Name, Age) VALUES ('Carol', 21);

-- Verify: ID is 1, 2, 3 automatically
SELECT * FROM Student_Serial;

-- BIGSERIAL: same as SERIAL but uses BIGINT (for very large tables)
-- SMALLSERIAL: same as SERIAL but uses SMALLINT (for small tables)

-- ─── POSTGRESQL: CREATE SEQUENCE (explicit) ───────────────────────────────────

-- More control over start value, increment, min/max, cycling
-- Oracle / PostgreSQL: similar syntax

CREATE SEQUENCE student_id_seq
  START WITH 100       -- first value
  INCREMENT BY 1       -- step
  MINVALUE 100         -- lower bound
  MAXVALUE 9999        -- upper bound
  NO CYCLE;            -- stop at MAXVALUE, don't wrap around (CYCLE to wrap)

-- Get next value (PostgreSQL):
SELECT NEXTVAL('student_id_seq');   -- returns 100
SELECT NEXTVAL('student_id_seq');   -- returns 101

-- Use in INSERT:
INSERT INTO Student (ID, Name, Age, Gender, Marks, SEM, DeptID)
VALUES (NEXTVAL('student_id_seq'), 'Dave', 23, 'Male', 75, 5, 1);

-- ─── ORACLE: CREATE SEQUENCE ──────────────────────────────────────────────────

-- Oracle has no SERIAL — you always create a sequence explicitly
-- Then use sequence_name.NEXTVAL in INSERT

-- CREATE SEQUENCE student_id_seq
--   START WITH 1
--   INCREMENT BY 1
--   NOCYCLE;

-- INSERT INTO Student (ID, Name, Age, Gender, Marks, SEM, DeptID)
-- VALUES (student_id_seq.NEXTVAL, 'Alice', 20, 'Female', 85, 7, 2);

-- CURRVAL — current value (Oracle + PostgreSQL, after calling NEXTVAL once):
-- SELECT student_id_seq.CURRVAL FROM DUAL;   -- Oracle
-- SELECT CURRVAL('student_id_seq');           -- PostgreSQL

-- ─── ORACLE: IDENTITY COLUMN (Oracle 12c+) ────────────────────────────────────

-- Oracle 12c introduced GENERATED AS IDENTITY — similar to PostgreSQL SERIAL
-- CREATE TABLE Student
-- (
--   ID   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--   Name VARCHAR2(30)
-- );
-- INSERT INTO Student (Name) VALUES ('Alice');  -- ID filled automatically

-- ─── ALTER SEQUENCE ───────────────────────────────────────────────────────────

-- Change sequence settings after creation
-- Oracle / PostgreSQL: similar syntax

-- PostgreSQL:
ALTER SEQUENCE student_id_seq RESTART WITH 1;   -- reset counter to 1
ALTER SEQUENCE student_id_seq INCREMENT BY 5;   -- change step to 5

-- ─── DROP SEQUENCE ────────────────────────────────────────────────────────────

-- Oracle / PostgreSQL: same syntax
DROP SEQUENCE student_id_seq;

-- ─── SEQUENCES SUMMARY ────────────────────────────────────────────────────────
--
--                    Oracle                  PostgreSQL
--  Auto-increment    SEQUENCE + NEXTVAL       SERIAL  (or CREATE SEQUENCE)
--  Shorthand         IDENTITY (12c+)          SERIAL / BIGSERIAL
--  Next value        seq.NEXTVAL              NEXTVAL('seq')
--  Current value     seq.CURRVAL              CURRVAL('seq')
--  Reset             ALTER SEQUENCE           ALTER SEQUENCE RESTART WITH n
--
--  Key points:
--    NEXTVAL  → always moves forward, cannot go back
--    Gaps are normal — a rolled-back INSERT still consumed a number
--    Use BIGSERIAL / BIGINT for large tables (INTEGER max ~2.1 billion)
