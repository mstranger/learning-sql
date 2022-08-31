-- Chapter 3
-- -------------

-- query may content max 6 blocks (clauses):
--   Select, From, Where, Group By, Having, Order By

-- SELECT
SELECT * FROM table_name;
SELECT version();                                          /* use built-in function */
SELECT id, lname, 'ACTIVE' [as] status from table_name;    /* set alias (status) for column */
SELECT DISTINCT id from table_name;                        /* without duplicates */

-- FROM
-- Tables
--   created with CREATE TABLE
       SELECT field1, field2, field3 FROM table_name;
--   temp tables created with subquery
       SELECT e.field1, e.field2 FROM (SELECT field1, field2, field3 FROM table_name) as e;
--   virtual tables created with CREATE VIEW
       CREATE VIEW virtual_table_name AS
          SELECT field1, field2, field3 FROM table_name;
       SELECT * from virtual_table_name; 

-- WHERE (filtering)
SELECT * FROM table_name WHERE fild1_name = 'condition 1' AND field2_name = 'condition 2';

-- ORDER BY (sorting)
SELECT * FROM table_name ORDER BY id DESC LIMIT 5;
SELECT * FROM customer ORDER BY RIGHT(field1, 3);       /* sort by 3 last chars of field1 record */
SELECT * FROM table_name ORDER BY 2, 5;                 /* sort by 2 and 5 coulumn of table */

-- -------------
-- Tasks:
SELECT emp_id, fname, lname FROM employee ORDER BY lname, fname; /* 3.1 */
SELECT account_id, cust_id, avail_balance FROM account WHERE status = 'ACTIVE' AND avail_balance > 2500; /* 3.2 */
SELECT DISTINCT open_emp_id FROM account; /* 3.3 */

/* 3.4 */
SELECT p.product_cd, a.cust_id, a.avail_balance
    FROM product p INNER JOIN account a
    ON p.product_cd = a.product_cd
    WHERE p.product_type_cd = 'ACCOUNT' ORDER BY product_cd, cust_id;

