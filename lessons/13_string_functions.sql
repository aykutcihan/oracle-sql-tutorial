-- Active: 1779203852153@@127.0.0.1@5444@learning

-- STRING FUNCTIONS: Built-in functions that manipulate text values
-- Can be used on column values or on literal strings
-- Oracle and PostgreSQL share most of these, with small differences noted below

-- ─── UPPER / LOWER / INITCAP ──────────────────────────────────────────────────

-- UPPER: converts all characters to uppercase
-- Oracle: UPPER(string)   PostgreSQL: UPPER(string)  ← identical
SELECT UPPER('hello world');           -- → HELLO WORLD
SELECT Name, UPPER(Name) FROM Student;

-- LOWER: converts all characters to lowercase
-- Oracle: LOWER(string)   PostgreSQL: LOWER(string)  ← identical
SELECT LOWER('HELLO WORLD');           -- → hello world
SELECT Name, LOWER(Name) FROM Student;

-- INITCAP: capitalizes the first letter of each word, rest lowercase
-- Oracle: INITCAP(string)   PostgreSQL: INITCAP(string)  ← identical
SELECT INITCAP('hello world');         -- → Hello World
SELECT INITCAP('AMAN');                -- → Aman
SELECT Name, INITCAP(Name) FROM Student;

-- ─── LENGTH ───────────────────────────────────────────────────────────────────

-- LENGTH: returns the number of characters in a string
-- Oracle: LENGTH(string)   PostgreSQL: LENGTH(string)  ← identical
SELECT LENGTH('Oracle SQL');           -- → 10
SELECT Name, LENGTH(Name) AS Name_Length FROM Student;

-- ─── CONCAT ───────────────────────────────────────────────────────────────────

-- CONCAT: joins two strings together (same as || operator)
-- Oracle: CONCAT(str1, str2)   PostgreSQL: CONCAT(str1, str2)  ← identical
-- Note: CONCAT only takes 2 arguments in Oracle; use || to chain more
SELECT CONCAT('Hello', ' World');      -- → Hello World
SELECT CONCAT(Name, ' is a student') FROM Student;

-- ─── SUBSTR ───────────────────────────────────────────────────────────────────

-- SUBSTR: extracts a portion of a string
-- Oracle:     SUBSTR(string, start_position, length)
-- PostgreSQL: SUBSTR(string, start_position, length)  ← identical
-- Position starts at 1 (not 0)
SELECT SUBSTR('Oracle SQL', 1, 6);    -- → Oracle  (start at 1, take 6 chars)
SELECT SUBSTR('Oracle SQL', 8, 3);    -- → SQL     (start at 8, take 3 chars)
SELECT SUBSTR('Oracle SQL', 8);       -- → SQL     (start at 8, take rest)
SELECT Name, SUBSTR(Name, 1, 3) AS First3 FROM Student;

-- ─── INSTR ────────────────────────────────────────────────────────────────────

-- INSTR: finds the position of a substring inside a string
-- Returns the position number (starting from 1), or 0 if not found
-- Oracle:     INSTR(string, substring)       ← Oracle only, does NOT work in PostgreSQL
-- PostgreSQL: POSITION(substring IN string)  ← different syntax
--             or STRPOS(string, substring)   ← PostgreSQL shorthand

-- Oracle syntax — does NOT run in PostgreSQL:
-- SELECT INSTR('Oracle SQL', 'SQL');    -- → 8
-- SELECT INSTR('Oracle SQL', 'xyz');    -- → 0

-- PostgreSQL equivalents (use these):
SELECT POSITION('SQL' IN 'Oracle SQL');   -- → 8  (found at position 8)
SELECT POSITION('xyz' IN 'Oracle SQL');   -- → 0  (not found)

SELECT STRPOS('Oracle SQL', 'SQL');       -- → 8
SELECT STRPOS('Oracle SQL', 'xyz');       -- → 0

-- ─── TRIM / LTRIM / RTRIM ─────────────────────────────────────────────────────

-- TRIM: removes spaces (or specified characters) from both sides
-- LTRIM: removes from the left side only
-- RTRIM: removes from the right side only
-- Oracle: TRIM / LTRIM / RTRIM   PostgreSQL: TRIM / LTRIM / RTRIM  ← identical

SELECT TRIM('   hello   ');            -- → 'hello'
SELECT LTRIM('   hello   ');           -- → 'hello   '
SELECT RTRIM('   hello   ');           -- → '   hello'

-- Trimming a specific character (remove leading/trailing zeros)
SELECT TRIM('0' FROM '000123000');     -- → '123'

-- ─── LPAD / RPAD ──────────────────────────────────────────────────────────────

-- LPAD: pads a string on the LEFT to reach a target length
-- RPAD: pads a string on the RIGHT to reach a target length
-- Oracle: LPAD(string, length, pad_char)   PostgreSQL: same  ← identical
-- Useful for formatting output (aligning columns, leading zeros)

SELECT LPAD('42', 6, '0');            -- → '000042'  (pad left with zeros)
SELECT RPAD('42', 6, '0');            -- → '420000'  (pad right with zeros)
SELECT LPAD('SQL', 10, '-');          -- → '-------SQL'
SELECT RPAD('SQL', 10, '-');          -- → 'SQL-------'

SELECT Name, LPAD(Name, 10, '.') AS Padded FROM Student;
