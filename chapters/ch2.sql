-- Chapter 2.

-- Symbols types
CHAR(20)        /* fix + spaces */
VARCHAR(20)     /* unfix without spaces */
TEXT

-- Numeric types
SERIAL          /* autoincrement integer */
INTEGER, INT
NUMERIC[(p,s)], DECIMAL[(p,s)]
REAL, FLOAT4

-- Date, time
DATE            /* calendar date, 'y/m/d' */
TIME[(p)]       /* time, date + time without timezone */
TIMESTAMP
TIMETZ[(p)]
TIMESTAMPTZ     /* time, date + time with timezone */

-- Basic queries
CREATE DATABASE db_name;
GRANT privilege(s) ON object(s) TO role;
CREATE TABLE tb_name (attr1 type, attr2 type, ...);
COMMENT ON object_type object_name IS 'some description';

-- Example
GRANT CONNECT ON DATABASE bank TO john;     /* for all priveleges use 'ALL' */

-- Constraint Primary Key
CREATE TABLE person (
    person_id SERIAL,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);
/* or */
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Constraint Foreign Key
CREATE TABLE food (
    person_id INT,
    title VARCHAR(50),
    CONSTRAINT pk_food PRIMARY KEY (person_id, title),
    CONSTRAINT fk_person_id FOREIGN KEY (person_id)
        REFERENCES person (person_id)
);

-- NOTE: ForeignKey is a link/reference to the PrimaryKey in the other table

-- Change data
ALTER TABLE tb_name ALTER COLUMN col_name TYPE new_type; /* change column type */
ALTER TABLE tb_name ADD COLUMN new_col_name data_type;   /* add column */
ALTER DATABASE db_name RENAME TO new_db_name;            /* rename db */
ALTER TABLE tb_name DROP COLUMN col_name;                /* delete column */

-- Insert
INSERT INTO tb_name (field1, field2, ...) VALUES ('val1', 'val2');
-- Select
SELECT data_list FROM tb_name WHERE conditions ORDER BY field_name;
-- Update
UPDATE tb_name SET field1 = 'new_data' field2 = 'new_data' WHERE conditions;
-- Delete
DROP TABLE tb_name;

-- MISC:
SELECT now();               /* get current date time */
SELECT current_user;        /* show current user(role) */

/*
    \c db_name  - connect to database
    \dt         - show tables
    \l, \l+     - info about database(s)
    \d, \d+     - info about relation(s)
    \du, \du+   - info about role(s)
*/

-- Select database, user and load data from the given .sql file:
-- psql -U role_name -d db_title -f path/to/file.sql

