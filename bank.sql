BEGIN TRANSACTION;
CREATE TABLE customer (
  cust_id serial NOT NULL PRIMARY KEY
,  fed_id varchar(12) NOT NULL
,  cust_type_cd text  NOT NULL
,  address varchar(30) DEFAULT NULL
,  city varchar(20) DEFAULT NULL
,  state varchar(20) DEFAULT NULL
,  postal_code varchar(10) DEFAULT NULL
);

CREATE TABLE business (
  cust_id integer  NOT NULL
,  name varchar(40) NOT NULL
,  state_id varchar(10) NOT NULL
,  incorp_date date DEFAULT NULL
,  PRIMARY KEY (cust_id)
,  CONSTRAINT fk_b_cust_id FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
);

CREATE TABLE branch (
  branch_id serial NOT NULL PRIMARY KEY
,  name varchar(20) NOT NULL
,  address varchar(30) DEFAULT NULL
,  city varchar(20) DEFAULT NULL
,  state varchar(2) DEFAULT NULL
,  zip varchar(12) DEFAULT NULL
);

CREATE TABLE department (
  dept_id serial NOT NULL PRIMARY KEY
,  name varchar(20) NOT NULL
);

CREATE TABLE employee (
  emp_id serial NOT NULL PRIMARY KEY
,  fname varchar(20) NOT NULL
,  lname varchar(20) NOT NULL
,  start_date date NOT NULL
,  end_date date DEFAULT NULL
,  superior_emp_id integer  DEFAULT NULL
,  dept_id integer  DEFAULT NULL
,  title varchar(20) DEFAULT NULL
,  assigned_branch_id integer  DEFAULT NULL
,  CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES department (dept_id)
,  CONSTRAINT fk_e_branch_id FOREIGN KEY (assigned_branch_id) REFERENCES branch (branch_id)
,  CONSTRAINT fk_e_emp_id FOREIGN KEY (superior_emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE product_type (
  product_type_cd varchar(10) NOT NULL
,  name varchar(50) NOT NULL
,  PRIMARY KEY (product_type_cd)
);

CREATE TABLE product (
  product_cd varchar(10) NOT NULL
,  name varchar(50) NOT NULL
,  product_type_cd varchar(10) NOT NULL
,  date_offered date DEFAULT NULL
,  date_retired date DEFAULT NULL
,  PRIMARY KEY (product_cd)
,  CONSTRAINT fk_product_type_cd FOREIGN KEY (product_type_cd) REFERENCES product_type (product_type_cd)
);

CREATE TABLE account (
  account_id serial  NOT NULL PRIMARY KEY
,  product_cd varchar(10) NOT NULL
,  cust_id integer  NOT NULL
,  open_date date NOT NULL
,  close_date date DEFAULT NULL
,  last_activity_date date DEFAULT NULL
,  status text  DEFAULT NULL
,  open_branch_id integer  DEFAULT NULL
,  open_emp_id integer  DEFAULT NULL
,  avail_balance decimal(10,2) DEFAULT NULL
,  pending_balance decimal(10,2) DEFAULT NULL
,  CONSTRAINT fk_a_branch_id FOREIGN KEY (open_branch_id) REFERENCES branch (branch_id)
,  CONSTRAINT fk_a_cust_id FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
,  CONSTRAINT fk_a_emp_id FOREIGN KEY (open_emp_id) REFERENCES employee (emp_id)
,  CONSTRAINT fk_product_cd FOREIGN KEY (product_cd) REFERENCES product (product_cd)
);

CREATE TABLE individual (
  cust_id integer  NOT NULL
,  fname varchar(30) NOT NULL
,  lname varchar(30) NOT NULL
,  birth_date date DEFAULT NULL
,  PRIMARY KEY (cust_id)
,  CONSTRAINT fk_i_cust_id FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
);

CREATE TABLE officer (
  officer_id serial NOT NULL PRIMARY KEY 
,  cust_id integer  NOT NULL
,  fname varchar(30) NOT NULL
,  lname varchar(30) NOT NULL
,  title varchar(20) DEFAULT NULL
,  start_date date NOT NULL
,  end_date date DEFAULT NULL
,  CONSTRAINT fk_o_cust_id FOREIGN KEY (cust_id) REFERENCES business (cust_id)
);

CREATE TABLE transaction (
  txn_id serial NOT NULL PRIMARY KEY 
,  txn_date timestamp NOT NULL
,  account_id integer  NOT NULL
,  txn_type_cd text  DEFAULT NULL
,  amount decimal(10,2) NOT NULL
,  teller_emp_id integer  DEFAULT NULL
,  execution_branch_id integer  DEFAULT NULL
,  funds_avail_date timestamp DEFAULT NULL
,  CONSTRAINT fk_exec_branch_id FOREIGN KEY (execution_branch_id) REFERENCES branch (branch_id)
,  CONSTRAINT fk_t_account_id FOREIGN KEY (account_id) REFERENCES account (account_id)
,  CONSTRAINT fk_teller_emp_id FOREIGN KEY (teller_emp_id) REFERENCES employee (emp_id)
);

INSERT INTO branch VALUES(1,'Headquarters','3882 Main St.','Waltham','MA','02451');
INSERT INTO branch VALUES(2,'Woburn Branch','422 Maple St.','Woburn','MA','01801');
INSERT INTO branch VALUES(3,'Quincy Branch','125 Presidential Way','Quincy','MA','02169');
INSERT INTO branch VALUES(4,'So. NH Branch','378 Maynard Ln.','Salem','NH','03079');

INSERT INTO customer VALUES(1,'111-11-1111','I','47 Mockingbird Ln','Lynnfield','MA','01940');
INSERT INTO customer VALUES(2,'222-22-2222','I','372 Clearwater Blvd','Woburn','MA','01801');
INSERT INTO customer VALUES(3,'333-33-3333','I','18 Jessup Rd','Quincy','MA','02169');
INSERT INTO customer VALUES(4,'444-44-4444','I','12 Buchanan Ln','Waltham','MA','02451');
INSERT INTO customer VALUES(5,'555-55-5555','I','2341 Main St','Salem','NH','03079');
INSERT INTO customer VALUES(6,'666-66-6666','I','12 Blaylock Ln','Waltham','MA','02451');
INSERT INTO customer VALUES(7,'777-77-7777','I','29 Admiral Ln','Wilmington','MA','01887');
INSERT INTO customer VALUES(8,'888-88-8888','I','472 Freedom Rd','Salem','NH','03079');
INSERT INTO customer VALUES(9,'999-99-9999','I','29 Maple St','Newton','MA','02458');
INSERT INTO customer VALUES(10,'04-1111111','B','7 Industrial Way','Salem','NH','03079');
INSERT INTO customer VALUES(11,'04-2222222','B','287A Corporate Ave','Wilmington','MA','01887');
INSERT INTO customer VALUES(12,'04-3333333','B','789 Main St','Salem','NH','03079');
INSERT INTO customer VALUES(13,'04-4444444','B','4772 Presidential Way','Quincy','MA','02169');

INSERT INTO department VALUES(1,'Operations');
INSERT INTO department VALUES(2,'Loans');
INSERT INTO department VALUES(3,'Administration');

INSERT INTO product_type VALUES('ACCOUNT','Customer Accounts');
INSERT INTO product_type VALUES('INSURANCE','Insurance Offerings');
INSERT INTO product_type VALUES('LOAN','Individual and Business Loans');

INSERT INTO product VALUES('AUT','auto loan','LOAN','2004-01-01',NULL);
INSERT INTO product VALUES('BUS','business line of credit','LOAN','2004-01-01',NULL);
INSERT INTO product VALUES('CD','certificate of deposit','ACCOUNT','2004-01-01',NULL);
INSERT INTO product VALUES('CHK','checking account','ACCOUNT','2004-01-01',NULL);
INSERT INTO product VALUES('MM','money market account','ACCOUNT','2004-01-01',NULL);
INSERT INTO product VALUES('MRT','home mortgage','LOAN','2004-01-01',NULL);
INSERT INTO product VALUES('SAV','savings account','ACCOUNT','2004-01-01',NULL);
INSERT INTO product VALUES('SBL','small business loan','LOAN','2004-01-01',NULL);

INSERT INTO employee VALUES(1,'Michael','Smith','2005-06-22',NULL,NULL,3,'President',1);
INSERT INTO employee VALUES(2,'Susan','Barker','2006-09-12',NULL,1,3,'Vice President',1);
INSERT INTO employee VALUES(3,'Robert','Tyler','2005-02-09',NULL,1,3,'Treasurer',1);
INSERT INTO employee VALUES(4,'Susan','Hawthorne','2006-04-24',NULL,3,1,'Operations Manager',1);
INSERT INTO employee VALUES(5,'John','Gooding','2007-11-14',NULL,4,2,'Loan Manager',1);
INSERT INTO employee VALUES(6,'Helen','Fleming','2008-03-17',NULL,4,1,'Head Teller',1);
INSERT INTO employee VALUES(7,'Chris','Tucker','2008-09-15',NULL,6,1,'Teller',1);
INSERT INTO employee VALUES(8,'Sarah','Parker','2006-12-02',NULL,6,1,'Teller',1);
INSERT INTO employee VALUES(9,'Jane','Grossman','2006-05-03',NULL,6,1,'Teller',1);
INSERT INTO employee VALUES(10,'Paula','Roberts','2006-07-27',NULL,4,1,'Head Teller',2);
INSERT INTO employee VALUES(11,'Thomas','Ziegler','2004-10-23',NULL,10,1,'Teller',2);
INSERT INTO employee VALUES(12,'Samantha','Jameson','2007-01-08',NULL,10,1,'Teller',2);
INSERT INTO employee VALUES(13,'John','Blake','2004-05-11',NULL,4,1,'Head Teller',3);
INSERT INTO employee VALUES(14,'Cindy','Mason','2006-08-09',NULL,13,1,'Teller',3);
INSERT INTO employee VALUES(15,'Frank','Portman','2007-04-01',NULL,13,1,'Teller',3);
INSERT INTO employee VALUES(16,'Theresa','Markham','2005-03-15',NULL,4,1,'Head Teller',4);
INSERT INTO employee VALUES(17,'Beth','Fowler','2006-06-29',NULL,16,1,'Teller',4);
INSERT INTO employee VALUES(18,'Rick','Tulman','2006-12-12',NULL,16,1,'Teller',4);

INSERT INTO account VALUES(1,'CHK',1,'2000-01-15',NULL,'2005-01-04','ACTIVE',2,10,1057.75,1057.75);
INSERT INTO account VALUES(2,'SAV',1,'2000-01-15',NULL,'2004-12-19','ACTIVE',2,10,500.0,500.0);
INSERT INTO account VALUES(3,'CD',1,'2004-06-30',NULL,'2004-06-30','ACTIVE',2,10,3000.0,3000.0);
INSERT INTO account VALUES(4,'CHK',2,'2001-03-12',NULL,'2004-12-27','ACTIVE',2,10,2258.0199999999999817,2258.0199999999999817);
INSERT INTO account VALUES(5,'SAV',2,'2001-03-12',NULL,'2004-12-11','ACTIVE',2,10,200.0,200.0);
INSERT INTO account VALUES(7,'CHK',3,'2002-11-23',NULL,'2004-11-30','ACTIVE',3,13,1057.75,1057.75);
INSERT INTO account VALUES(8,'MM',3,'2002-12-15',NULL,'2004-12-05','ACTIVE',3,13,2212.5,2212.5);
INSERT INTO account VALUES(10,'CHK',4,'2003-09-12',NULL,'2005-01-03','ACTIVE',1,1,534.12000000000000453,534.12000000000000453);
INSERT INTO account VALUES(11,'SAV',4,'2000-01-15',NULL,'2004-10-24','ACTIVE',1,1,767.76999999999998181,767.76999999999998181);
INSERT INTO account VALUES(12,'MM',4,'2004-09-30',NULL,'2004-11-11','ACTIVE',1,1,5487.0900000000001456,5487.0900000000001456);
INSERT INTO account VALUES(13,'CHK',5,'2004-01-27',NULL,'2005-01-05','ACTIVE',4,16,2237.9699999999997999,2897.9699999999997997);
INSERT INTO account VALUES(14,'CHK',6,'2002-08-24',NULL,'2004-11-29','ACTIVE',1,1,122.37000000000000455,122.37000000000000455);
INSERT INTO account VALUES(15,'CD',6,'2004-12-28',NULL,'2004-12-28','ACTIVE',1,1,10000.0,10000.0);
INSERT INTO account VALUES(17,'CD',7,'2004-01-12',NULL,'2004-01-12','ACTIVE',2,10,5000.0,5000.0);
INSERT INTO account VALUES(18,'CHK',8,'2001-05-23',NULL,'2005-01-03','ACTIVE',4,16,3487.1900000000000546,3487.1900000000000546);
INSERT INTO account VALUES(19,'SAV',8,'2001-05-23',NULL,'2004-10-12','ACTIVE',4,16,387.99000000000000909,387.99000000000000909);
INSERT INTO account VALUES(21,'CHK',9,'2003-07-30',NULL,'2004-12-15','ACTIVE',1,1,125.6700000000000017,125.6700000000000017);
INSERT INTO account VALUES(22,'MM',9,'2004-10-28',NULL,'2004-10-28','ACTIVE',1,1,9345.5499999999992726,9845.5499999999992726);
INSERT INTO account VALUES(23,'CD',9,'2004-06-30',NULL,'2004-06-30','ACTIVE',1,1,1500.0,1500.0);
INSERT INTO account VALUES(24,'CHK',10,'2002-09-30',NULL,'2004-12-15','ACTIVE',4,16,23575.119999999998982,23575.119999999998982);
INSERT INTO account VALUES(25,'BUS',10,'2002-10-01',NULL,'2004-08-28','ACTIVE',4,16,0.0,0.0);
INSERT INTO account VALUES(27,'BUS',11,'2004-03-22',NULL,'2004-11-14','ACTIVE',2,10,9345.5499999999992726,9345.5499999999992726);
INSERT INTO account VALUES(28,'CHK',12,'2003-07-30',NULL,'2004-12-15','ACTIVE',4,16,38552.050000000002911,38552.050000000002911);
INSERT INTO account VALUES(29,'SBL',13,'2004-02-22',NULL,'2004-12-17','ACTIVE',3,13,50000.0,50000.0);

INSERT INTO business VALUES(10,'Chilton Engineering','12-345-678','1995-05-01');
INSERT INTO business VALUES(11,'Northeast Cooling Inc.','23-456-789','2001-01-01');
INSERT INTO business VALUES(12,'Superior Auto Body','34-567-890','2002-06-30');
INSERT INTO business VALUES(13,'AAA Insurance Inc.','45-678-901','1999-05-01');

INSERT INTO individual VALUES(1,'James','Hadley','1977-04-22');
INSERT INTO individual VALUES(2,'Susan','Tingley','1973-08-15');
INSERT INTO individual VALUES(3,'Frank','Tucker','1963-02-06');
INSERT INTO individual VALUES(4,'John','Hayward','1971-12-22');
INSERT INTO individual VALUES(5,'Charles','Frasier','1976-08-25');
INSERT INTO individual VALUES(6,'John','Spencer','1967-09-14');
INSERT INTO individual VALUES(7,'Margaret','Young','1951-03-19');
INSERT INTO individual VALUES(8,'George','Blake','1982-07-01');
INSERT INTO individual VALUES(9,'Richard','Farley','1973-06-16');

INSERT INTO officer VALUES(1,10,'John','Chilton','President','1995-05-01',NULL);
INSERT INTO officer VALUES(2,11,'Paul','Hardy','President','2001-01-01',NULL);
INSERT INTO officer VALUES(3,12,'Carl','Lutz','President','2002-06-30',NULL);
INSERT INTO officer VALUES(4,13,'Stanley','Cheswick','President','1999-05-01',NULL);

INSERT INTO "transaction" VALUES(1,'2008-01-05',3,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(2,'2008-01-05',15,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(3,'2008-01-05',17,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(4,'2008-01-05',23,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(5,'2008-01-05',1,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(6,'2008-01-05',4,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(7,'2008-01-05',7,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(8,'2008-01-05',10,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(9,'2008-01-05',13,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(10,'2008-01-05',14,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(11,'2008-01-05',18,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(12,'2008-01-05',21,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(13,'2008-01-05',24,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(14,'2008-01-05',28,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(15,'2008-01-05',8,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(16,'2008-01-05',12,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(17,'2008-01-05',22,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(18,'2008-01-05',2,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(19,'2008-01-05',5,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(20,'2008-01-05',11,'DBT',100.0,NULL,NULL,'2008-01-05');
INSERT INTO "transaction" VALUES(21,'2008-01-05',19,'DBT',100.0,NULL,NULL,'2008-01-05');

CREATE INDEX "idx_officer_fk_o_cust_id" ON "officer" (cust_id);
CREATE INDEX "idx_employee_fk_e_emp_id" ON "employee" (superior_emp_id);
CREATE INDEX "idx_employee_fk_dept_id" ON "employee" (dept_id);
CREATE INDEX "idx_employee_fk_e_branch_id" ON "employee" (assigned_branch_id);
CREATE INDEX "idx_product_fk_product_type_cd" ON "product" (product_type_cd);
CREATE INDEX "idx_account_fk_product_cd" ON "account" (product_cd);
CREATE INDEX "idx_account_fk_a_cust_id" ON "account" (cust_id);
CREATE INDEX "idx_account_fk_a_branch_id" ON "account" (open_branch_id);
CREATE INDEX "idx_account_fk_a_emp_id" ON "account" (open_emp_id);
CREATE INDEX "idx_transaction_fk_t_account_id" ON "transaction" (account_id);
CREATE INDEX "idx_transaction_fk_teller_emp_id" ON "transaction" (teller_emp_id);
CREATE INDEX "idx_transaction_fk_exec_branch_id" ON "transaction" (execution_branch_id);
COMMIT;
