-- Chapter 9
-- Subqueries
-- -------------

/*
one row - one column
many rows - one column

one row - many columns
many rows - many columns
*/

-- Subqueries can use any query blocks: select, from, where, group by, having, order by
-- 4 additional operators: 
--    in (checks presence in sets)
--    not in
--    all (compare value with every elem in set, true if ALL true)
--    any (same as for all, but true if ONE true)

/* NOTE: <in> and <any> are equivalent */

SELECT account_id, product_cd, cust_id, avail_balance 
FROM account
WHERE account_id = (SELECT max(account_id) FROM account);

-- Noncorrelated subqueries
SELECT emp_id, fname, lname, title FROM employee
WHERE emp_id IN (SELECT superior_emp_id FROM employee);

/* same as */
...
WHERE emp_id <> ALL (SELECT superior_emp_id FROM employee);

/* can has several subqueries */
SELECT account_id, product_cd, cust_id FROM account
    WHERE open_branch_id = (SELECT branch_id FROM branch WHERE name = 'Woburn Branch')
        AND open_emp_id IN (SELECT emp_id FROM employee WHERE title = 'Teller' OR title = 'Head Teller');

/* many columns, same as above */
SELECT account_id, product_cd, cust_id 
FROM account WHERE (open_branch_id, open_emp_id) IN 
    (SELECT b.branch_id, e.emp_id FROM branch b
        INNER JOIN employee e ON b.branch_id = e.assigned_branch_id
    WHERE b.name = 'Woburn Branch' AND (e.title = 'Teller' OR e.title = 'Head Teller'));

-- Correlated subqueries
SELECT c.cust_id, c.cust_type_cd, c.city FROM customer c
    WHERE 2 = (SELECT count(*) FROM account a WHERE a.cust_id = c.cust_id);

/* <exists> operator */
SELECT a.account_id, a.product_cd, a.cust_id
FROM account a
WHERE EXISTS (SELECT 1 FROM business b WHERE b.cust_id = a.cust_id);

/* update, detele */
UPDATE account a 
SET a.last_activity_date = 
    (SELECT max(t.txn_date) FROM transaction t WHERE t.account_id = a.account_id)
WHERE EXISTS 
    (SELECT 1 FROM transaction t WHERE t.account_id = a.account_id);

DELETE FROM department d
WHERE NOT EXISTS 
    (SELECT 1 FROM employee e WHERE e.dept_id = d.dept_id);

-- Subqueries as data source
SELECT d.dept_id, d.name, e_cnt.how_many num_employees
FROM department d INNER JOIN
    (select dept_id, count(*) how_many from employee group by dept_id) e_cnt
ON d.dept_id = e_cnt.dept_id;

-- Make tables
SELECT groups.name, count(*) num_customers FROM 
    (SELECT sum(a.avail_balance) cust_balance
        FROM account a INNER JOIN product p WHERE p.product_type_cd = 'ACCOUNT'
        GROUP BY a.cust_id) cust_rollup 
INNER JOIN 
    /* intermediate table */
    (SELECT 'Small Fry' AS name, 0 low_limit, 4999.99 high_limit
        UNION ALL
        SELECT 'Average Joes' AS name, 5000 low_limit, 9999.99 high_limit
        UNION ALL
        SELECT 'Heavy Hitters' AS name, 10000 low_limit, 9999999.99 high_limit) groups
ON cust_rollup.cust_balance BETWEEN groups.low_limit AND groups.high_limit
GROUP BY groups.name;

-- Subqueries in filter blocks
SELECT open_emp_id, count(*) how_many FROM account GROUP BY open_emp_id
    HAVING count(*) = (SELECT max(emp_cnt.how_many)
        FROM (SELECT count(*) how_many FROM account GROUP BY open_emp_id) emp_cnt);

-- Subqueries as expressions generator
SELECT 
    (SELECT p.name FROM product p 
        WHERE p.product_cd = a.product_cd AND p.product_type_cd = 'ACCOUNT') product,
    (SELECT b.name FROM branch b WHERE b.branch_id = a.open_branch_id) branch,
    (SELECT concat(e.fname, ' ', e.lname) FROM employee e WHERE E.emp_id = a.open_emp_id) AS name,
    sum(a.avail_balance) tot_deposits
FROM account a
GROUP BY a.product_cd, a.open_branch_id, a.open_emp_id;

-- Insert using subqueries
INSERT INTO account
    (account_id, product_cd, cust_id, open_date, last_activity_date,
     status, open_branch_id, open_emp_id, avail_balance, pending_balance)
VALUES (NULL,
    (SELECT product_cd FROM product WHERE name = 'saving account'),
    (SELECT cust_id FROM customer WHERE fed_id = '555-55-5555'),
    '2005-01-25', '2005-01-25', 'ACTIVE',
    (SELECT branch_id FROM branch WHERE name = 'Quincy Branch'),
    (SELECT emp_id FROM employee WHERE lname = 'Portman' AND fname = 'Frank'),
    0, 0);

-- -------------
-- Tasks:

/* 9.1 */
SELECT account_id, product_cd, cust_id, avail_balance FROM account
WHERE product_cd IN (SELECT product_cd FROM product WHERE product_type_cd = 'LOAN');

/* 9.2 */
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance FROM account a
WHERE EXISTS (SELECT * FROM product 
    WHERE product_cd = a.product_cd AND product_type_cd = 'LOAN');

/* 9.3 */
SELECT e.emp_id, e.fname, e.lname, levels.name 
FROM employee e INNER JOIN 
    (SELECT 'trainee' AS name, '2008-01-01' start_dt, '2008-12-31' end_dt
     UNION ALL 
     SELECT 'worker' AS name, '2006-01-01' start_dt, '2007-12-31' end_dt
     UNION ALL 
     SELECT 'mentor' AS name, '2005-01-01' start_dt, '2005-12-31' end_dt) levels
ON e.start_date >= levels.start_dt::DATE AND e.start_date <= levels.end_dt::DATE;

/* 9.4 */
SELECT 
    emp_id, fname, lname,
    (SELECT name FROM department d WHERE d.dept_id = e.dept_id) dept,
    (SELECT name FROM branch b WHERE b.branch_id = e.assigned_branch_id) branch
FROM employee e;

