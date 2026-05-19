-- Active: 1779203852153@@127.0.0.1@5444@learning

-- DUAL TABLE (Oracle concept)
-- In Oracle, DUAL is a special built-in table with exactly 1 row and 1 column (DUMMY VARCHAR2(1))
-- It exists only because Oracle requires a FROM clause in every SELECT statement
-- Without DUAL, you cannot run a SELECT that doesn't read from a real table
--
-- Structure of DUAL:
--   Column: DUMMY  VARCHAR2(1)
--   Row:    'X'
--
-- PostgreSQL does NOT have this restriction — FROM clause is optional
-- PostgreSQL does NOT have a DUAL table (and doesn't need one)
--
-- RULE:
--   Oracle:     SELECT expression FROM DUAL;   ← FROM DUAL required
--   PostgreSQL: SELECT expression;             ← no FROM needed

-- ─── ARITHMETIC ───────────────────────────────────────────────────────────────

-- Oracle:     SELECT 10 + 5    FROM DUAL;
SELECT 10 + 5;          -- addition        → 15

-- Oracle:     SELECT 100 - 37 FROM DUAL;
SELECT 100 - 37;        -- subtraction     → 63

-- Oracle:     SELECT 6 * 7    FROM DUAL;
SELECT 6 * 7;           -- multiplication  → 42

-- Oracle:     SELECT 100 / 4  FROM DUAL;
SELECT 100 / 4;         -- division        → 25

-- Operator precedence: * and / before + and -  (same as math)
-- Oracle:     SELECT 10 + 2 * 5 FROM DUAL;
SELECT 10 + 2 * 5;      -- = 20  (multiplication runs first)

-- Oracle:     SELECT (10 + 2) * 5 FROM DUAL;
SELECT (10 + 2) * 5;    -- = 60  (parentheses override precedence)

-- ─── DATE / TIME ──────────────────────────────────────────────────────────────

-- Oracle:     SELECT SYSDATE        FROM DUAL;   ← returns current date+time
-- PostgreSQL: SELECT CURRENT_DATE;              ← date only
SELECT CURRENT_DATE;

-- Oracle:     SELECT SYSTIMESTAMP   FROM DUAL;   ← date+time+timezone
-- PostgreSQL: SELECT CURRENT_TIMESTAMP;
SELECT CURRENT_TIMESTAMP;

-- PostgreSQL also has NOW() — same as CURRENT_TIMESTAMP, not available in Oracle
-- Oracle:     (no equivalent shorthand)
SELECT NOW();

-- ─── STRING EXPRESSIONS ───────────────────────────────────────────────────────

-- Oracle:     SELECT 'Hello, World!'           FROM DUAL;
SELECT 'Hello, World!';

-- Oracle:     SELECT 'Oracle' || ' ' || 'SQL'  FROM DUAL;
SELECT 'Oracle' || ' ' || 'SQL';   -- concatenation without a table

-- ─── TESTING FUNCTIONS ────────────────────────────────────────────────────────

-- Oracle:     SELECT UPPER('hello')    FROM DUAL;
SELECT UPPER('hello');              -- → HELLO

-- Oracle:     SELECT LENGTH('Oracle SQL') FROM DUAL;
SELECT LENGTH('Oracle SQL');        -- → 10

-- Oracle:     SELECT ROUND(98.6)       FROM DUAL;
SELECT ROUND(98.6);                 -- → 99

-- ─── MULTIPLE EXPRESSIONS AT ONCE ────────────────────────────────────────────

-- Oracle:     SELECT SYSDATE, 2+2 AS Result FROM DUAL;
SELECT CURRENT_DATE, NOW(), 2 + 2 AS Result;

-- ─── COMPATIBILITY NOTE ───────────────────────────────────────────────────────
-- If you want Oracle-style "FROM DUAL" to work in PostgreSQL without rewriting
-- every query, you can create a DUAL table manually once:
--
--   CREATE TABLE DUAL AS SELECT 'X' AS DUMMY;
--
-- After that, Oracle queries copied as-is will run in PostgreSQL too.
-- But for new queries written in PostgreSQL, simply omit FROM DUAL.
