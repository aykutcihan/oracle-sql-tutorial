-- Active: 1779203852153@@127.0.0.1@5444@learning

-- CONCATENATION: Joins two or more strings together into one
-- Oracle syntax: column1 || column2
-- PostgreSQL supports || as well
-- Use '' (single quotes) to add custom text between values

-- Join ID and Name together (no space)
SELECT ID || Name FROM Student;

-- Join with a space in between
SELECT ID || ' ' || Name FROM Student;

-- Join Name and Gender with a dash
SELECT Name || ' - ' || Gender FROM Student;

-- More descriptive output
SELECT Name || ' is a ' || Gender || ' student.' FROM Student;

-- Combined with alias to give the result a proper column name
SELECT Name || ' - SEM: ' || SEM AS Student_Info FROM Student;
