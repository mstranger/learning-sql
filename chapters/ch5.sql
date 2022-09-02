-- Chapter 5
-- Joins (inner joins)
-- -------------

-- Cross Join (decart product)
/* if e table has 18 rows, d table has 3 rows, result will be contain 18 * 3 = 54 rows */
SELECT e.fname, e.lname, d.name FROM employee e CROSS JOIN department d;

-- Inner Join
/* if any table has value that is null or not present in other table, it will not be included in result */
/* SQL92 standart */
SELECT e.fname, e.lname, d.name 
    FROM employee e [INNER] JOIN department d ON e.dept_id = d.dept_id;

/* if join column has same title */
SELECT e.fname, e.lname, d.name 
    FROM employee e [INNER] JOIN department d USING (dept_id);

/* old syntax */
SELECT e.fname, e.lname, d.name 
    FROM employee e, department d WHERE e.dept_id = d.dept_id;

-- join 3 tables
SELECT a.account_id, c.fed_id, e.fname, e.lname
FROM account a 
    INNER JOIN customer c ON a.cust_id = c.cust_id
    INNER JOIN employee e ON a .open_emp_id = e.emp_id
WHERE c.cust_type_cd = 'B';

-- join subquery results
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a INNER JOIN
    (SELECT emp_id, assigned_branch_id FROM employee
        WHERE start_date <= '2003-01-01' AND (title = 'Teller' OR title = 'Head Teller')) e
    ON a.open_emp_id = e.emp_id
    INNER JOIN
        (SELECT branch_id FROM branch WHERE name = 'Woburn Branch') b
    ON e.assigned_branch_id = b.branch_id;

-- self join (recursive)
SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
    ON e.superior_emp_id = e_mgr.emp_id;

-- equi-joins
JOIN ... ON e.other_id = b.id

-- non-equi-joins
JOIN ... ON e.start_date >= b.date_offered AND e.start_date <= b.date_retired

-- non-equi self join example
SELECT e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
    ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';

-- -------------
-- Tasks:

/* 5.1 */
1 - 'branch', 2 - 'branch_id'

/* 5.2 */
SELECT a.accouont_id, c.fed_id, p.name 
FROM customer c
    INNER JOIN account a ON c.cust_id = a.cust_id
    INNER JOIN product p ON a.product_cd = p.product_cd
WHERE c.cust_type_cd = 'I';

/* 5.3 */
SELECT e.emp_id, e.fname, e.lname
FROM employee e 
    INNER JOIN employee m ON e.superior_emp_id = m.emp_id
WHERE e.dept_id != m.dept_id;

