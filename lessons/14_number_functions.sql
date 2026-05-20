-- Active: 1779203852153@@127.0.0.1@5444@learning

-- NUMBER FUNCTIONS: Built-in functions that perform calculations on numeric values
-- Oracle and PostgreSQL share most of these with identical syntax

-- ─── ROUND ────────────────────────────────────────────────────────────────────

-- ROUND: rounds a number to a specified number of decimal places
-- ROUND(number, decimal_places)
-- If decimal_places is omitted, rounds to nearest whole number
-- Oracle: ROUND(n, d)   PostgreSQL: ROUND(n, d)  ← identical

SELECT ROUND(98.6);        -- → 99    (no decimal places = round to integer)
SELECT ROUND(98.4);        -- → 98
SELECT ROUND(98.567, 2);   -- → 98.57 (round to 2 decimal places)
SELECT ROUND(98.561, 1);   -- → 98.6  (round to 1 decimal place)
SELECT ROUND(-98.6);       -- → -99

SELECT Name, Marks, ROUND(Marks / 3.0, 2) AS Marks_Third FROM Student;

-- ─── TRUNC ────────────────────────────────────────────────────────────────────

-- TRUNC: removes (truncates) decimal digits WITHOUT rounding
-- Always cuts off — never rounds up
-- Oracle:     TRUNC(number, decimal_places)
-- PostgreSQL: TRUNC(number, decimal_places)  ← identical

SELECT TRUNC(98.9);        -- → 98    (just cuts off decimals, no rounding)
SELECT TRUNC(98.6);        -- → 98    (98.6 stays 98, NOT 99)
SELECT TRUNC(98.567, 2);   -- → 98.56 (cut after 2 decimal places)
SELECT TRUNC(98.567, 1);   -- → 98.5

-- ROUND vs TRUNC comparison:
SELECT ROUND(98.6), TRUNC(98.6);   -- → 99  vs  98

SELECT Name, Marks, TRUNC(Marks / 3.0, 2) AS Truncated FROM Student;

-- ─── MOD ──────────────────────────────────────────────────────────────────────

-- MOD: returns the remainder after division (modulo)
-- MOD(number, divisor)
-- Oracle: MOD(n, d)   PostgreSQL: MOD(n, d)  ← identical
-- Also: n % d works in PostgreSQL as shorthand

SELECT MOD(10, 3);    -- → 1   (10 ÷ 3 = 3 remainder 1)
SELECT MOD(10, 2);    -- → 0   (10 ÷ 2 = 5 remainder 0 → even number)
SELECT MOD(7, 2);     -- → 1   (7 ÷ 2 = 3 remainder 1 → odd number)
SELECT MOD(15, 4);    -- → 3   (15 ÷ 4 = 3 remainder 3)

-- Common use: check if a number is even or odd
-- Even: MOD(number, 2) = 0
-- Odd:  MOD(number, 2) = 1
SELECT * FROM Student WHERE MOD(ID, 2) = 0;   -- students with even ID
SELECT * FROM Student WHERE MOD(ID, 2) = 1;   -- students with odd ID

-- ─── ABS ──────────────────────────────────────────────────────────────────────

-- ABS: returns the absolute value (removes negative sign)
-- Oracle: ABS(n)   PostgreSQL: ABS(n)  ← identical
SELECT ABS(-50);      -- → 50
SELECT ABS(50);       -- → 50

-- ─── POWER / SQRT ─────────────────────────────────────────────────────────────

-- POWER: raises a number to a power
-- Oracle: POWER(base, exponent)   PostgreSQL: POWER(base, exponent)  ← identical
SELECT POWER(2, 10);   -- → 1024  (2 to the power of 10)
SELECT POWER(3, 3);    -- → 27

-- SQRT: returns the square root
-- Oracle: SQRT(n)   PostgreSQL: SQRT(n)  ← identical
SELECT SQRT(144);      -- → 12
SELECT SQRT(2);        -- → 1.4142...
