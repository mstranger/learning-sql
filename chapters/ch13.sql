-- Chapter 13
-- Indexes and Constraints
-- -------------

-- CREATE INDEX <index_name> ON <table_name> (<columns>)

-- Create index
CREATE INDEX dept_name_id ON department (name);
-- Create multiple-column index
-- NOTE: columns order is important!
CREATE INDEX emp_names_idx ON employee (lname, fname);
-- Delete index
DROP INDEX dept_name_id;

-- List all indexes for db
SELECT * FROM pg_indexes WHERE schemaname = 'public';
-- List all indexes for table
SELECT * FROM pg_indexes WHERE tablename = 'table_name';
/* or use <\d table_name> command */

-- By the way, list all tables for db
SELECT * FROM pg_tables WHERE schemaname = 'public';

-- Create unique index, prevents duplicates by <name> column
CREATE UNIQUE INDEX dept_name_idx ON department (name);

/* NOTE: for Primary Key unique values checks by default */

-- -------------
-- Index Types
-- -------------

/*
    B-tree indexes, Balanced-tree indexes (by default)
    bitmap indexes (doesn't allow create manually in postgres)
    full-text indexes
*/

-- display Query Plan (for optimization)
EXPLAIN ANALYZE select cust_id, sum(avail_balance) total
FROM account WHERE cust_id IN (1, 5, 9, 11) GROUP BY cust_id;

-- -------------
-- Constraints
-- -------------

/* Def: a limiting condition for one or more columns of a table */

/* 
Types:
    - Primary-key constraints (ensure uniqueness within table)
    - Foreign-key constraints (ensure existence of records in another table, point to PK in other table)
    - Unique constraints (ensure uniquenes of value within table)
    - Check constraints (ensure possible values)
*/

-- Create 
CREATE TABLE table_name
(
    id INTEGER,
    name VARCHAR(50) NOT NULL,
    f_id INTEGER NOT NULL 
    
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_id FOREIGN KEY (f_id) REFERENCES other_table (id)
);

/* or */
CREATE TABLE TABLE name (
    id INTEGER PRIMARY KEY,
    ...
);

/* or add after creation tables */
ALTER TABLE table_name ADD CONSTRAINT pk_id PRIMARY KEY (id);
ALTER TABLE table_name ADD CONSTRAINT fk_id FOREIGN KEY (f_id)
    REFERENCES other_table (id);

-- Delete 
ALTER TABLE table_name DROP CONSTRAINT pk_id;
ALTER TABLE table_name DROP CONSTRAINT fk_id;

/* 
NOTE: 
    Primary Key creates unique index automaticaly
    Foreign Key doesn't create index

NOTE: It's recommended create index for each Foreign Key constraint
*/

-- Cascade
/* needs delete Foreing Key constraint before if it exist */
ALTER TABLE table_name ADD CONSTRAINT fk_id FOREIGN KEY (f_id)
    REFERENCES other_table (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE 

/*
    table with foreign key is 'child' table, 
    where pointed foreing key - 'parent' table
    for now, after changing parent data will be changed corresponing data for child data
*/

