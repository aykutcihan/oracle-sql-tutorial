-- Active: 1779203852153@@127.0.0.1@5444@learning

-- DISTINCT: Returns only unique values, removes duplicates
-- Example: SELECT Gender returns MALE,MALE,MALE,FEMALE,FEMALE,FEMALE
--          SELECT DISTINCT Gender returns only MALE, FEMALE
-- Use case: When you want to know what unique values exist in a column

-- All gender values (with duplicates)
SELECT Gender FROM Student;

-- Only unique gender values
SELECT DISTINCT Gender FROM Student;

-- Only unique semester values
SELECT DISTINCT SEM FROM Student;

-- DISTINCT on multiple columns
SELECT DISTINCT Gender, SEM FROM Student;
