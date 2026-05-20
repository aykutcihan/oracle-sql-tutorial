-- Active: 1779203852153@@127.0.0.1@5444@learning

-- WHERE: Filters rows based on a condition
-- Syntax: SELECT * FROM table_name WHERE condition;
--
-- Comparison Operators:
--   =    equal to
--   !=   not equal to  (also written as <>)
--   >    greater than
--   <    less than
--   >=   greater than or equal to
--   <=   less than or equal to

-- = (equal) : students in semester 8
SELECT * FROM Student WHERE SEM = 8;

-- != (not equal) : students NOT in semester 8
SELECT * FROM Student WHERE SEM != 8;

-- > (greater than) : students with marks above 90
SELECT * FROM Student WHERE Marks > 90;

-- < (less than) : students with marks below 90
SELECT * FROM Student WHERE Marks < 90;

-- >= (greater than or equal) : students with marks 90 or above
SELECT * FROM Student WHERE Marks >= 90;

-- <= (less than or equal) : students aged 21 or younger
SELECT * FROM Student WHERE Age <= 21;


-- BETWEEN: Filters rows within a range
-- Both boundary values are INCLUSIVE (included in the result)
-- BETWEEN 85 AND 95 → includes 85 and 95 themselves (equivalent to >= 85 AND <= 95)
-- Syntax: WHERE column BETWEEN low_value AND high_value

-- Students with marks between 85 and 95
SELECT * FROM Student WHERE Marks BETWEEN 85 AND 95;

-- Students aged between 20 and 22
SELECT * FROM Student WHERE Age BETWEEN 20 AND 22;

-- NOT BETWEEN: outside the range
SELECT * FROM Student WHERE Marks NOT BETWEEN 85 AND 95;


-- IN: Checks if a value matches any value in a list
-- Syntax: WHERE column IN (val1, val2, ...)
-- Shorter alternative to writing multiple OR conditions

-- Students in semester 7 or 8  (same as: WHERE SEM = 7 OR SEM = 8)
SELECT * FROM Student WHERE SEM IN (7, 8);

-- Students named AMAN or ESHA
SELECT * FROM Student WHERE Name IN ('AMAN', 'ESHA');

-- NOT IN: excludes the listed values
SELECT * FROM Student WHERE SEM NOT IN (8);
