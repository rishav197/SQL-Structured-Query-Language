-- To see all databases
SHOW DATABASES;

CREATE DATABASE tempDB;

USE tempdb;

SHOW TABLES;

/* Table 1 : Employee */
CREATE TABLE employee(
	id INT PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255),    
    age INT,
    emailid VARCHAR(255),    
    phoneNo INT,
    city VARCHAR(255)
);

DESC employee;


INSERT INTO employee 
VALUES
	(1, 'Aman', 'Proto', 32, 'aman@gmail.com', 898, 'Delhi'),
	(2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', 222, 'Palam'),
	(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', 444, 'Kolkata'),
    (4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', 666, 'Raipur'),
    (5, 'PK', 'Pandey', 21, 'pk@gmail.com', 555, 'Jaipur');
    

SELECT * FROM employee;

/* Table 2 : Client */
CREATE TABLE client(
	id INT PRIMARY KEY,
    first_name VARCHAR(255),   
    last_name VARCHAR(255),    
    age INT,
	emailID VARCHAR(255),
    phoneNo INT,
    city VARCHAR(255),
    empID INT,
    FOREIGN KEY(empID) references employee(id)
);

INSERT INTO client 
VALUES
	(1, 'Mac', 'Rogers', 47, 'mac@gmail.com', 333, 'Kolkata', 3),
	(2, 'Max', 'Poirier', 27, 'max@gmail.com', 222, 'Kolkata', 3),
	(3, 'Peter', 'Jain', 24, 'peter@gmail.com', 111, 'Delhi', 1),
	(4, 'Sushant', 'Aggarwal', 23, 'sushant@gmail.com', 45454, 'Hyderabad', 5),
    (5, 'Pratap', 'Singh', 36, 'p@gmail.com', 77767, 'Mumbai', 2);


SELECT * FROM client;


/* Table 3 : Project */
CREATE TABLE project(
	id INT PRIMARY KEY,
    empID INT,
    name VARCHAR(255),    
    startdate DATE,
	clientID INT,
    FOREIGN KEY(empID) references employee(id),
    FOREIGN KEY(clientID) references client(id)
);


INSERT INTO project 
VALUES
	(1, 1, 'A', '2021-04-21', 3),
	(2, 2, 'B', '2021-03-12', 1),
    (3, 3, 'C', '2021-01-16', 5),
    (4, 3, 'D', '2021-04-27', 2),
    (5, 5, 'E', '2021-05-01', 4);
    
    
SELECT * FROM project;


/* JOINS 
1. INNER JOIN
2. OUTER JOIN
	2.1 LEFT JOIN
    2.2 RIGHT JOIN
    2.3 FULL JOIN
3. CROSS JOIN
4. SELF JOIN
*/

/* INNER JOIN
Ques: Enlist all the employee ID's names along with the project allocated to them.
*/

SELECT e.id, e.fname, e.lname, p.id, p.name FROM employee as e INNER JOIN project as p
	ON e.id = p.empID;

SELECT * FROM employee as e INNER JOIN project as p ON e.id = p.empID;
	
/* Ques: Fetch out all the employee ID's and their contact details who has been working from
Jaipur with the clients name working in Hyderabad.
*/
SELECT e.id, e.emailid, e.phoneNo, c.first_name, c.last_name FROM employee as e INNER JOIN client as c 
	ON e.id = c.empID WHERE e.city = 'Jaipur' AND c.city = 'Hyderabad';


/* LEFT JOIN 
Ques: Fetch out each project allocated to each employee.
*/
SELECT * FROM employee as e LEFT JOIN project as p ON e.id = p.empID;

/* RIGHT JOIN 
Ques: List out all the projects along with the employee's name and their respective 
allocated email ID.
*/
SELECT p.id, p.name, e.fname, e.lname, e.emailid FROM employee as e RIGHT JOIN project as p
	ON e.id = p.empID;


/* CROSS JOIN
Ques: List out all the combinations possible for the employee's name and projects that can exist.
*/
SELECT e.fname, e.lname, p.id, p.name FROM employee as e CROSS JOIN project as p;


/* Can we use JOIN without using keyword */
SELECT e.id, e.fname, e.lname, p.id, p.name FROM employee as e, project as p 
	WHERE e.id = p.empID;



/* --------------------------------SET Operations------------------------------- */
CREATE TABLE dept1(
	empid INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(255)
);

CREATE TABLE dept2(
	empid INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(255)
);

INSERT INTO dept1 
VALUES 
	(1, 'A', 'engineer'),
    (2, 'B', 'salesman'),
    (3, 'C', 'manager'),
    (4, 'D', 'salesman'),
    (5, 'E', 'engineer');

INSERT INTO dept2 
VALUES 
	(3, 'C', 'manager'),
    (6, 'F', 'marketing'),
    (7, 'G', 'salesman');
    
SELECT * FROM dept1;
SELECT * FROM dept2;

/* 1. UNION */
-- List out all the employees in the company
SELECT * FROM dept1
UNION 
SELECT * FROM dept2;

-- List out all the employees in all departments who work as salesman
SELECT * FROM dept1 WHERE role='salesman'
UNION
SELECT * FROM dept2 WHERE role='salesman';

/* 2. INTERSECT */
-- List out all the employees who work for both the departments.
SELECT * FROM dept1 INNER JOIN dept2 USING(empid); 
SELECT dept1.* FROM dept1 INNER JOIN dept2 USING(empid); -- prefer this

/* 3. MINUS */
-- List out all the employees working in dept1 but not in dept2. 
SELECT dept1.* FROM dept1 LEFT JOIN dept2 USING(empid) WHERE dept2.empid is NULL;


/* -------------------SUB QUERIES ----------------------------- */
USE tempdb;

-- 1. WHERE clause and same table 
-- Ques: employees with age>30

SELECT * FROM employee WHERE age IN (SELECT age FROM employee WHERE age>30);

-- 2. WHERE clause and different table 
-- Ques: emp details working in more than 1 project

SELECT * FROM employee WHERE id IN (SELECT empID FROM project GROUP BY empID HAVING COUNT(empID)>1);

-- 3. Single Value Subquery
-- emp details having age > avg(age)
SELECT * FROM employee WHERE age > (SELECT AVG(age) FROM employee);


-- 4. FROM Clause - derived tables
-- select max age person whose first name contains 'a'
SELECT MAX(age) FROM (SELECT * FROM employee WHERE fname like '%a%') AS tempTable;

-- 5. Corelated subquery
-- find 3rd oldest employee 
SELECT * FROM employee e1 WHERE 3 = (
	SELECT COUNT(e2.age) FROM employee e2 WHERE e2.age >= e1.age
);


/* VIEW */
SELECT * FROM employee;

-- Creating a view 
CREATE VIEW custom_view AS SELECT fname, age FROM employee;


-- Viewing from VIEW
SELECT * FROM custom_view;

-- ALTERING the VIEW
ALTER VIEW custom_view AS SELECT fname, lname, age FROM employee;

-- DROPING the VIEW
DROP VIEW IF EXISTS custom_view;


