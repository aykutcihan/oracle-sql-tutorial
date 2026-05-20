-- Active: 1779203852153@@127.0.0.1@5444@learning

-- ORDER BY: Sorts the result set
-- ASC = ascending (A→Z, 0→9) — default
-- DESC = descending (Z→A, 9→0)
-- Syntax: SELECT * FROM table_name ORDER BY column_name ASC/DESC;

-- Sort by marks ascending (lowest first)
SELECT * FROM Student ORDER BY Marks ASC;

-- Sort by marks descending (highest first)
SELECT * FROM Student ORDER BY Marks DESC;

-- Sort by name alphabetically
SELECT * FROM Student ORDER BY Name ASC;

-- Sort by semester, then by marks descending
SELECT * FROM Student ORDER BY SEM ASC, Marks DESC;
