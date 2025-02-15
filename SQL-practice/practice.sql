SHOW Databases;

USE org;

SHOW TABLES;

-- Print account table
SELECT * FROM worker;

SELECT WORKER_ID, FIRST_NAME, SALARY FROM worker WHERE SALARY>=100000;

SELECT * FROM worker WHERE SALARY BETWEEN 200000 AND 500000;

SELECT * FROM worker WHERE LAST_NAME NOT IN ('Singh', 'Kumar', 'Singhal');

SELECT * FROM worker WHERE DEPARTMENT IN ('HR', 'Admin');


-- print all records whose first name ends with char 'a'
SELECT * FROM worker WHERE FIRST_NAME LIKE '%l'; -- Output: Vishal, Vipul

-- print all records whose first name starts with char 'n'
SELECT * FROM worker WHERE FIRST_NAME LIKE 'n%'; -- Output: Niharika

-- print all records whose first name ends with char 'ka'
SELECT * FROM worker WHERE FIRST_NAME LIKE '%ka'; -- Output: Monika, Niharika, Geetika

-- Sort all records based on salary in descending order
SELECT * FROM worker ORDER BY SALARY DESC;


-- DISTINCT keyword
SELECT DISTINCT(DEPARTMENT) FROM worker;


-- GROUP BY
-- Ques: find no. of employees working in diff department
SELECT DEPARTMENT, COUNT(DEPARTMENT) FROM worker GROUP BY DEPARTMENT;

-- with no aggregation  
SELECT DEPARTMENT FROM worker GROUP BY DEPARTMENT;

-- find avg salary pr department 
SELECT DEPARTMENT, avg(SALARY) FROM worker GROUP BY DEPARTMENT;


SELECT DEPARTMENT, COUNT(DEPARTMENT) FROM worker GROUP BY DEPARTMENT HAVING COUNT(DEPARTMENT)>2;


----------------- DB : tempdb ---------------------------------
USE tempdb;
SHOW TABLES;

CREATE TABLE customer(
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


INSERT INTO customer(id, name, pincode) VALUES (1400, 'Chinto', '141001');

UPDATE customer SET address='Sadh nagar' WHERE id=1400;


-- Q1: Enlist all the employees ID's names along with the project allocated to them 
SELECT e.id, e.fname, e.lname, p.id, p.name FROM employee AS e INNER JOIN project AS p
	ON e.id = p.empID;

SELECT * FROM employee AS e INNER JOIN project AS p
	ON e.id = p.empID;

/* Q2: Fetch out all the employee Id's and their contact details who has been working from Jaipur with the
client name workind in hyderabad
*/

SELECT e.id, e.emailid, e.phoneNo, c.first_name, c.last_name FROM employee as e INNER JOIN client as c 
	ON e.id = c.empID WHERE e.city='Jaipur' AND c.city='Hyderabad';
 
SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM client;


/* Q1: list out all the employees in the company */ 
SELECT * FROM dept1 UNION SELECT * FROM dept2;


/* Q2: list out all the employees in all departments who work as salesman */ 
SELECT * FROM dept1 WHERE role='salesman' UNION SELECT * FROM dept2 WHERE role='salesman';

/*Q3 : list out all the employees who work for both the departments */
SELECT dept1.* FROM dept1 INNER JOIN dept2 USING(empid);

/*Q4: list out all the employees working in dept1 but not in dept2 */
SELECT dept1.* FROM dept1 LEFT JOIN dept2 USING(empid) WHERE dept2.empid is NULL;

SELECT * FROM dept1;
SELECT * FROM dept2;


-- ------------- SUB Queries ------------------------
/*Q1 : Employees with age>30 */
SELECT * FROM employee WHERE id IN (SELECT id FROM employee WHERE age>30);


/*Q2: emp details working in more than 1 project */
SELECT * FROM employee WHERE id IN (SELECT empid FROM project GROUP BY empID HAVING COUNT(empid)>1);


/*Q3: Single value subquery */
SELECT * FROM employee WHERE age > (SELECT AVG(age) FROM employee);


/* FROM Clause -- derived tables 
Q4: select max age person whose first name contains 'a'
*/
SELECT MAX(age) FROM (SELECT * FROM employee WHERE fname LIKE '%a%') AS tmp;


SELECT * FROM employee;


-- ---------------------- Custom Views -------------------------------
-- 1. Creating a view 
CREATE VIEW emp_view AS SELECT fname, age FROM employee;

-- Viewing using custom view 'emp_view'
SELECT * FROM emp_view;


-- Altering the view
ALTER VIEW emp_view AS SELECT fname, age, emailid FROM employee;

-- DROPing the view
DROP VIEW IF EXISTS emp_view;

SELECT * FROM employee;





