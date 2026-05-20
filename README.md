# Oracle SQL Tutorial

Certificate: [Great Learning — Oracle SQL](https://www.mygreatlearning.com/certificate/EMTXKELP)

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
1. `lessons/01_create_table.sql`
2. `lessons/02_insert_into.sql`

## Files

All lesson files are in the [lessons/](lessons/) folder.

| File | Topic |
|------|-------|
| lessons/01_create_table.sql | CREATE TABLE, data types |
| lessons/02_insert_into.sql | INSERT INTO |
| lessons/03_select.sql | SELECT |
| lessons/04_where.sql | WHERE, BETWEEN, IN |
| lessons/05_and_or.sql | AND, OR, NOT |
| lessons/06_order_by.sql | ORDER BY |
| lessons/07_distinct.sql | DISTINCT |
| lessons/08_column_alias.sql | Column Alias (AS) |
| lessons/09_concatenation.sql | Concatenation (\|\|) |
| lessons/10_dual.sql | DUAL table |
| lessons/11_like.sql | LIKE, wildcards (%, _) |
| lessons/12_is_null.sql | IS NULL, IS NOT NULL |
| lessons/13_string_functions.sql | UPPER, LOWER, SUBSTR, TRIM, LPAD... |
| lessons/14_number_functions.sql | ROUND, TRUNC, MOD, ABS... |
| lessons/15_conversion_null_functions.sql | TO_CHAR, COALESCE, NULLIF |
| lessons/16_aggregate_functions.sql | COUNT, SUM, AVG, MIN, MAX |
| lessons/17_group_by.sql | GROUP BY |
| lessons/18_having.sql | HAVING |
| lessons/19_subquery.sql | Subquery |
| lessons/20_join.sql | INNER, LEFT, RIGHT, FULL, NATURAL, CROSS JOIN |
| lessons/21_ddl.sql | ALTER TABLE, DROP, TRUNCATE |
| lessons/22_constraints.sql | NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT |
| lessons/23_indexes.sql | CREATE INDEX, UNIQUE INDEX, DROP INDEX |
| lessons/24_views.sql | CREATE VIEW, CREATE OR REPLACE VIEW, DROP VIEW |
| lessons/25_sequences.sql | SERIAL, CREATE SEQUENCE, NEXTVAL |
| lessons/26_update.sql | UPDATE, SET, WHERE |
| lessons/27_delete.sql | DELETE, DELETE vs TRUNCATE vs DROP |
| lessons/28_transactions.sql | COMMIT, ROLLBACK, SAVEPOINT |

## Source

Great Learning — Oracle SQL (Basics)
