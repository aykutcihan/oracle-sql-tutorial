-- Active: 1779203852153@@127.0.0.1@5444@learning

-- LIKE: Searches for a pattern inside a string column
-- Used in WHERE clause instead of = when you don't know the exact value
-- Syntax: WHERE column LIKE 'pattern'
--
-- Two wildcard characters:
--   %  (percent)    → matches ZERO or more characters  (any length)
--   _  (underscore) → matches EXACTLY ONE character
--
-- NOT LIKE: returns rows that do NOT match the pattern

-- ─── % WILDCARD ───────────────────────────────────────────────────────────────

-- Names that START with 'A'  (A followed by anything)
SELECT * FROM Student WHERE Name LIKE 'A%';

-- Names that END with 'N'  (anything before N)
SELECT * FROM Student WHERE Name LIKE '%N';

-- Names that CONTAIN 'HA' anywhere
SELECT * FROM Student WHERE Name LIKE '%HA%';

-- Names that start with 'A' AND end with 'N'
SELECT * FROM Student WHERE Name LIKE 'A%N';

-- ─── _ WILDCARD ───────────────────────────────────────────────────────────────

-- _ matches exactly one character
-- Names where the SECOND letter is 'S'
SELECT * FROM Student WHERE Name LIKE '_S%';

-- Names where the THIRD letter is 'H'
SELECT * FROM Student WHERE Name LIKE '__H%';

-- Names that are exactly 4 characters long
SELECT * FROM Student WHERE Name LIKE '____';

-- Names that are exactly 5 characters long
SELECT * FROM Student WHERE Name LIKE '_____';

-- ─── COMBINING % AND _ ────────────────────────────────────────────────────────

-- Names that start with any letter, second letter is 'I', then anything
SELECT * FROM Student WHERE Name LIKE '_I%';

-- ─── NOT LIKE ─────────────────────────────────────────────────────────────────

-- Names that do NOT start with 'A'
SELECT * FROM Student WHERE Name NOT LIKE 'A%';

-- Names that do NOT contain 'HA'
SELECT * FROM Student WHERE Name NOT LIKE '%HA%';

-- ─── CASE SENSITIVITY NOTE ────────────────────────────────────────────────────
-- In PostgreSQL, LIKE is case-sensitive by default
-- 'aman' LIKE 'A%' → FALSE  (lowercase a does not match uppercase A)
-- Our data is stored in UPPERCASE so patterns must also be UPPERCASE
--
-- To do a case-insensitive search in PostgreSQL, use ILIKE instead of LIKE:
--   SELECT * FROM Student WHERE Name ILIKE 'a%';  → matches AMAN, ALKA, ABHIRAM
--
-- Oracle uses LIKE and handles case sensitivity at the session/column level
