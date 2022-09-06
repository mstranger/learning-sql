-- Chapter 8
-- Group and aggregates
-- -------------

-- general view
SELECT open_emp_id FROM account GROUP BY open_emp_id;

-- <group by> creates groups

-- with Aggregate function <count>
SELECT open_emp_id, COUNT(*) how_many FROM account GROUP BY open_emp_id;

-- NOTE: <group by> exec AFTER <where> block, so
SELECT open_emp_id, COUNT(*) FROM account WHERE COUNT(*) > 4 GROUP BY open_emp_id; 
/* => Error, group does not exist when calls where block */

-- in this case need use Having block
SELECT open_emp_id, COUNT(*) FROM account GROUP BY open_emp_id
HAVING COUNT(*) > 4;

-- Some Aggregates Functions
MAX(), MIN()
AVG()
SUM()
COUNT()

/* without <group by> creates one single implicit group */
SELECT max(avail_balance), min(avail_balance), avg(avail_balance),
sum(avail_balance), count(*) FROM account WHERE product_cd = 'CHK';

/* creates groups before */
SELECT product_cd, max(avail_balance), min(avail_balance), avg(avail_balance),
sum(avail_balance), count(*) FROM account GROUP BY product_cd;

-- count distinct records
SELECT count(DISTINCT field_id) FROM tb_name;

-- use expressions
SELECT max(field1 - field2) FROM tb_name;

-- NOTES:
--   count(*) returns columns count
--   count(val) returns vals count, NULL values will be ignored

-- Create groups
--   by one column
SELECT product_cd, sum(avail_balance) FROM account GROUP BY product_cd;

--   by several columns
SELECT product_cd, open_branch_id, sum(avail_balance) total_balance
FROM account GROUP BY product_cd, open_branch_id;

--   by expresions
SELECT extract(year FROM start_date) AS year, count(*) how_many
FROM employee GROUP BY extract(year FROM start_date);

-- generalizations
/* adds total sum for each pair and entire result */
SELECT product_cd, open_branch_id, sum(avail_balance) total
FROM account
GROUP BY ROLLUP(product_cd, open_branch_id) ORDER BY product_cd;
/* adds total sum for ALL possible cominations of columns */
SELECT product_cd, open_branch_id, sum(avail_balance) total
FROM account
GROUP BY CUBE(product_cd, open_branch_id) ORDER BY product_cd;

-- HAVING operator
-- <where> applied to data BEFORE grouping, <having> - AFTER groupin
SELECT product_cd, sum(avail_balance) FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd 
HAVING sum(avail_balance) >= 10000 AND min(avali_balance) >= 1000;

-- -------------
-- Tasks:

/* 8.1 */
SELECT count(*) FROM account;

/* 8.2 */
SELECT cust_id, count(product_cd) FROM account GROUP BY cust_id;
SELECT cust_id, count(*) FROM account GROUP BY cust_id;

/* 8.3 */
SELECT cust_id, count(product_cd) FROM account GROUP BY cust_id HAVING count(product_cd) > 1;
SELECT cust_id, count(*) FROM account GROUP BY cust_id HAVING count(*) > 1;

/* 8.4 */
SELECT product_cd, open_branch_id, sum(avail_balance) FROM account 
GROUP BY product_cd, open_branch_id
HAVING count(*) > 1 ORDER BY sum(avail_balance) DESC;

/* Note: same as - ... ORDER BY 3 DESC */

