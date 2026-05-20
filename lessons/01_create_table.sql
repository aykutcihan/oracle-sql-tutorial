-- Active: 1779203852153@@127.0.0.1@5444@learning

-- CREATE TABLE: Defines a new table and its columns
-- Syntax: CREATE TABLE table_name (column_name data_type, ...);

-- ─── DATA TYPES ───────────────────────────────────────────────────────────────
--
-- NUMERIC TYPES:
--   INTEGER / INT       → whole numbers, no decimals          (e.g. 1, 42, -7)
--                          Oracle: NUMBER(p)  PostgreSQL: INTEGER  ← different!
--   NUMBER(p, s)        → Oracle type: p = total digits, s = decimal digits
--                          e.g. NUMBER(5,2) → 123.45
--                          PostgreSQL equivalent: NUMERIC(p, s) or DECIMAL(p, s)
--   FLOAT / REAL        → approximate decimal numbers         (e.g. 3.14, 9.99)
--   NUMERIC(p, s)       → exact decimal numbers (PostgreSQL)  (e.g. 99.99)
--
-- TEXT TYPES:
--   VARCHAR(n)          → variable-length text, max n chars   (e.g. 'AMAN', 'MALE')
--                          Oracle: VARCHAR2(n)  PostgreSQL: VARCHAR(n)  ← different!
--   VARCHAR2(n)         → Oracle only — preferred over VARCHAR in Oracle
--   CHAR(n)             → fixed-length text, always n chars   (e.g. CHAR(1) → 'M')
--                          pads with spaces if shorter than n
--   TEXT                → unlimited length text (PostgreSQL only, not in Oracle)
--
-- DATE / TIME TYPES:
--   DATE                → stores date (and time in Oracle)
--                          Oracle DATE includes time (year, month, day, hour, min, sec)
--                          PostgreSQL DATE is date only (no time)
--   TIMESTAMP           → date + time + fractional seconds    (both Oracle and PostgreSQL)
--   TIMESTAMP WITH TIME ZONE → includes timezone info         (both)
--
-- OTHER TYPES:
--   BOOLEAN             → true / false (PostgreSQL only — Oracle has no BOOLEAN in SQL)
--   CLOB                → large text data, up to 4GB (Oracle)
--                          PostgreSQL equivalent: TEXT
--   BLOB                → large binary data, e.g. images, files (Oracle)
--                          PostgreSQL equivalent: BYTEA
--
-- ─── ORACLE vs POSTGRESQL KEY DIFFERENCES ────────────────────────────────────
--   Oracle VARCHAR2(n)  → PostgreSQL VARCHAR(n)
--   Oracle NUMBER       → PostgreSQL INTEGER or NUMERIC
--   Oracle DATE         → PostgreSQL TIMESTAMP (Oracle DATE includes time)
--   Oracle CLOB         → PostgreSQL TEXT
--   Oracle BLOB         → PostgreSQL BYTEA
--   PostgreSQL BOOLEAN  → no equivalent in Oracle SQL (use NUMBER(1) in Oracle)
--   PostgreSQL TEXT     → no equivalent in Oracle (use CLOB or VARCHAR2)

CREATE TABLE Student
(
  ID       INTEGER,
  Name     VARCHAR(30),
  Age      INTEGER,
  Gender   VARCHAR(6),
  Marks    INTEGER,
  SEM      INTEGER,
  DeptID   INTEGER
);

CREATE TABLE Department
(
  DeptID   INTEGER,
  DeptName VARCHAR(30),
  HOD      VARCHAR(30)
);

CREATE TABLE Course
(
  CourseID   INTEGER,
  CourseName VARCHAR(50),
  DeptID     INTEGER
);
