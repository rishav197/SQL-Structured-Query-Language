show databases;

use top10qna;


/*------------------- SQL Top 10 Interview QnA -------------------------------------------*/

select * from employee;
select * from employeedetail;

-- Q1(a): Find the list of employees whose salary ranges between 2L to 3L.
select * from employee where Salary between 200000 and 300000;
-- or 
select * from employee where Salary>200000 and Salary<300000;

-- Q1(b): Write a query to retrieve the list of employees from the same city.
select e1.* 
from employee e1, employee e2 
where e1.City=e2.City and e1.EmpID!=e2.EmpID;

-- Q1(c): Query to find the null values in the Employee table. 
select * from employee where EmpID is NULL;


-- Q2(a): Query to find the cumulative sum of employee’s salary.
select EmpID, sum(Salary) over (order by EmpID) as CumSalary from employee;
select EmpID, Salary from employee;


--  Q2(b): What’s the male and female employees ratio.
select 
	sum(Gender='M')/count(*) as MaleRatio, 
	sum(Gender='F')/count(*) as FemaleRatio 
from employee;

-- select count(Gender='M') from employee;


--  Q2(c): Write a query to fetch 50% records from the Employee table.

-- method-1
select * from employee 
where EmpID <= (select count(*)/2 from employee);

-- method-2 (If EmpID is not auto-increment field or numeric, then we can use Row NUMBER function)
select * from (
select *, row_number() over (order by EmpID) as row_num from employee) as emp
where emp.row_num <= (select count(*)/2 from employee);


-- Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’ i.e12345 will be 123XX
-- method-1
select EmpID, EmpName, concat(substr(cast(Salary as char), 1, length(Salary)-2), 'XX') as Salary from employee;

-- method-2
select EmpID, EmpName, concat(left(Salary, length(Salary)-2), 'XX') as Salary from employee;


-- Q4: Write a query to fetch even and odd rows from Employee table.

/* If you have an auto-increment field 
like EmpID then we can use the 
MOD() function
*/

-- Fetch even rows
select * from employee where mod(EmpID, 2)=0;

-- Fetch odd rows
select * from employee where mod(EmpID, 2)!=0;


--  Method-2: General Solution using ROW_NUMBER()

-- fetch even rows
select * from (
select *, row_number() over(order by EmpID) as row_num from employee
) as emp
where mod(emp.row_num, 2)=0;

-- fetch odd rows
select EmpID, EmpName, Gender, Salary, City from (
select *, row_number() over(order by EmpID) as row_num from employee
) as emp
where mod(emp.row_num, 2)!=0;

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
select * from employee where EmpName like '_A%';

-- • Contains ‘Y’ alphabet at second last place
select * from employee where EmpName like '%Y_';

-- • Ends with ‘L’ and contains 4 alphabets 
select * from employee where EmpName like '___L';

-- • Begins with ‘V’ and ends with ‘A’
select * from employee where EmpName like 'V%A';


-- Q5(b): Write a query to find the list of Employee names which is:
/* 
• starting with vowels (a, e, i, o, or u), without duplicates
• ending with vowels (a, e, i, o, or u), without duplicates
• starting & ending with vowels (a, e, i, o, or u), without duplicates
*/

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
-- 3rd highest salary
select * from employee order by Salary DESC limit 1 offset 2;

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

-- Second Highest Salary
select * from employee emp1 
where 2 = (
	select count(distinct emp2.EmpID)
    from employee emp2
    where emp2.Salary >= emp1.Salary
);


--  Q7(a): Write a query to find and remove duplicate records from a table.

-- To find duplicate records
select *, count(*) from employee 
group by EmpID, EmpName, Gender, Salary, City
having count(*)>1;
 
 -- Or
 -- To find duplicate records

  
 -- To Delete duplicate records
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY EmpID ORDER BY EmpID) AS rn
    FROM Employee
)
DELETE FROM employee
WHERE EmpID in (select EmpID from CTE where rn > 1);

    
-- Q7(b): Query to retrieve the list of employees working in same project.
select ed1.EmpID, ed2.Project from employeedetail ed1, employeedetail ed2
where ed1.Project=ed2.Project and ed1.EmpID!=ed2.EmpID order by ed1.Project;


--  Q8: Show the employee with the highest salary for each project
/* Similarly we can find Total Salary for each 
project, just use SUM() instead of MAX()
*/
select e.EmpID, ed.Project, max(e.Salary) as ProjSalary 
from employee e inner join employeedetail ed on e.EmpID=ed.EmpID
group by ed.Project 
order by ProjSalary desc;

 
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
select YEAR(ed.DOJ) as JoinYr, count(*) as EmpCount
from employee e inner join employeedetail ed on e.EmpID=ed.EmpID
group by JoinYr
order by JoinYr;

-- Q10: Create 3 groups based on salary col, salary less than 1L is low, between 1-2L is medium and above 2L is High
select *,
case 
	when Salary > 200000 then 'High'
    when Salary >= 100000 and Salary <= 200000 then 'medium'
    else 'low'
end as SalStatus
from employee;


/* BONUS:
 Query to pivot the data in the Employee table and retrieve the total 
salary for each city. 
The result should display the EmpID, EmpName, and separate columns for each city 
(Mathura, Pune, Delhi), containing the corresponding total salary.
*/

SELECT EmpID, EmpName,
SUM(CASE WHEN City = 'Mathura' THEN Salary END) AS "Mathura",
SUM(CASE WHEN City = 'Pune' THEN Salary END) AS "Pune",
SUM(CASE WHEN City = 'Delhi' THEN Salary END) AS "Delhi",
SUM(CASE WHEN City = 'Bangalore' THEN Salary END) AS "Bangalore"
FROM Employee
GROUP BY City;
 
