-- Chapter 11
-- Conditions
-- -------------

/* 
searched case expression:

    case 
        when c1 then e1
        when c2 then e2
        ...
        when cn then en
        [else ed]
    end

NOTE: all e1..en must have same data type
*/

SELECT c.cust_id, c.fed_id,
    CASE 
        WHEN c.cust_type_cd = 'I'
            THEN concat(i.fname, ' ', i.lname)
        WHEN c.cust_type_cd = 'B'
            THEN b.name
        ELSE 'Unknown'
    END AS name
FROM customer c 
LEFT OUTER JOIN individual i ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b ON c.cust_id = b.cust_id;

/* 
simple case expression:

    case v0
        when v1 then e1
        when v2 then e2
        ...
        when vn then en
        [else ed]
    end
*/
SELECT c.cust_id, c.fed_id,
    CASE c.cust_type_cd 
        WHEN 'I' THEN 
            (SELECT concat(i.fname, ' ', i.lname) FROM individual i WHERE i.cust_id = c.cust_id)
        WHEN 'B' THEN 
            (SELECT b.name FROM business b WHERE b.cust_id = c.cust_id)
        ELSE 'Unknown'
    END AS name
FROM customer c;

-- transform results
SELECT date_part('year', open_date) AS year, count(*) how_many FROM account
    WHERE open_date > '2002-12-31' GROUP BY date_part('year', open_date);
/* to 2 columns by year */
SELECT
    sum(CASE 
            WHEN extract(year FROM open_date) = 2003 THEN 1 ELSE 0
        END) AS year_2003,
    sum(CASE 
            WHEN extract(year FROM open_date) = 2004 THEN 1 ELSE 0
        END) AS year_2004
FROM account
WHERE open_date > '2002-12-31';

/* conditions can use any query types */
CASE (SELECT count(*) FROM account a WHERE a.cust_id = cust_id)
    WHEN 0 THEN 'None'
    WHEN 1 THEN '1'
    ELSE '2+'
END 

CASE 
    WHEN EXISTS (SELECT 1 FROM account 1 WHERE a.cust_id = cust_id) THEN 'Y'
    ELSE 'N'
END 

-- prevent division by 0
SELECT cust_id, product_cd, avail_balance /
    CASE 
        WHEN tot_balance = 0 THEN 1
        ELSE tot_balance
    END 
FROM account;

-- handle NULL
SELECT emp_id, fname, lname, 
    CASE 
        WHEN title IS NULL THEN 'Unknown'
        ELSE title
    END
FROM employee;

/* or in calculations */
SELECT <calcs> + CASE WHEN a IS NULL THEN 0 ELSE 1 END + <rest calcs>;

-- -------------
-- Tasks:

/* 11.1 */
SELECT emp_id,
    CASE 
        WHEN title IN ('President', 'Vice President', 'Treasurer', 'Loan Manager') 
            THEN 'Managent'
        WHEN title IN ('Operations Manager', 'Head Teller', 'Teller')
            THEN 'Operations'
        ELSE 'Unknown'
    END
FROM employee;

/* 11.2 */
SELECT open_branch_id, count(*) FROM account GROUP BY open_branch_id;

SELECT 
    sum(case open_branch_id WHEN 1 THEN 1 ELSE 0 END) AS branch_1,
    sum(case open_branch_id WHEN 2 THEN 1 ELSE 0 END) AS branch_2,
    sum(case open_branch_id WHEN 3 THEN 1 ELSE 0 END) AS branch_3,
    sum(case open_branch_id WHEN 4 THEN 1 ELSE 0 END) AS branch_4
FROM account;

