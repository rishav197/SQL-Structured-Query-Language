-- To see all databases
SHOW DATABASES;

USE temp;

-- To see all tables in the db
SHOW TABLES;

SELECT * FROM account;

DROP TABLE account;


CREATE TABLE Customer(
	id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    gender CHAR(2),
    city VARCHAR(255),
    pincode INT
);


INSERT INTO customer 
VALUES
	(1251, 'Ram Kumar', 'Dilbagh Nagar', 'M', 'Jalandhar', '144002'),
	(1300, 'Shayam Singh', 'Ludhiana H.O', 'M', 'Ludhiana', '141001'),
	(245, 'Neelabh Shukla', 'Ashok Nagar', 'M', 'Jalandhar', '144003'),
	(210, 'Barkha Singh', 'Dilbagh Nagar', 'F', 'Jalandhar', '144002'),
	(500, 'Rohan Arora', 'Ludhiana H.O', 'M', 'Ludhiana', '141001');

INSERT INTO customer
VALUES (1252, 'Ram Kumar3', 'Dilbagh Nagar', 'M', 'Jalandhar', NULL);

SELECT * FROM customer;


/* ------------------------------Table2 : Order_details ----------------------------------------- */
CREATE TABLE Order_details(
Order_id INT PRIMARY KEY,
delivery_date DATE,
cust_id INT,
FOREIGN KEY(cust_id) references customer(id)
);

INSERT INTO Order_details
VALUES (1, '2019-03-11', 245);

SELECT * FROM order_details;



/* --------------------------------Table3 : account --------------------------- */
CREATE TABLE account(
	id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    balance INT NOT NULL DEFAULT 0
);

INSERT INTO account(id, name, balance) VALUES
(1, 'A', 10000);

INSERT INTO account(id, name) VALUES
(2, 'B');

DROP TABLE account;

SELECT * FROM account;

-- ADD new column
ALTER TABLE account ADD interest FLOAT NOT NULL DEFAULT 0;

-- MODIFY 
ALTER TABLE account MODIFY interest DOUBLE NOT NULL DEFAULT 0;

DESC account;

-- CHANGE COLUMN : RENAME The column
ALTER TABLE account CHANGE COLUMN interest saving_interest FLOAT NOT NULL DEFAULT 0;

-- RENAME THE TABLE
ALTER TABLE account_details RENAME TO account;

-- DROP COLUMN 
ALTER TABLE account_details DROP COLUMN saving_interest;



/* ------------------Data Manipulation language -- DML------------------------ */
-- INSERT
SELECT * FROM customer;

DROP TABLE customer;
DROP TABLE order_details;

CREATE TABLE Customer(
	id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    gender CHAR(2),
    city VARCHAR(255),
    pincode INT
);


INSERT INTO customer 
VALUES
	(1300, 'Shayam Singh', 'Ludhiana H.O', 'M', 'Ludhiana', '141001'),
	(245, 'Neelabh Shukla', 'Ashok Nagar', 'M', 'Jalandhar', '144003'),
	(210, 'Barkha Singh', 'Dilbagh Nagar', 'F', 'Jalandhar', '144002'),
	(500, 'Rohan Arora', 'Ludhiana H.O', 'M', 'Ludhiana', '141001');

INSERT INTO customer
VALUES (1, 'Codehelp', 'delhi', 'M', 'Delhi', 110088);

INSERT INTO customer(id, name)
VALUES (121, 'Bob');


-- UPDATE 
UPDATE customer SET address='Mumbai', gender='M' WHERE id=121;

-- UPDATE MULTIPLE ROWS
SET SQL_SAFE_UPDATES = 1;
UPDATE customer SET pincode=110000;

UPDATE customer SET pincode=pincode + 1;


SELECT * FROM customer;


-- DELETE 
DELETE FROM customer WHERE id=121;
DELETE FROM customer; -- To delete all rows of the table

SELECT * FROM customer;
DESC customer;

-- ON Delete Cascade/ ON Delete Set Null
INSERT INTO customer 
VALUES (1, 'Ram kumar3', 'Dilbagh Nagar', 'M', 'Jalandhar', NULL);


CREATE TABLE Order_details(
Order_id INT PRIMARY KEY,
delivery_date DATE,
cust_id INT,
FOREIGN KEY(cust_id) references customer(id) ON DELETE CASCADE
);

INSERT INTO order_details 
VALUES (3, '2019-03-11', 1);

INSERT INTO order_details 
VALUES (4, '2019-03-12', 1);

SELECT * FROM customer;
SELECT * FROM order_details;

DELETE FROM customer WHERE id=1;


-- ON Delete NULL
CREATE TABLE Order_details(
Order_id INT PRIMARY KEY,
delivery_date DATE,
cust_id INT,
FOREIGN KEY(cust_id) references customer(id) ON DELETE SET NULL
);

INSERT INTO order_details 
VALUES (3, '2019-03-11', 1);

INSERT INTO order_details 
VALUES (4, '2019-03-12', 1);

SELECT * FROM customer;
SELECT * FROM order_details;

DELETE FROM customer WHERE id=1;


-- REPLACE
INSERT INTO customer 
VALUES
	(1300, 'Shayam Singh', 'Ludhiana H.O', 'M', 'Ludhiana', '141001'),
	(245, 'Neelabh Shukla', 'Ashok Nagar', 'M', 'Jalandhar', '144003'),
	(210, 'Barkha Singh', 'Dilbagh Nagar', 'F', 'Jalandhar', '144002'),
	(500, 'Rohan Arora', 'Ludhiana H.O', 'M', 'Ludhiana', '141001'),
    (1, 'Codehelp', 'delhi', 'M', 'Delhi', 110088);

-- 1. Act as replace 
REPLACE INTO customer (id, city) VALUES (1, 'Noida');

-- 2. Act as insert
REPLACE INTO customer (id, name, city) VALUES (1333, 'Newbie', 'Gurugram');


-- with diff sytax
REPLACE INTO customer SET id=1300, name='Mac', city='Utah';

REPLACE INTO customer(id, name, city) 
	SELECT id, name, city FROM customer WHERE id=500;
    
SELECT * FROM customer;

