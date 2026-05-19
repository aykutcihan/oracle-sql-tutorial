-- Active: 1779203852153@@127.0.0.1@5444@learning

-- DDL: Data Definition Language
-- Commands that define or change the STRUCTURE of database objects (tables, columns)
-- DDL commands: CREATE, ALTER, DROP, TRUNCATE
-- CREATE was covered in 01_create_table.sql
-- This file covers: ALTER, DROP, TRUNCATE

-- ─── ALTER TABLE ──────────────────────────────────────────────────────────────

-- ALTER TABLE: modifies the structure of an existing table
-- You can: add a column, drop a column, rename a column, change a column's data type

-- ADD COLUMN: adds a new column to the table
-- Oracle:     ALTER TABLE table_name ADD column_name data_type;
-- PostgreSQL: ALTER TABLE table_name ADD COLUMN column_name data_type;
ALTER TABLE Student ADD COLUMN Email VARCHAR(50);

-- Verify the new column was added (Email will be NULL for existing rows)
SELECT * FROM Student;

-- ADD multiple columns at once (PostgreSQL)
-- ALTER TABLE Student ADD COLUMN Phone VARCHAR(15), ADD COLUMN City VARCHAR(30);

-- DROP COLUMN: removes a column from the table permanently
-- Oracle:     ALTER TABLE table_name DROP COLUMN column_name;
-- PostgreSQL: ALTER TABLE table_name DROP COLUMN column_name;
ALTER TABLE Student DROP COLUMN Email;

-- RENAME COLUMN: renames an existing column
-- Oracle:     ALTER TABLE table_name RENAME COLUMN old_name TO new_name;
-- PostgreSQL: ALTER TABLE table_name RENAME COLUMN old_name TO new_name;
ALTER TABLE Student RENAME COLUMN SEM TO Semester;

-- Rename it back
ALTER TABLE Student RENAME COLUMN Semester TO SEM;

-- ALTER COLUMN TYPE: changes the data type of a column
-- Oracle:     ALTER TABLE table_name MODIFY column_name new_data_type;
-- PostgreSQL: ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;
--
-- Oracle syntax (does NOT work in PostgreSQL):
--   ALTER TABLE Student MODIFY Age VARCHAR(5);
--
-- PostgreSQL syntax:
ALTER TABLE Student ALTER COLUMN Age TYPE VARCHAR(5);

-- Change it back to INTEGER
-- Note: casting is needed when converting VARCHAR back to INTEGER in PostgreSQL
ALTER TABLE Student ALTER COLUMN Age TYPE INTEGER USING Age::INTEGER;

-- ─── DROP TABLE ───────────────────────────────────────────────────────────────

-- DROP TABLE: permanently deletes the entire table and all its data
-- This CANNOT be undone — the table and all rows are gone
-- Oracle:     DROP TABLE table_name;
-- PostgreSQL: DROP TABLE table_name;

-- DROP TABLE Student;   ← commented out to avoid accidentally deleting our table

-- DROP TABLE IF EXISTS: no error if the table does not exist
-- DROP TABLE IF EXISTS Student;

-- ─── TRUNCATE TABLE ───────────────────────────────────────────────────────────

-- TRUNCATE: deletes ALL rows from a table but keeps the table structure
-- Faster than DELETE because it does not log individual row deletions
-- Oracle:     TRUNCATE TABLE table_name;
-- PostgreSQL: TRUNCATE TABLE table_name;

-- TRUNCATE TABLE Student;   ← commented out to avoid deleting all our data

-- ─── DROP vs TRUNCATE vs DELETE ───────────────────────────────────────────────
--
--               DROP          TRUNCATE        DELETE
-- Removes       table+data    only data       only data
-- Table stays?  NO            YES             YES
-- WHERE filter? NO            NO              YES (can delete specific rows)
-- Undoable?     NO            NO*             YES (with ROLLBACK)
-- Speed         fast          very fast       slower (logs each row)
--
-- * TRUNCATE can be rolled back in PostgreSQL but NOT in Oracle
