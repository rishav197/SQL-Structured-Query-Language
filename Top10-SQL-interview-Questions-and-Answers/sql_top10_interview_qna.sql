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
select * from employee where Salary between 200000 and 300000; 
-- or 
select * from employee where Salary > 200000 and salary < 300000; 

-- Q1(b): Write a query to retrieve the list of employees from the same city.
select e1.EmpID, e1.EmpName, e1.City 
from employee e1, employee e2 
where e1.City=e2.City and e1.EmpID!=e2.EmpID;


-- Q1(c): Query to find the null values in the Employee table. 
select * from employee where EmpID is NULL;


-- Q2(a): Query to find the cumulative sum of employee’s salary.
select EmpID, EmpName, Salary, sum(Salary) over (order by EmpID) as CumSalary from employee;


--  Q2(b): What’s the male and female employees ratio.
SELECT
  SUM(Gender='M')/count(*) AS MalePct,
  SUM(Gender='F')/count(*) AS FemalePct
FROM Employee;


--  Q2(c): Write a query to fetch 50% records from the Employee table.

-- method-1
select * from employee 
where EmpID<=(select count(EmpID)/2 from employee);

-- method-2 (If EmpID is not auto-increment field or numeric, then we can use Row NUMBER function)
select * from 
(select *, row_number() over (order by EmpID) as RowNumber from employee) as emp
where emp.RowNumber<= (select count(RowNumber)/2 from employee);


-- Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’ i.e12345 will be 123XX
-- method-1
select EmpID, EmpName, concat(substr(cast(Salary as char), 1, length(Salary)-2), 'XX') As Salary from employee;

-- method-2
select EmpID, EmpName, concat(left(Salary, length(Salary)-2), 'XX') as Salary from employee;


-- Q4: Write a query to fetch even and odd rows from Employee table.

/* If you have an auto-increment field 
like EmpIDthen we can use the 
MOD() function
*/

-- Fetch even rows
select * from employee where mod(EmpID,2)=0;

-- Fetch odd rows
select * from employee where mod(EmpID,2)=1;


--  Method-2: General Solution using ROW_NUMBER()

-- fetch even rows
select * from 
(select *, row_number() over (order by EmpID) as rownumber from employee) as emp
where emp.rownumber%2=0;

-- fetch odd rows
select * from 
(select *, row_number() over (order by EmpID) as rownumber from employee) as emp
where emp.rownumber%2=1;


-- Q5(a): Write a query to find all the Employee names whose name:
 /* 
 • Begin with ‘A’
 • Contains ‘A’ alphabet at second place
 • Contains ‘Y’ alphabet at second last place
 • Ends with ‘L’ and contains 4 alphabets before L
 • Begins with ‘V’ and ends with ‘A’
*/

select * from employee;

-- • Begin with ‘A’
select * from employee where EmpName like 'A%';

-- • Contains ‘A’ alphabet at second place
select * from employee where EmpName like '_a%';

-- • Contains ‘Y’ alphabet at second last place
select * from employee where EmpName like '%y_';

-- • Ends with ‘L’ and contains 4 alphabets 
select * from employee where EmpName like '____L';

-- • Begins with ‘V’ and ends with ‘A’
select * from employee where EmpName like 'V%A';



-- Q5(b): Write a query to find the list of Employee names which is:
/* 
• starting with vowels (a, e, i, o, or u), without duplicates
• ending with vowels (a, e, i, o, or u), without duplicates
• starting & ending with vowels (a, e, i, o, or u), without duplicates
*/

select * from employee;

-- • starting with vowels (a, e, i, o, or u), without duplicates
select * from employee where lower(EmpName) regexp '^[aeiou]';

-- • ending with vowels (a, e, i, o, or u), without duplicates
select * from employee where lower(EmpName) regexp '[aeiou]$';

-- • starting & ending with vowels (a, e, i, o, or u), without duplicates
select * from employee where lower(EmpName) regexp '^[aeiou].*[aeiou]$';


/*
In MySQL REGEXP (and in most regex engines):

. (dot) → Matches any single character (except newline).
Example: a.b matches acb, a1b, a@b (anything with a + one character + b).

* (asterisk) → Matches zero or more repetitions of the preceding element.
Example: ab* matches a, ab, abb, abbb...
*/


-- Q6: Find Nth highest salary from employee table with and without using the TOP/LIMIT keywords.

-- method-1: Using LIMIT, Second highest Salary
select * from employee order by Salary DESC limit 1 offset 1;

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

select * from employee;

-- method-3: General Solution without using TOP/LIMIT
select Salary from employee e1 
where 3 = (select count(distinct(Salary)) from employee e2 where e2.Salary>=e1.Salary);

-- Or
select Salary from employee e1 
where 2 = (select count(distinct(Salary)) from employee e2 where e2.Salary>e1.Salary);


--  Q7(a): Write a query to find and remove duplicate records from a table.

-- To find duplicate records
SELECT EmpID, EmpName, gender, Salary, city, 
	COUNT(*) AS duplicate_count
	FROM Employee
	GROUP BY EmpID, EmpName, gender, Salary, city
	HAVING COUNT(*) > 1;
 
 -- Or
 -- To find duplicate records
 SELECT EmpID, COUNT(*) AS duplicate_count
	FROM Employee
	GROUP BY EmpID
    HAVING COUNT(*) > 1;
 
 
 -- To Delete duplicate records
 DELETE FROM Employee
 WHERE EmpID IN (SELECT EmpID FROM Employee
 GROUP BY EmpID
 HAVING COUNT(*) > 1);

    
-- Q7(b): Query to retrieve the list of employees working in same project.
WITH CTE AS 
(SELECT e.EmpID, e.EmpName, ed.Project
FROM Employee AS e
INNER JOIN EmployeeDetail AS ed ON e.EmpID = ed.EmpID)
SELECT c1.EmpName, c2.EmpName, c1.project 
FROM CTE c1, CTE c2
WHERE c1.Project = c2.Project AND c1.EmpID != c2.EmpID AND c1.EmpID < c2.EmpID;


--  Q8: Show the employee with the highest salary for each project
/* Similarly we can find Total Salary for each 
project, just use SUM() instead of MAX()
*/

SELECT ed.Project, MAX(e.Salary) AS ProjectSal
 FROM Employee AS e
 INNER JOIN EmployeeDetail AS ed
 ON e.EmpID= ed.EmpID
 GROUP BY Project
 ORDER BY ProjectSal DESC;
 
--  Alternative, more dynamic solution: here you can fetch EmpName, 2nd/3rd highest value, etc
WITH CTE AS 
	(SELECT project, EmpName, salary,
	ROW_NUMBER() OVER (PARTITION BY project ORDER BY salary DESC) AS row_rank
	FROM Employee AS e
	INNER JOIN EmployeeDetail AS ed ON e.EmpID = ed.EmpID)
 SELECT project, EmpName, salary
 FROM CTE
 WHERE row_rank = 1; 


--  Q9: Query to find the total count of employees joined each year
SELECT EXTRACT(YEAR FROM doj) AS JoinYear, COUNT(*) AS EmpCount
FROM Employee AS e
INNER JOIN EmployeeDetail AS ed ON e.EmpID = ed.EmpID 
GROUP BY JoinYear ORDER BY JoinYear ASC;


-- Q10: Create 3 groups based on salary col, salary less than 1L is low, between 1-2L is medium and above 2L is High

SELECT EmpName, Salary,
	CASE
		WHEN Salary > 200000 THEN 'High'
		WHEN Salary >= 100000 AND Salary <= 200000 THEN 'Medium'
		ELSE 'Low'
	END AS SalaryStatus
 FROM Employee;


/* BONUS:
 Query to pivot the data in the Employee table and retrieve the total 
salary for each city. 
The result should display the EmpID, EmpName, and separate columns for each city 
(Mathura, Pune, Delhi), containing the corresponding total salary.
*/
 
SELECT
 EmpID,
 EmpName,
 SUM(CASE WHEN City = 'Mathura' THEN Salary END) AS "Mathura",
 SUM(CASE WHEN City = 'Pune' THEN Salary END) AS "Pune",
 SUM(CASE WHEN City = 'Delhi' THEN Salary END) AS "Delhi"
 FROM Employee
 GROUP BY EmpID, EmpName;
 
 
 