-- Active: 1779203852153@@127.0.0.1@5444@learning

-- CONSTRAINTS: Rules enforced on column data to ensure integrity
-- Defined at column creation (inline) or added later with ALTER TABLE
-- Constraints: NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT
--
-- Summary:
--   NOT NULL     → column cannot be empty / NULL
--   UNIQUE       → all values in the column must be different
--   PRIMARY KEY  → NOT NULL + UNIQUE combined; uniquely identifies each row
--   FOREIGN KEY  → links a column to the PRIMARY KEY of another table
--   CHECK        → value must satisfy a condition
--   DEFAULT      → provides a fallback value when none is given

-- ─── NOT NULL ─────────────────────────────────────────────────────────────────

-- Ensures the column must always have a value — NULL is rejected
-- Oracle / PostgreSQL: same syntax

CREATE TABLE Student_NN
(
  ID     INTEGER     NOT NULL,
  Name   VARCHAR(30) NOT NULL,
  Age    INTEGER,               -- Age is optional (NULL allowed)
  Gender VARCHAR(6)
);

-- This INSERT succeeds:
INSERT INTO Student_NN (ID, Name, Age, Gender) VALUES (1, 'Alice', 20, 'Female');

-- This INSERT fails — Name is NOT NULL:
-- INSERT INTO Student_NN (ID, Name) VALUES (2, NULL);

-- ─── UNIQUE ───────────────────────────────────────────────────────────────────

-- Ensures no two rows have the same value in this column
-- NULL is allowed (a NULL is not considered equal to another NULL)
-- Oracle / PostgreSQL: same syntax

CREATE TABLE Student_UQ
(
  ID     INTEGER     UNIQUE,
  Name   VARCHAR(30) NOT NULL,
  Email  VARCHAR(50) UNIQUE
);

-- This INSERT succeeds:
INSERT INTO Student_UQ (ID, Name, Email) VALUES (1, 'Alice', 'alice@mail.com');

-- This INSERT fails — ID 1 already exists:
-- INSERT INTO Student_UQ (ID, Name, Email) VALUES (1, 'Bob', 'bob@mail.com');

-- Add UNIQUE constraint to an existing column:
-- Oracle / PostgreSQL:
ALTER TABLE Student_UQ ADD CONSTRAINT uq_email UNIQUE (Email);

-- ─── PRIMARY KEY ──────────────────────────────────────────────────────────────

-- Combines NOT NULL + UNIQUE
-- Each table can have only ONE primary key
-- Can span multiple columns → called a COMPOSITE primary key
-- Oracle / PostgreSQL: same syntax

-- Inline (column-level) definition:
CREATE TABLE Department
(
  DeptID   INTEGER     PRIMARY KEY,
  DeptName VARCHAR(30) NOT NULL,
  HOD      VARCHAR(30)
);

-- Table-level definition (required for composite primary key):
CREATE TABLE Enrollment
(
  StudentID INTEGER,
  CourseID  INTEGER,
  Grade     VARCHAR(2),
  CONSTRAINT pk_enrollment PRIMARY KEY (StudentID, CourseID)
);

-- Add PRIMARY KEY to an existing table:
-- ALTER TABLE Department ADD CONSTRAINT pk_dept PRIMARY KEY (DeptID);

-- ─── FOREIGN KEY ──────────────────────────────────────────────────────────────

-- Links a column in one table to the PRIMARY KEY in another table
-- The referenced table must exist first
-- Values in the FK column must exist in the referenced PK column (or be NULL)
-- Oracle / PostgreSQL: same syntax

CREATE TABLE Student_FK
(
  ID     INTEGER PRIMARY KEY,
  Name   VARCHAR(30) NOT NULL,
  DeptID INTEGER,
  CONSTRAINT fk_dept FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- This INSERT succeeds if DeptID 10 exists in Department:
-- INSERT INTO Student_FK VALUES (1, 'Alice', 10);

-- This INSERT fails — DeptID 99 does not exist in Department:
-- INSERT INTO Student_FK VALUES (2, 'Bob', 99);

-- ON DELETE CASCADE: when the parent row is deleted, child rows are also deleted
-- ON DELETE SET NULL: when the parent row is deleted, FK column becomes NULL
CREATE TABLE Student_FK2
(
  ID     INTEGER PRIMARY KEY,
  Name   VARCHAR(30) NOT NULL,
  DeptID INTEGER,
  CONSTRAINT fk_dept2 FOREIGN KEY (DeptID)
    REFERENCES Department(DeptID)
    ON DELETE CASCADE
);

-- Add FK to an existing table:
-- ALTER TABLE Student_FK ADD CONSTRAINT fk_dept
--   FOREIGN KEY (DeptID) REFERENCES Department(DeptID);

-- ─── CHECK ────────────────────────────────────────────────────────────────────

-- Ensures the column value satisfies a condition
-- Any boolean expression can be used
-- Oracle / PostgreSQL: same syntax

CREATE TABLE Student_CHK
(
  ID     INTEGER     PRIMARY KEY,
  Name   VARCHAR(30) NOT NULL,
  Age    INTEGER     CHECK (Age >= 18 AND Age <= 60),
  Gender VARCHAR(6)  CHECK (Gender IN ('Male', 'Female', 'Other')),
  Marks  INTEGER     CHECK (Marks >= 0 AND Marks <= 100)
);

-- This INSERT succeeds:
INSERT INTO Student_CHK VALUES (1, 'Alice', 20, 'Female', 85);

-- This INSERT fails — Age violates CHECK:
-- INSERT INTO Student_CHK VALUES (2, 'Bob', 15, 'Male', 90);

-- This INSERT fails — Gender not in allowed list:
-- INSERT INTO Student_CHK VALUES (3, 'Carol', 22, 'Unknown', 70);

-- Add CHECK constraint to existing table:
ALTER TABLE Student_CHK ADD CONSTRAINT chk_marks CHECK (Marks >= 0);

-- ─── DEFAULT ──────────────────────────────────────────────────────────────────

-- Provides a value when no value is supplied on INSERT
-- Without DEFAULT, an omitted column gets NULL
-- Oracle / PostgreSQL: same syntax

CREATE TABLE Student_DEF
(
  ID        INTEGER     PRIMARY KEY,
  Name      VARCHAR(30) NOT NULL,
  Gender    VARCHAR(6)  DEFAULT 'Unknown',
  IsActive  BOOLEAN     DEFAULT TRUE,          -- PostgreSQL only
  CreatedAt TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- This INSERT uses the defaults for Gender, IsActive, CreatedAt:
INSERT INTO Student_DEF (ID, Name) VALUES (1, 'Alice');

-- Verify: Gender = 'Unknown', IsActive = TRUE, CreatedAt = now
SELECT * FROM Student_DEF;

-- Modify DEFAULT on an existing column:
-- Oracle:     ALTER TABLE Student_DEF MODIFY Gender DEFAULT 'Other';
-- PostgreSQL: ALTER TABLE Student_DEF ALTER COLUMN Gender SET DEFAULT 'Other';

-- Remove DEFAULT:
-- Oracle:     ALTER TABLE Student_DEF MODIFY Gender DEFAULT NULL;
-- PostgreSQL: ALTER TABLE Student_DEF ALTER COLUMN Gender DROP DEFAULT;

-- ─── NAMING CONSTRAINTS ───────────────────────────────────────────────────────

-- Giving constraints names makes error messages readable and lets you DROP them
-- Use CONSTRAINT keyword before the constraint type
-- Convention: pk_table, fk_table_col, uq_table_col, chk_table_col

CREATE TABLE Course
(
  CourseID   INTEGER,
  CourseName VARCHAR(50),
  DeptID     INTEGER,
  Credits    INTEGER,
  CONSTRAINT pk_course  PRIMARY KEY (CourseID),
  CONSTRAINT fk_course_dept FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
  CONSTRAINT chk_credits CHECK (Credits BETWEEN 1 AND 6),
  CONSTRAINT uq_course_name UNIQUE (CourseName)
);

-- ─── DROP A CONSTRAINT ────────────────────────────────────────────────────────

-- Oracle / PostgreSQL: same syntax (requires constraint name)
-- ALTER TABLE Course DROP CONSTRAINT chk_credits;

-- ─── VIEW ALL CONSTRAINTS (PostgreSQL) ────────────────────────────────────────

-- SELECT constraint_name, constraint_type, table_name
-- FROM information_schema.table_constraints
-- WHERE table_name = 'course';

-- ─── CONSTRAINTS SUMMARY ──────────────────────────────────────────────────────
--
--  Constraint    NULL allowed?   Unique?   One per table?   Spans tables?
--  NOT NULL      NO              NO        NO               NO
--  UNIQUE        YES (NULLs ok)  YES       NO               NO
--  PRIMARY KEY   NO              YES       YES              NO
--  FOREIGN KEY   YES             NO        NO               YES (ref. PK)
--  CHECK         YES             NO        NO               NO
--  DEFAULT       YES             NO        NO               NO
