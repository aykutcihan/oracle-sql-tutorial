-- Active: 1779203852153@@127.0.0.1@5444@learning

-- DDL: Data Definition Language
-- Commands that define or change the STRUCTURE of database objects
-- DDL does NOT touch data — it changes the skeleton (table structure)
-- DDL commands: CREATE, ALTER, DROP, TRUNCATE
-- CREATE was covered in 01_create_table.sql
--
-- Summary:
--   CREATE   → create a new table
--   ALTER    → modify an existing table structure (add/drop/rename/retype column)
--   DROP     → permanently delete the entire table and all its data
--   TRUNCATE → delete all rows but keep the table structure

-- ─── ALTER TABLE: ADD COLUMN ──────────────────────────────────────────────────

-- Adds a new column to an existing table
-- All existing rows get NULL for the new column automatically
-- Oracle:     ALTER TABLE table_name ADD column_name data_type;
-- PostgreSQL: ALTER TABLE table_name ADD COLUMN column_name data_type;

-- Add a single column
ALTER TABLE Student ADD COLUMN Email VARCHAR(50);

-- Verify: Email column now exists, all existing rows have NULL for Email
SELECT * FROM Student;

-- Add another column
ALTER TABLE Student ADD COLUMN Phone VARCHAR(15);

-- PostgreSQL: add multiple columns at once
ALTER TABLE Student ADD COLUMN City VARCHAR(30), ADD COLUMN ZipCode VARCHAR(10);

-- Verify all new columns
SELECT ID, Name, Email, Phone, City, ZipCode FROM Student;

-- ─── ALTER TABLE: DROP COLUMN ─────────────────────────────────────────────────

-- Removes a column from the table permanently — data in that column is lost
-- Oracle:     ALTER TABLE table_name DROP COLUMN column_name;
-- PostgreSQL: ALTER TABLE table_name DROP COLUMN column_name;

ALTER TABLE Student DROP COLUMN Email;
ALTER TABLE Student DROP COLUMN Phone;
ALTER TABLE Student DROP COLUMN City;
ALTER TABLE Student DROP COLUMN ZipCode;

-- Verify columns are gone
SELECT * FROM Student;

-- ─── ALTER TABLE: RENAME COLUMN ───────────────────────────────────────────────

-- Renames a column — column data is preserved, only the name changes
-- Oracle:     ALTER TABLE table_name RENAME COLUMN old_name TO new_name;
-- PostgreSQL: ALTER TABLE table_name RENAME COLUMN old_name TO new_name;

ALTER TABLE Student RENAME COLUMN SEM TO Semester;

-- Verify new name
SELECT Name, Semester FROM Student;

-- Rename it back
ALTER TABLE Student RENAME COLUMN Semester TO SEM;

-- ─── ALTER TABLE: RENAME TABLE ────────────────────────────────────────────────

-- Renames the table itself — all data and structure is preserved
-- Oracle:     RENAME old_table_name TO new_table_name;
-- PostgreSQL: ALTER TABLE old_table_name RENAME TO new_table_name;

ALTER TABLE Student RENAME TO Students;

-- Verify: now must use new name
SELECT * FROM Students;

-- Rename it back
ALTER TABLE Students RENAME TO Student;

-- ─── ALTER TABLE: CHANGE COLUMN TYPE ─────────────────────────────────────────

-- Changes the data type of an existing column
-- Oracle:     ALTER TABLE table_name MODIFY column_name new_data_type;
-- PostgreSQL: ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;

-- Oracle syntax (does NOT work in PostgreSQL):
--   ALTER TABLE Student MODIFY Age VARCHAR(5);

-- PostgreSQL syntax: change Age from INTEGER to VARCHAR
ALTER TABLE Student ALTER COLUMN Age TYPE VARCHAR(5);

-- Verify
SELECT ID, Name, Age FROM Student;

-- Change it back to INTEGER
-- USING is required when PostgreSQL cannot convert the type automatically
ALTER TABLE Student ALTER COLUMN Age TYPE INTEGER USING Age::INTEGER;

-- ─── DROP TABLE ───────────────────────────────────────────────────────────────

-- Permanently deletes the entire table AND all its data
-- Table structure is gone, data is gone — CANNOT be undone
-- Oracle:     DROP TABLE table_name;
-- PostgreSQL: DROP TABLE table_name;

-- Examples (commented out to protect our data):
-- DROP TABLE Student;

-- IF EXISTS: prevents error if the table does not exist
-- DROP TABLE IF EXISTS Student;

-- Typical use: drop and recreate a table from scratch
-- DROP TABLE IF EXISTS Student;
-- CREATE TABLE Student ( ID INTEGER, Name VARCHAR(30), ... );

-- ─── TRUNCATE TABLE ───────────────────────────────────────────────────────────

-- Deletes ALL rows but keeps the table structure
-- Table remains, columns remain, data is gone
-- Much faster than DELETE — does not log individual row deletions
-- Oracle:     TRUNCATE TABLE table_name;
-- PostgreSQL: TRUNCATE TABLE table_name;

-- Example (commented out to protect our data):
-- TRUNCATE TABLE Student;

-- After TRUNCATE:
--   SELECT * FROM Student;   → 0 rows returned
--   Table still exists       → can INSERT new rows immediately
--   SELECT COUNT(*) FROM Student;  → 0

-- TRUNCATE multiple tables at once (PostgreSQL):
-- TRUNCATE TABLE Student, Department, Course;

-- ─── DROP vs TRUNCATE vs DELETE ───────────────────────────────────────────────
--
--                  DROP              TRUNCATE            DELETE
-- What is removed  table + data      data only           data only
-- Table stays?     NO                YES                 YES
-- WHERE filter?    NO                NO                  YES
-- Undoable?        NO                NO (Oracle)         YES (with ROLLBACK)
--                                    YES (PostgreSQL)
-- Speed            fast              very fast           slowest
--
-- When to use:
--   DROP     → you no longer need the table at all
--   TRUNCATE → you want to empty the table but keep its structure for reuse
--   DELETE   → you want to remove specific rows (WHERE SEM = 7, etc.)
