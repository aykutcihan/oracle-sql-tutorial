-- Active: 1779203852153@@127.0.0.1@5444@learning

-- INSERT INTO: Adds new rows of data into a table
-- Syntax 1: INSERT INTO table_name VALUES(val1, val2, ...);
--   Values must be in the same order as the columns defined in CREATE TABLE

INSERT INTO Student VALUES(52, 'AMAN',    26, 'MALE',   98, 8, 1);
INSERT INTO Student VALUES(53, 'MOHAN',   27, 'MALE',   94, 8, 2);
INSERT INTO Student VALUES(54, 'ABHIRAM', 22, 'MALE',   85, 7, 1);
INSERT INTO Student VALUES(55, 'ALKA',    20, 'FEMALE', 78, 7, 2);
INSERT INTO Student VALUES(56, 'DISHA',   21, 'FEMALE', 91, 8, 1);
INSERT INTO Student VALUES(57, 'ESHA',    21, 'FEMALE', 89, 8, 3);

INSERT INTO Department VALUES (1, 'Computer Science', 'DR. SHARMA');
INSERT INTO Department VALUES (2, 'Mathematics',      'DR. MEHTA');
INSERT INTO Department VALUES (3, 'Physics',          'DR. VERMA');
INSERT INTO Department VALUES (4, 'Chemistry',        'DR. KHAN');
-- Chemistry has no students assigned → DeptID=4 appears in Department but not in Student
-- This makes RIGHT JOIN behavior visible: Chemistry row comes with NULL student columns

INSERT INTO Course VALUES (1, 'Database Systems', 1);
INSERT INTO Course VALUES (2, 'Calculus',         2);
INSERT INTO Course VALUES (3, 'Quantum Physics',  3);
INSERT INTO Course VALUES (4, 'Organic Chemistry',4);


-- Syntax 2: INSERT INTO table_name (col1, col2) VALUES (val1, val2);
--   Specify which columns to fill — unspecified columns get NULL
--   Useful when you don't have values for all columns

-- RAHUL has no department → DeptID will be NULL
INSERT INTO Student (ID, Name, Gender) VALUES (58, 'RAHUL', 'MALE');

-- The row above will have NULL for Age, Marks, SEM
-- You can verify with:
SELECT * FROM Student WHERE ID = 58;
