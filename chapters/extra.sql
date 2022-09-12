-- Extra
-- Additional info 
-- -------------

-- LIMIT and OFFSET

SELECT open_branch_id AS branch, count(*) FROM account 
GROUP BY branch ORDER BY branch 
    LIMIT 2 OFFSET 1;

-- update on duplicate, upsert

/* if unique => insert, else => update */

INSERT INTO tb_name VALUES (1, 2) 
    ON CONFLICT (col_name) DO UPDATE SET col_name = 'duplicated';

/* if result is [1,2,3,4,5], will be returned [2,3] */

-- duplicate, clone table
CREATE table_name2 AS SELECT * FROM table_name1;

-- drop / delete
DELETE FROM table_name WHERE (SELECT ...);

-- -------------
-- Write into outfile
-- -------------

/* in the <psql> interface: */

db=# \o '/path/to/file_name.data.txt'
db=# SELECT * FROM table_name;
db=# \o

-- -------------
-- Export as .csv file
-- -------------

db=# \copy (SELECT * FROM product) TO '~/sample.csv' WITH CSV;

/* or */
COPY (SELECT * FROM product) TO '/abs/path/sample.csv' DELIMITER ',' CSV HEADER;

