-- Chapter 10
-- Joins again (cross, outer)
-- -------------

/*
<inner join> - takes data from one table, 
    join with second table and reject rows that aren't in the second table
<left outer join> - takes data from first table,
    join with second and fill NULL (or discard) columns for rows 
    that aren't in the second
<right outer join> - takes data from second table,
    join with first and fill NULL (or discard) columns for rows 
    that aren't in the second

NOTE: <A left outer join B> same as <B right outer join A>
*/

/* left outer join */
SELECT a.account_id, a.cust_id, b.name FROM account a 
LEFT OUTER JOIN business b ON a.cust_id = b.cust_id;

/* triple join example */
SELECT a.account_id, a.product_cd,
    concat(i.fname, ' ', i.lname) person_name, b.name business_name
FROM account a 
LEFT OUTER JOIN individual i ON a.cust_id = i.cust_id
LEFT OUTER JOIN business b ON a.cust_id = b.cust_id;

/* list employes and their boss */
SELECT e.emp_id, e.fname, e.lname, concat(a.fname, ' ', a.lname) as boss
FROM employee e LEFT OUTER JOIN employee a ON e.superior_emp_id = a.emp_id;

/* list employes and their assistants */
SELECT e.emp_id, e.fname, e.lname, concat(a.fname, ' ', a.lname) as boss
FROM employee e RIGHT OUTER JOIN employee a ON e.superior_emp_id = a.emp_id;

/* cross joins (decart product) */
SELECT pt.name, p.product_cd, p.name FROM product p CROSS JOIN product_type pt;

/* Example: create all permutations of {1, 2, 3} */
SELECT a.num, b.num, c.num FROM
    (SELECT 1 AS num UNION ALL SELECT 2 AS num UNION ALL SELECT 3 AS num) a
CROSS JOIN
    (SELECT 1 AS num UNION ALL SELECT 2 AS num UNION ALL SELECT 3 AS num) b
CROSS JOIN
    (SELECT 1 AS num UNION ALL SELECT 2 AS num UNION ALL SELECT 3 AS num) c;

/* add days */
SELECT '2004-01-01'::DATE + INTERVAL '60 days';

-- Natural join (join by two columns with same title)
SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id
FROM account a NATURAL JOIN customer c;
/* will be join on a.cust_id = c.cust_id */

-- -------------
-- Tasks:

/* 10.1 */

/* 10.2 */

/* 10.3 */

/* 10.4 */

