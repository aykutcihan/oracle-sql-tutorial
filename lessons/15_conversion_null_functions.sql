-- Active: 1779203852153@@127.0.0.1@5444@learning

-- CONVERSION & NULL FUNCTIONS
-- TO_CHAR : converts a number or date to a formatted string
-- COALESCE: returns the first non-NULL value from a list
-- NULLIF  : returns NULL if two values are equal, otherwise returns the first value

-- ─── TO_CHAR ──────────────────────────────────────────────────────────────────

-- TO_CHAR: converts a number or date into a formatted text string
-- Oracle:     TO_CHAR(value, format)
-- PostgreSQL: TO_CHAR(value, format)  ← identical

-- Number formatting:
--   9 → digit position (shows nothing if no digit)
--   0 → digit position (shows 0 if no digit)
--   . → decimal point
--   , → thousands separator
--   $ → dollar sign prefix

SELECT TO_CHAR(1234567, '9,999,999');     -- → ' 1,234,567'
SELECT TO_CHAR(1234.5, '9999.99');        -- → '1234.50'
SELECT TO_CHAR(98, '000');               -- → '098'  (leading zeros)
SELECT TO_CHAR(Marks, '999') FROM Student;

-- Date formatting:
--   YYYY → 4-digit year
--   MM   → 2-digit month
--   DD   → 2-digit day
--   HH24 → hour (24-hour clock)
--   MI   → minutes
--   SS   → seconds
--   MON  → abbreviated month name (JAN, FEB...)
--   DAY  → full day name (MONDAY, TUESDAY...)

SELECT TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY');          -- → '19/05/2026'
SELECT TO_CHAR(CURRENT_DATE, 'DD MON YYYY');         -- → '19 MAY 2026'
SELECT TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS');  -- → '19/05/2026 14:30:00'
SELECT TO_CHAR(CURRENT_DATE, 'DAY, DD MONTH YYYY');  -- → 'TUESDAY, 19 MAY 2026'

-- ─── COALESCE ─────────────────────────────────────────────────────────────────

-- COALESCE: returns the FIRST value in the list that is NOT NULL
-- Syntax: COALESCE(value1, value2, value3, ...)
-- Oracle: NVL(column, default)       ← takes only 2 arguments
-- PostgreSQL: COALESCE(column, default) ← same behavior, but can take many arguments

-- If Marks is NULL, show 0 instead
SELECT Name, COALESCE(Marks, 0) AS Marks FROM Student;

-- If SEM is NULL, show 0 instead
SELECT Name, COALESCE(SEM, 0) AS SEM FROM Student;

-- COALESCE with multiple fallbacks: first non-NULL wins
SELECT Name, COALESCE(Marks, SEM, 0) AS First_Available FROM Student;
-- → if Marks is not NULL → use Marks
-- → if Marks is NULL but SEM is not NULL → use SEM
-- → if both are NULL → use 0

-- Oracle equivalent (NVL) — does NOT work in PostgreSQL:
-- SELECT NVL(Marks, 0) FROM Student;   ← Oracle only

-- ─── NULLIF ───────────────────────────────────────────────────────────────────

-- NULLIF: compares two values — if they are EQUAL returns NULL, otherwise returns the first value
-- Syntax: NULLIF(value1, value2)
-- Oracle: NULLIF(v1, v2)   PostgreSQL: NULLIF(v1, v2)  ← identical
-- Main use: prevent division by zero errors

SELECT NULLIF(10, 10);    -- → NULL   (values are equal)
SELECT NULLIF(10, 5);     -- → 10     (values are different, return first)
SELECT NULLIF(0, 0);      -- → NULL

-- Division by zero protection:
-- If we divide by a column that could be 0, it would cause an error
-- NULLIF turns 0 into NULL, and dividing by NULL returns NULL instead of error

-- Without NULLIF: this would crash if SEM = 0
-- SELECT Marks / SEM FROM Student;

-- With NULLIF: safely returns NULL when SEM is 0
SELECT Name, Marks, SEM, Marks / NULLIF(SEM, 0) AS Marks_Per_Sem FROM Student;
