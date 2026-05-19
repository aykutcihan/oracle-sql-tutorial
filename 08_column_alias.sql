-- Active: 1779203852153@@127.0.0.1@5444@learning

-- COLUMN ALIAS: Gives a temporary name to a column in the result
-- Original column name stays the same in the table, only the output label changes
-- Syntax: SELECT column_name AS alias_name FROM table_name

-- Without alias
SELECT Name, Marks FROM Student;

-- With alias
SELECT Name AS Student_Name, Marks AS Total_Marks FROM Student;

-- AS keyword is optional
SELECT Name Student_Name, Marks Total_Marks FROM Student;

-- Alias with spaces (use double quotes)
SELECT Name AS "Student Name", Marks AS "Total Marks" FROM Student;
