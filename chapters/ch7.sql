-- Chapter 7
-- Working with data
-- -------------

-- -------------
-- Character data
-- -------------
CHAR                                /* fix length + spaces, max limit is about 1GB */
CHARACTER(n), CHAR(n)

VARCHAR                             /* fix length with limit, max is about 1GB */
CHARACTER varying(n), VARCHAR(n)

TEXT                                /* unlimited length */

-- Notes: 
--   * server raises error if given value will be longer than (n) chars 
--   * escape symbol 'This string didn''t work, but it does now'
--   * escape sybols when selecting with built-in func: `quote_leteral()` and `quote_ident()`

/* get code point */
SELECT ASCII('a')
/* get char from code point */
SELECT CHR(97)
/* get length */
SELECT LENGTH('asdf')
/* join strings */
SELECT CONCAT('John', CHR(32), 'Doe')
/* get first 2 letters */
SELECT LEFT('abcdef', 2);
/* some other text func */
RIGHT('str', 2)
MD5('string')
LPAD, LPAD 
REPLACE
SUBSTRING 
POSITION('substr' IN 'str') /* first letter is 1, 0 - not found */
TRIM('subst' FROM 'str')
UPPER 

/* Example: second column will be true (t) or false (f) */
SELECT name, name LIKE '%ns' ends_in_ns FROM department;

-- -------------
-- Numeric data
-- -------------
SELECT (5 * 4) / 3.0 + 1

/* math funcs */
COS, LN, ASIN, SQRT ...

/* a in power b */
POW(a, b)
/* modulo */
MOD(10, 4)

SELECT POW(2, 10) KB, POW(2, 20) MB, POW(2, 30) GB, POW(2, 40) TB;

/* round numbers */
CEIL(72.445) == 73
FLOOR(72.445) == 72
ROUND(72.4) == 72, ROUND(72.5) == 73, ROUND(72.438, 2) == 72.44
TRUNC(72.4) == 72, TRUNC(72.6) = 72, TRUNC(72.438, 2) = 72.43
TRUNC(17, -1) = 10

/* abs value */
ABS(-17.2) == 17.2
/* sign */
SIGN(-17.2) == -1, SIGN(17.2) == 1, SIGN(0) = 0

-- -------------
-- DateTime data
-- -------------

/* GMT - Greenwich Mean Time; EST - Eastern Standard Time (GMT-5) */
/* UTC - Coordinated Universal Time */

-- NOTE: GMT - time zone, UTC - time standard

SELECT now();
SELECT current_date, current_time([n]), current_timestamp;
SELECT localtime([n])
SELECT localtime AT TIME ZONE 'UTC-5'
SELECT current_time AT TIME ZONE 'EST'

-- get current zone settings
SHOW timezone; /* or SHOW time zone; */
SELECT current_setting('TIMEZONE')

-- set timezone for current session (connection)
SET TIME ZONE 'Europe/Zurich'

-- get timezone names
SELECT name FROM pg_timezone_names;

Date      'YYYY-MM-DD'
Datetime  'YYYY-MM-DD HH:MI:SS'
Timestamp 'YYYY-MM-DD HH:MI:SS'
Time      'HH:MI:SS'

/* if type of txn_date is Timestamp */
UPDATE transaction SET txn_date = '2005-03-27 15:30:00' WHERE txn_id = 123

-- convert one type to onother
-- CAST (expression AS target_type);
SELECT CAST('2005-03-27 15:30:00' AS date);

-- another variant
-- expression::type
SELECT '2005-03-27 15:30:00'::DATE

SELECT to_date('20050723', 'YYYYMMDD')                           /* '2005-07-23' */
SELECT to_timestamp('2017-03-31 9:30:20', 'YYYY-MM-DD HH:MI:SS') /* '2017-03-31 09:30:20-07' */

/* get diff between two dates */
SELECT age('2017-01-01', '2011-06-24');            /* '5 years 6 mons 7 days' */
SELECT current_date, age(timestamp '2000-01-01');  /* '17 years 2 mons 19 days' */

-- extract date data
SELECT date_part('year', '2005-07-23'::DATE) as "year"
/* same as */
SELECT extract(yaer FROM DATE '2005-07-23')

-- add some interval from now
SELECT now() + INTERVAL '1 day 3 hours 30 minutes'

-- interval to days
SELECT extract(epoch FROM age('2005-09-05', '2005-06-22')) / (24*60*60.0)

-- -------------
-- Tasks:

/* 7.1 */
SELECT substring('Please find the substring in this string', 17, 9);

/* 7.2 */
SELECT abs(-25.76823), sign(-25.76823), round(abs(-25.76823);

/* 7.3 */
SELECT date_part('month', now()) as current_month;
SELECT extract(month from now()) as current_month;

