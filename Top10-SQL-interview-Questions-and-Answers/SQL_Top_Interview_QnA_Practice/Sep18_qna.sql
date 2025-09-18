CREATE DATABASE top10QNA;

USE top10QNA;

SHOW TABLES;

/* -------------Create Tables: Employee and EmployeeDetail------------------*/

CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar(25),
Gender Char, 
Salary int,
City Char(20)
);

INSERT INTO Employee VALUES 	
	(1, 'Arjun', 'M', 75000,  'Pune'),
	(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
	(3, 'Lalita', 'F', 150000 , 'Mathura'),
	(4, 'Madhav', 'M', 250000 , 'Delhi'),
	(5, 'Visakha', 'F', 120000 , 'Mathura');
    

Desc employee; 

CREATE TABLE  EmployeeDetail (
 EmpID int NOT NULL,
 Project Varchar(25),
 EmpPosition Char(20),
 DOJ date  
 );
 
INSERT INTO EmployeeDetail VALUES 
	(1, 'P1', 'Executive', '2019-01-26'), 
	(2, 'P2', 'Executive', '2020-05-04'),
	(3, 'P1', 'Lead', '2021-10-21'),
	(4, 'P3', 'Manager', '2019-11-29'),
	(5, 'P2', 'Manager', '2020-08-01');


/*------------------- SQL Top 10 Interview QnA -------------------------------------------*/

select * from employee;
select * from employeedetail;

-- Q1(a): Find the list of employees whose salary ranges between 2L to 3L.


-- Q1(b): Write a query to retrieve the list of employees from the same city.


-- Q1(c): Query to find the null values in the Employee table. 


-- Q2(a): Query to find the cumulative sum of employee’s salary.


--  Q2(b): What’s the male and female employees ratio.


--  Q2(c): Write a query to fetch 50% records from the Employee table.

-- method-1


-- method-2 (If EmpID is not auto-increment field or numeric, then we can use Row NUMBER function)


-- Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’ i.e12345 will be 123XX
-- method-1

-- method-2


-- Q4: Write a query to fetch even and odd rows from Employee table.

/* If you have an auto-increment field 
like EmpIDthen we can use the 
MOD() function
*/

-- Fetch even rows

-- Fetch odd rows

--  Method-2: General Solution using ROW_NUMBER()

-- fetch even rows


-- fetch odd rows


-- Q5(a): Write a query to find all the Employee names whose name:
 /* 
 • Begin with ‘A’
 • Contains ‘A’ alphabet at second place
 • Contains ‘Y’ alphabet at second last place
 • Ends with ‘L’ and contains 4 alphabets before L
 • Begins with ‘V’ and ends with ‘A’
*/


-- • Begin with ‘A’

-- • Contains ‘A’ alphabet at second place

-- • Contains ‘Y’ alphabet at second last place

-- • Ends with ‘L’ and contains 4 alphabets 

-- • Begins with ‘V’ and ends with ‘A’


-- Q5(b): Write a query to find the list of Employee names which is:
/* 
• starting with vowels (a, e, i, o, or u), without duplicates
• ending with vowels (a, e, i, o, or u), without duplicates
• starting & ending with vowels (a, e, i, o, or u), without duplicates
*/

-- • starting with vowels (a, e, i, o, or u), without duplicates


-- • ending with vowels (a, e, i, o, or u), without duplicates


-- • starting & ending with vowels (a, e, i, o, or u), without duplicates


/*
In MySQL REGEXP (and in most regex engines):

. (dot) → Matches any single character (except newline).
Example: a.b matches acb, a1b, a@b (anything with a + one character + b).

* (asterisk) → Matches zero or more repetitions of the preceding element.
Example: ab* matches a, ab, abb, abbb...
*/


-- Q6: Find Nth highest salary from employee table with and without using the TOP/LIMIT keywords.

-- method-1: Using LIMIT, Second highest Salary

/* method-2: Using TOP

SELECT TOP 1 Salary 
FROM Employee
 WHERE Salary < (
 SELECT MAX(Salary) FROM Employee)
 AND Salary NOT IN (
 SELECT TOP 2 Salary
 FROM Employee
 ORDER BY Salary DESC)
 ORDER BY Salary DESC;

*/


-- method-3: General Solution without using TOP/LIMIT

-- Or

--  Q7(a): Write a query to find and remove duplicate records from a table.

-- To find duplicate records
 
 -- Or
 -- To find duplicate records
 
 
 -- To Delete duplicate records

    
-- Q7(b): Query to retrieve the list of employees working in same project.


--  Q8: Show the employee with the highest salary for each project
/* Similarly we can find Total Salary for each 
project, just use SUM() instead of MAX()
*/

 
--  Alternative, more dynamic solution: here you can fetch EmpName, 2nd/3rd highest value, etc


--  Q9: Query to find the total count of employees joined each year


-- Q10: Create 3 groups based on salary col, salary less than 1L is low, between 1-2L is medium and above 2L is High


/* BONUS:
 Query to pivot the data in the Employee table and retrieve the total 
salary for each city. 
The result should display the EmpID, EmpName, and separate columns for each city 
(Mathura, Pune, Delhi), containing the corresponding total salary.
*/
 