-- Chapter 12
-- Transactions
-- -------------

/*
    Def: Transaction - grouping of several sql-queries, all or none will be executed
*/

BEGIN [TRANSACTION];

... query 1
... query 2
... query 3

IF true
    COMMIT;
ELSE
    ROLLBACK;
END IF 

COMMIT;

-- Example with savepoints
BEGIN;
    UPDATE product SET dete_retired = current_timestamp() WHERE product_cd = 'XYZ';

    SAVEPOINT before_close_accounts;

    UPDATE account SET status = 'CLOSED', close_date = current_timestamp()
        WHERE product_cd = 'XYZ';

    ROLLBACK TO SAVEPOINT before_close_accounts;
COMMIT;

