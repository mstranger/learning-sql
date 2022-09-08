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

