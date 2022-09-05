-- Chapter 6
-- Sets operators
-- -------------

/* Basec operations: union, intersection, except */

SELECT 1 num, 'abc' str
UNION
SELECT 9 num, 'xyz' str;

-- NOTE: requirements
--   * tables (selected data) must contain the same number of columns
--   * columns (selected data) must contain the same data types

-- Union (without duplicates), Union All (with duplicates)
-- Elements in Set1 & Set2
SELECT emp_id FROM employee 
    WHERE assigned_branch_id = 2 AND title = 'Teller'
UNION ALL
SELECT DISTINCT open_emp_id FROM account
    WHERE open_branch_id = 2;

-- Intersect
-- Elements form Set1 and from Set2
SELECT emp_id, fname, lname FROM employee 
INTERSECT
SELECT cust_id, fname, lname FROM individual;

-- Except
-- Element in Set1 minus elements from Set2
SELECT emp_id FROM employee 
    WHERE assigned_branch_id = 2 AND title = 'Teller'
EXCEPT
SELECT DISTINCT open_emp_id FROM account
    WHERE open_branch_id = 2;

-- Rules:
--   Order By operator use only first query columns
--   Operators order is important; or need using parentheses

-- -------------
-- Tasks:

/* 6.1 */
A = {L M N O P}, B = {P Q R S T}
A union B:     {L M N O P Q R S T}
A union all B: {L M N O P P Q R S T}
A intersect B: {P}
A except B:    {L M N O}

/* 6.2 */
SELECT fname, lname FROM individual
UNION
SELECT fname, lname FROM employee;

/* 6.3 */
SELECT fname, lname FROM individual
UNION
SELECT fname, lname FROM employee
ORDER BY lname;

