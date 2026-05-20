-- Active: 1779203852153@@127.0.0.1@5444@learning

-- INDEXES: Data structures that speed up SELECT queries
-- Without an index, the database scans every row (full table scan)
-- With an index, the database jumps directly to the matching rows
-- Trade-off: faster reads, but slightly slower INSERT/UPDATE/DELETE
--
-- Summary:
--   CREATE INDEX        → create a standard (non-unique) index
--   CREATE UNIQUE INDEX → index that also enforces uniqueness
--   DROP INDEX          → remove an index
--   PRIMARY KEY / UNIQUE constraints automatically create an index

-- ─── WHY USE INDEXES ──────────────────────────────────────────────────────────

-- Imagine 1 million rows in Student table.
-- Without index: SELECT * FROM Student WHERE Name = 'Alice'
--   → database reads all 1,000,000 rows (full table scan) — slow
-- With index on Name: same query
--   → database jumps to 'Alice' entries instantly — fast

-- ─── CREATE INDEX ─────────────────────────────────────────────────────────────

-- Creates an index on one or more columns
-- Oracle / PostgreSQL: same syntax

-- Single-column index:
CREATE INDEX idx_student_name ON Student(Name);

-- Multi-column (composite) index:
-- Use when queries filter on multiple columns together
CREATE INDEX idx_student_sem_dept ON Student(SEM, DeptID);

-- ─── CREATE UNIQUE INDEX ──────────────────────────────────────────────────────

-- Like a regular index but also enforces uniqueness (no duplicate values)
-- Alternative to UNIQUE constraint — same effect, slightly more control
-- Oracle / PostgreSQL: same syntax

CREATE UNIQUE INDEX idx_student_id ON Student(ID);

-- ─── DROP INDEX ───────────────────────────────────────────────────────────────

-- Removes an index — does NOT affect the table data
-- Oracle:     DROP INDEX index_name;
-- PostgreSQL: DROP INDEX index_name;

DROP INDEX idx_student_name;

-- IF EXISTS (PostgreSQL only):
DROP INDEX IF EXISTS idx_student_sem_dept;

-- ─── INDEXES CREATED AUTOMATICALLY ───────────────────────────────────────────

-- PRIMARY KEY  → database automatically creates a unique index
-- UNIQUE       → database automatically creates a unique index
-- You do NOT need to create these manually

-- ─── WHEN TO USE AN INDEX ─────────────────────────────────────────────────────

-- Good candidates for indexing:
--   - Columns used frequently in WHERE clauses
--   - Columns used in JOIN conditions
--   - Columns used in ORDER BY (can avoid a sort operation)
--   - Foreign key columns

-- Bad candidates (not worth indexing):
--   - Columns with very few distinct values (e.g. Gender: only Male/Female)
--   - Small tables (full scan is already fast)
--   - Columns that are rarely queried

-- ─── VIEW INDEXES (PostgreSQL) ────────────────────────────────────────────────

-- List all indexes on a table:
-- SELECT indexname, indexdef
-- FROM pg_indexes
-- WHERE tablename = 'student';

-- ─── VIEW INDEXES (Oracle) ────────────────────────────────────────────────────

-- SELECT index_name, column_name, uniqueness
-- FROM user_indexes
-- JOIN user_ind_columns USING (index_name)
-- WHERE table_name = 'STUDENT';

-- ─── INDEXES SUMMARY ──────────────────────────────────────────────────────────
--
--  Index type         Unique?   Auto-created?   Use case
--  Regular index      NO        NO              Speed up WHERE / JOIN / ORDER BY
--  Unique index       YES       NO              Speed up + enforce uniqueness
--  PK index           YES       YES             Automatically from PRIMARY KEY
--  UNIQUE constraint  YES       YES             Automatically from UNIQUE
--
--  Rule of thumb:
--    Index columns you filter or join on frequently.
--    Too many indexes slow down writes — index only what you need.
