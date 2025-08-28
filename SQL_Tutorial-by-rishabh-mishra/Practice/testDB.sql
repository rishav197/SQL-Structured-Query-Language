SHOW databases;


CREATE DATABASE testdb;

USE testdb;

CREATE TABLE test_data(
	new_id INT,
    new_cat VARCHAR(255)
);

INSERT INTO test_data VALUES
(100, 'Agni'),
(200, 'Agni'),
(500, 'Dharti'),
(700, 'Dharti'),
(200, 'Vayu'),
(300, 'Vayu'),
(500, 'Vayu');


/*----------------------------- WINDOW FUNCTION ---------------------------------------*/

/*---------------Aggregate Function------------------*/
select * from test_data;

SELECT 
    new_id, 
    new_cat,
    SUM(new_id)  OVER (PARTITION BY new_cat) AS `Total`,
    AVG(new_id)  OVER (PARTITION BY new_cat) AS `Average`,
    COUNT(new_id) OVER (PARTITION BY new_cat) AS `Count`,
    MIN(new_id)  OVER (PARTITION BY new_cat) AS `Min`,
    MAX(new_id)  OVER (PARTITION BY new_cat) AS `Max`
FROM test_data;


SELECT 
	new_id, 
    new_cat,
    SUM(new_id)  OVER() AS `Total`,
    AVG(new_id)  OVER() AS `Average`,
    COUNT(new_id) OVER() AS `Count`,
    MIN(new_id)  OVER() AS `Min`,
    MAX(new_id)  OVER() AS `Max`
FROM test_data
ORDER BY new_id;


/*---------------Rank Function------------------*/

SELECT new_id, 
ROW_NUMBER()OVER(ORDER BY new_id) AS "ROW_NUMBER",
RANK() OVER(ORDER BY new_id) AS "RANK",
DENSE_RANK()OVER(ORDER BY new_id) AS "DENSE_RANK",
PERCENT_RANK() OVER(ORDER BY new_id) AS "PERCENT_RANK"
FROM test_data;
 
 
 /*---------------ANALYTIC FUNCTION------------------*/
 
SELECT new_id,
FIRST_VALUE(new_id)  OVER( ORDER BY new_id) AS "FIRST_VALUE",
LAST_VALUE(new_id)  OVER( ORDER BY new_id) AS "LAST_VALUE",  
LEAD(new_id)  OVER( ORDER BY new_id) AS "LEAD",
LAG(new_id)  OVER( ORDER BY new_id) AS "LAG"
FROM test_data;
 
 
 /* Offset the LEAD and LAG values by 2 in the output columns ?
 */
SELECT new_id,
 LEAD(new_id, 2)  OVER( ORDER BY new_id) AS "LEAD_by2",
 LAG(new_id, 2)  OVER( ORDER BY new_id) AS "LAG_by2"
FROM test_data;
 
 
 
 
 /*----------------------------- CASE EXPRESSION ---------------------------------------*/

CREATE TABLE payment(
	customer_id INT,
    amount INT,
    mode VARCHAR(255),
    payment_date DATE
);
 
 
INSERT INTO payment VALUES
	(1, 60, 'Cash', '2020-09-24'),
	(10, 70, 'Mobile Payment', '2021-02-28'),
    (11, 80, 'Cash', '2021-03-01'),
    (2, 500, 'Credit Card', '2020-04-27'),
    (8, 100, 'Credit Card', '2021-01-26');
 
select * from payment; 
 
 -- Case Statment 
SELECT customer_id, amount,
 CASE 
	WHEN amount > 100 THEN 'Expensive Product'
    WHEN amount = 100 THEN 'Moderate Product'
    ELSE 'Inexpensive Product'
END AS ProdStatus
FROM payment;
    
    
select * from payment;

 -- Case Expression 
SELECT customer_id, 
CASE amount 
	WHEN 500 THEN 'Prime Customer'
    WHEN 100 THEN 'Plus Customer'
    ElSE 'Regular Customer'
END AS CustomerStatus
FROM payment;


/* ---------------- Common Table Expression ---------------------------------*/
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    address_id INT
);

select * from customer;

CREATE TABLE payment(
	customer_id INT,
    amount INT,
    mode VARCHAR(100),
    payment_date DATE,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE payment(
	customer_id INT PRIMARY KEY,
    amount INT,
    mode VARCHAR(100),
    payment_date DATE
);


select * from customer;
select * from payment;

-- Single CTEs
WITH my_cte AS (
	SELECT *, AVG(amount) OVER(ORDER BY p.customer_id) AS "Average_Price",
    COUNT(address_id) OVER(ORDER BY c.customer_id) AS "Count"
    FROM payment as p
    INNER JOIN customer AS c
    ON p.customer_id = c.customer_id
)
SELECT customer_id, first_name, last_name, Average_Price, Count 
FROM my_cte;


-- Mulitple CTEs
WITH my_cte1 AS (
SELECT c.*, AVG(amount) OVER(ORDER BY p.customer_id) AS "Average_Price", 
COUNT(address_id) OVER(ORDER BY c.customer_id) AS "Count"
FROM payment as p
INNER JOIN customer AS c
ON p.customer_id= c.customer_id
),
my_cte2 AS (
	SELECT p.*, AVG(amount) OVER(ORDER BY p.customer_id) AS "Average_Price",
    COUNT(address_id) OVER(ORDER BY c.customer_id) AS "Count"
    FROM payment as p
    INNER JOIN customer AS c
    ON p.customer_id = c.customer_id
)
SELECT cte1.first_name, cte1.last_name, cte2.amount, cte2.mode, cte2.payment_date, cte1.Average_Price, cte1.Count 
FROM my_cte1 as cte1, my_cte2 as cte2;


-- Example of CTE
WITH my_cte AS (
	SELECT mode, MAX(amount) AS highest_price, 
	SUM(amount) AS total_price
	FROM payment
	GROUP BY mode
)
SELECT payment.*, my.highest_price, my.total_price
FROM payment
JOIN my_cte my
ON payment.mode = my.mode
ORDER BY payment.mode;

