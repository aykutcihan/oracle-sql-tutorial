-- Active: 1779203852153@@127.0.0.1@5444@learning

-- AND: Both conditions must be true
-- OR: At least one condition must be true
-- Syntax: WHERE condition1 AND/OR condition2

-- Female students with marks greater than 88 (both must be true)
SELECT * FROM Student WHERE Gender = 'FEMALE' AND Marks > 88;

-- Students in semester 7 OR with marks greater than 95 (either one)
SELECT * FROM Student WHERE SEM = 7 OR Marks > 95;

-- Male students in semester 8
SELECT * FROM Student WHERE Gender = 'MALE' AND SEM = 8;

-- Students younger than 21 or older than 25
SELECT * FROM Student WHERE Age < 21 OR Age > 25;


-- OPERATOR PRECEDENCE (evaluation order when mixed together):
--   1. Comparison operators first  (>, <, >=, <=, =, !=)
--   2. AND second
--   3. OR last
--
-- This means AND binds tighter than OR — just like * before + in math.
--
-- Example:
--   WHERE Gender = 'FEMALE' OR SEM = 8 AND Marks > 90
--   SQL reads this as:
--   WHERE Gender = 'FEMALE' OR (SEM = 8 AND Marks > 90)
--   → returns all females + male students in sem 8 with marks > 90
--
-- To override the order, use parentheses ():
--   WHERE (Gender = 'FEMALE' OR SEM = 8) AND Marks > 90
--   → returns only students who are (female OR in sem 8) AND have marks > 90

-- Without parentheses: AND runs first
SELECT * FROM Student WHERE Gender = 'FEMALE' OR SEM = 8 AND Marks > 90;

-- With parentheses: OR runs first
SELECT * FROM Student WHERE (Gender = 'FEMALE' OR SEM = 8) AND Marks > 90;


-- NOT: Reverses/negates a condition
-- Syntax: WHERE NOT condition

-- Students who are NOT female (same as Gender = 'MALE')
SELECT * FROM Student WHERE NOT Gender = 'FEMALE';

-- Students NOT in semester 8
SELECT * FROM Student WHERE NOT SEM = 8;

-- NOT combined with AND: students who are not female AND not in sem 7
SELECT * FROM Student WHERE NOT Gender = 'FEMALE' AND NOT SEM = 7;
