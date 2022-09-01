-- Chapter 4
-- Filtering
-- -------------

WHERE (title = 'Teller' AND start_date < '2003-01-01')
    OR (title = 'Admin' AND start_date > '2001-01-01');

WHERE field IS NULL;

WHERE NOT title = 'Teller' 
WHERE title != 'Teller'

/* built-in func */
SELECT CONCAT('hello', ' ', 'sql');

-- operators: =, !=, <=, >=, <, >, <>, LIKE, IN, BETWEEN
-- ariphmetics: +, -, *, /

-- Equals
'column' = 'extension'

-- Inequals
'one' != 'two'
'one' <> 'two'

-- Ranges
WHERE start_date < '2003-01-01' AND start_date >= '2001-01-01';
WHERE start_date BETWEEN '2001-01-01' AND '2003-01-01';               /* min <= value <= max */
WHERE key [NOT] IN ('val1', 'val2', 'val3', 'val4');                  /* same as: 'val1' or 'val2' or 'val3' */

/* from subquery */
WHERE key IN (
    SELECT field FROM table_name WHERE field = 'value'
);

SELECT * FROM table_name WHERE LEFT(col_name, 1) = 'T';               /* col_name starts from 'T' */

-- with masks: 
--    '%' - 0 and more chars, '_' - exact 1 char
WHERE lname LIKE '_a%e%';                                             /* 'Barker', 'Parker', 'Jameson' */

/*
    %F - string begining with 'F'
    %t - string ending with 't'
    '%bas%' - string with 'bas' substring
    '___-__-____' - string in format 'xxx-xx-xxxx'
*/

SELECT fname, lname FROM users WHERE lname LIKE 'F%' OR lname LIKE 'G%';  /* lname starts from 'F' or 'G' */

-- with REGEXP
SELECT fname, lname FROM users WHERE lname ~ '^[FG]';

-- Null
WHERE field_title IS [NOT] NULL;

-- NOTE: null != null, null != 0

SELECT * FROM table_name
    WHERE id != 12 OR id IS NULL;   /* without this fields with null value will not be included */

-- -------------
-- Tasks:

/* 4.1 */
1, 2, 3, 5, 6, 7

/* 4.2 */
4, 9

/* 4.3 */
SELECT * FROM account WHERE date_part('year', open_date) = 2002;
SELECT * FROM account WHERE open_date BETWEEN '2002-01-01' AND '2002-12-31';

/* 4.4 */
SELECT * FROM individual WHERE lname LIKE '_a%e%';

