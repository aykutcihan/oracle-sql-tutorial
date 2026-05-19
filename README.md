# Oracle SQL Tutorial

Practice notes for the **Oracle SQL** course on Great Learning.

The course is Oracle SQL based but all queries are run on **PostgreSQL**.

## Environment

- **Database:** PostgreSQL (Docker container, port 5444)
- **Database name:** learning
- **Tool:** VS Code + Database Client extension

## Tables

**Student**
| Column | Type | Description |
|--------|------|-------------|
| ID | INTEGER | Student number |
| Name | VARCHAR(30) | Full name |
| Age | INTEGER | Age |
| Gender | VARCHAR(6) | MALE / FEMALE |
| Marks | INTEGER | Grade |
| SEM | INTEGER | Semester |
| DeptID | INTEGER | Department (FK) |

**Department**
| Column | Type | Description |
|--------|------|-------------|
| DeptID | INTEGER | Department number |
| DeptName | VARCHAR(30) | Department name |
| HOD | VARCHAR(30) | Head of department |

## Setup

To build the tables from scratch, first drop existing ones:

```sql
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;
```

Then run in order:
1. `01_create_table.sql`
2. `02_insert_into.sql`

## Files

| File | Topic |
|------|-------|
| 01_create_table.sql | CREATE TABLE, data types |
| 02_insert_into.sql | INSERT INTO |
| 03_select.sql | SELECT |
| 04_where.sql | WHERE, BETWEEN, IN |
| 05_and_or.sql | AND, OR, NOT |
| 06_order_by.sql | ORDER BY |
| 07_distinct.sql | DISTINCT |
| 08_column_alias.sql | Column Alias (AS) |
| 09_concatenation.sql | Concatenation (\|\|) |
| 10_dual.sql | DUAL table |
| 11_like.sql | LIKE, wildcards (%, _) |
| 12_is_null.sql | IS NULL, IS NOT NULL |
| 13_string_functions.sql | UPPER, LOWER, SUBSTR, TRIM, LPAD... |
| 14_number_functions.sql | ROUND, TRUNC, MOD, ABS... |
| 15_conversion_null_functions.sql | TO_CHAR, COALESCE, NULLIF |
| 16_aggregate_functions.sql | COUNT, SUM, AVG, MIN, MAX |
| 17_group_by.sql | GROUP BY |
| 18_having.sql | HAVING |
| 19_subquery.sql | Subquery |
| 20_join.sql | INNER, LEFT, RIGHT, FULL, NATURAL, CROSS JOIN |
| 21_ddl.sql | ALTER TABLE, DROP, TRUNCATE |

## Source

Great Learning — Oracle SQL (Basics)
