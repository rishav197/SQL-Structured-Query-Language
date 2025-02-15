CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);


INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        

SELECT * FROM worker;        
        
CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

SELECT * FROM bonus;



CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

SELECT * FROM title;


/* 50 SQL Questions */
/*
*/
/* Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
 */
SELECT FIRST_NAME AS WORKER_NAME FROM worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(FIRST_NAME) FROM worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DEPARTMENT FROM worker GROUP BY DEPARTMENT;
SELECT DISTINCT DEPARTMENT FROM worker; -- using 'distinct' keyword

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTRING(FIRST_NAME, 1, 3) AS FIRST_NAME FROM worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
SELECT INSTR(FIRST_NAME, 'b') FROM worker WHERE FIRST_NAME='Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(FIRST_NAME) FROM worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT DEPARTMENT, LENGTH(DEPARTMENT) FROM worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME, 'a', 'A') FROM worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS COMPLETE_NAME FROM worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker ORDER BY FIRST_NAME;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker ORDER BY FIRST_NAME, DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE FIRST_NAME IN ('Vipul', 'Satish');


-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');


-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
SELECT * FROM worker WHERE DEPARTMENT LIKE 'Admin%';


-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM worker WHERE FIRST_NAME LIKE '%a%';


-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM worker WHERE FIRST_NAME LIKE '%a';


-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE FIRST_NAME LIKE '_____h';


-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM worker WHERE SALARY BETWEEN 100000 AND 500000;


-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM worker WHERE YEAR(JOINING_DATE) = 2014 AND MONTH(JOINING_DATE)=02;


-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT DEPARTMENT, COUNT(DEPARTMENT) FROM worker WHERE DEPARTMENT = 'Admin';
SELECT DEPARTMENT, COUNT(*) FROM worker WHERE DEPARTMENT = 'Admin';


-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME FROM worker WHERE SALARY BETWEEN 50000 AND 100000;


-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS no_of_workers FROM worker GROUP BY DEPARTMENT ORDER BY COUNT(DEPARTMENT) DESC;


-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT w.* FROM worker AS w INNER JOIN title AS t ON w.WORKER_ID = t.WORKER_REF_ID WHERE t.WORKER_TITLE = 'Manager';


-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
SELECT WORKER_TITLE, COUNT(*) AS Count FROM title GROUP BY WORKER_TITLE HAVING COUNT(*) > 1;


-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM worker WHERE MOD (WORKER_ID, 2) != 0;
SELECT * FROM worker WHERE MOD (WORKER_ID, 2) <> 0; -- alternative way (this sign '<>' also works as NOT Equal to)

-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM worker WHERE MOD (WORKER_ID, 2) = 0;


-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE worker_clone LIKE worker;
INSERT INTO worker_clone SELECT * FROM worker;
SELECT * FROM worker_clone;


-- Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT worker.* from worker inner join worker_clone using(worker_id);


-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
SELECT worker.* FROM worker as w LEFT JOIN worker_clone AS wc USING(WORKER_ID) WHERE wc.WORKER_ID is NULL;


-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT CURDATE();
SELECT NOW() AS DateTime;


-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 5;


-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table. (IMP Ques)
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 4, 1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword. (IMP Ques)
SELECT * FROM worker w1
	WHERE 4 = 
    (
		SELECT COUNT(DISTINCT (w2.salary))
			FROM worker w2 WHERE w2.salary >= w1.salary
	);
 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT * FROM WORKER w1, WORKER w2 WHERE w1.SAlARY = w2.SALARY AND w1.WORKER_ID != w2.WORKER_ID;
SELECT w1.* FROM WORKER w1, WORKER w2 WHERE w1.SAlARY = w2.SALARY AND w1.WORKER_ID != w2.WORKER_ID; -- prefer it than above


-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT MAX(SALARY) FROM worker WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM worker);


-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM worker
UNION ALL
SELECT * FROM worker ORDER BY WORKER_ID;


-- Q-38. Write an SQL query to list worker_id who does not get bonus.
SELECT WORKER_ID FROM worker WHERE WORKER_ID NOT IN (SELECT WORKER_REF_ID FROM bonus);


-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM worker WHERE WORKER_ID <= (SELECT COUNT(WORKER_ID)/2 FROM worker);


-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS depCount FROM worker GROUP BY DEPARTMENT HAVING depCount<4;


-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS depCount FROM worker GROUP BY DEPARTMENT;


-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM worker WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM WORKER);


-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM worker WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM WORKER);


-- Q-44. Write an SQL query to fetch the last five records from a table.
(SELECT * FROM worker ORDER BY WORKER_ID DESC limit 5) ORDER BY WORKER_ID;


-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT w.DEPARTMENT, w.FIRST_NAME, w.SALARY FROM (SELECT MAX(SALARY) AS mxSal, DEPARTMENT FROM worker GROUP BY DEPARTMENT) temp
	INNER JOIN worker w ON temp.DEPARTMENT = w.DEPARTMENT AND temp.mxSAL = w.SALARY;

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM worker w1 
	WHERE 3 >= (
		SELECT COUNT(DISTINCT SALARY) FROM worker w2 WHERE w1.SALARY <= w2.SALARY
    ) ORDER BY w1.SALARY DESC;
-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT FROM LEC-9.

-- Using Limit
SELECT DISTINCT SALARY FROM worker ORDER BY SALARY DESC LIMIT 3; 


-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM worker w1 
	WHERE 3 >= (
		SELECT COUNT(DISTINCT SALARY) FROM worker w2 WHERE w1.SALARY >= w2.SALARY
    ) ORDER BY w1.SALARY ASC;
    

-- Q-48. Write an SQL query to fetch nth max salaries from a table. (Just a generalization of Q-46)
SELECT DISTINCT SALARY FROM worker w1 
	WHERE n >= (
		SELECT COUNT(DISTINCT SALARY) FROM worker w2 WHERE w1.SALARY <= w2.SALARY
    ) ORDER BY w1.SALARY DESC;


-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT, SUM(SALARY) AS depSALARY FROM worker GROUP BY DEPARTMENT;


-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME, SALARY FROM worker WHERE SALARY = (SELECT MAX(SALARY) FROM worker);


-- Q-51: Extra question 
USE tempdb; 
CREATE TABLE pairs(
A INT,
B INT
);

INSERT INTO pairs 
	VALUES 	(1, 2), 
			(2, 4), 
			(2, 1),
			(3, 2), 
            (4, 2), 
            (5, 6), 
            (6, 5), 
            (7, 8);

SELECT * FROM pairs;

-- Q-51: Remove reversed pairs
-- Method-1 : JOINS
SELECT lt.* FROM pairs lt LEFT JOIN pairs rt ON lt.A = rt.B AND lt.B = rt.A
	WHERE rt.A iS NULL OR lt.A < rt.A;
    
-- Method-2 : Corelated Subquery
SELECT * FROM pairs p1 WHERE NOT EXISTS (SELECT * FROM pairs p2 WHERE p1.B = p2.A AND p1.A = p2.B AND p1.A>p2.A);

-- H.W : DRY RUN, DRY RUN And DRY RUN help you to understand Corelated subqueries in depth
    
    
    