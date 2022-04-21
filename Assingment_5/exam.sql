CREATE DATABASE Exam;

USE Exam;

/*department(dep_id, dep_name, dep_location)*/

CREATE TABLE Department (
	dep_id INT PRIMARY KEY,
    dep_name VARCHAR(20) NOT NULL,
    dep_location VARCHAR(15) NOT NULL
);

/*salary_grade(grade, min_salary, max_salary)*/

CREATE TABLE Salary_grade (
	grade INTEGER PRIMARY KEY,
    min_salary INTEGER NOT NULL,
    max_salary INTEGER NOT NULL
);

/*employees(emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id)*/

CREATE TABLE Employee (
	emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(15) NOT NULL,
    job_name VARCHAR(10) NOT NULL,
    manager_id INT NOT NULL,
    hire_date DATE DEFAULT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Comission Decimal(7,2) DEFAULT NULL,
    dep_id INT NOT NULL,
    FOREIGN KEY (dep_id)
		REFERENCES DEpartment (dep_id)
);

INSERT INTO Department VALUES 
(1001,'FINANCE','SYDNEY'),
(2001,'AUDIT','MELBOURNE'),
(3001,'MARKETING','PERTH'),
(4001,'PRODUCTION','BRISBANE');

INSERT INTO Employee (emp_id,emp_name,job_name,manager_id,hire_date,Salary,dep_id) VALUES
	(100001,"Kayling","President",68319,"2010-10-05",75000,1001),
	(100002, "Jonas", "Manager",68317, "2012-11-15", 67000,1001),
	(100004, "Peter", "Manager",68381, "2014-05-02", 64000,3001),
	(100005, "Nick", "salesman",68300, "2017-01-31", 62000,4001),
	(100006, "John", "Manager",68341, "2014-11-14", 60000,3001),
	(100007, "Jonas", "Manager",68792, "2013-10-10", 62000,2001),
	(100008, "Jean", "Worker",68097, "2015-06-02", 61000,2001),
	(100010, "Bill", "Analyst",68363, "2012-07-01", 44000,1001),
	(100011, "Gill", "Engineer",68905, "2013-08-24", 67000,1001),
	(100012, "Tomas", "Analyst",68384, "2012-08-09", 54000,3001),
	(100014, "Foggy", "Analyst",68994, "2010-12-22", 59000,2001),
	(100015, "Nikki", "Analyst",68308, "2019-02-28", 51000,4001);

UPDATE Employee SET Comission = 600 WHERE emp_id = 100001;

UPDATE Employee SET Comission = 340 WHERE emp_id = 100007;

UPDATE Employee SET Comission = 540 WHERE emp_id = 100014;

INSERT INTO Salary_grade VALUES
(1, 30000, 40000),
(2, 40000, 50000),
(3, 50000, 60000),
(4, 60000, 70000),
(5, 70000, 80000);

SHOW TABLES;

SELECT * FROM department;
SELECT * FROM Employee;
SELECT * FROM Salary_grade;


/*QUERIES*/

/*Write a query in SQL to list the employee ID, name, salary, department name of all the
'MANAGERS' and 'ANALYST' working in SYDNEY, PERTH with an experience more than 5
years without receiving the commission and display the list in ascending order of location.*/

SELECT 
    e.emp_id, e.emp_name, e.salary, d.dep_name
FROM
    employee e,
    department d
WHERE
    d.dep_location IN ('SYDNEY' , 'PERTH')
        AND e.dep_id = d.dep_id
        AND e.emp_id IN (SELECT 
            e.emp_id
        FROM
            employee e
        WHERE
            e.job_name IN ('MANAGER' , 'ANALYST')
                AND (YEAR(CURDATE()) - YEAR(hire_date)) > 5
                AND e.comission IS NULL)
ORDER BY d.dep_location ASC;

/*Write a query in SQL to list all the employees of grade 2 and 3*/

SELECT 
    *
FROM
    employee e,
    salary_grade s
WHERE
    e.salary BETWEEN s.min_salary AND s.max_salary
        AND s.grade IN (2 , 3);


/*Write a query in SQL to list the details of the employees within grade 3 to 5 and belongs to
SYDNEY. The employees are not in PRESIDENT designated and salary is more than the highest
paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING*/

SELECT 
    *
FROM
    employee
WHERE
    dep_id IN (SELECT 
            dep_id
        FROM
            department
        WHERE
            department.dep_location = 'SYDNEY')
        AND emp_id IN (SELECT 
            emp_id
        FROM
            employee e,
            salary_grade s
        WHERE
            e.salary BETWEEN s.min_salary AND s.max_salary
                AND s.grade IN (3 , 4, 5))
        AND job_name != 'PRESIDENT'
        AND salary > (SELECT 
            MAX(salary)
        FROM
            employee
        WHERE
            dep_id IN (SELECT 
                    dep_id
                FROM
                    department
                WHERE
                    department.dep_location = 'PERTH')
                AND job_name IN ('MANAGER' , 'SALESMAN')
                AND manager_id NOT IN (SELECT 
                    emp_id
                FROM
                    employee
                WHERE
                    emp_name = 'KAYLING'));

/*Write a query in SQL to display all the employees of grade 4 and 5 who are working as ANALYST
or MANAGER*/

SELECT 
    *
FROM
    employee e,
    salary_grade s
WHERE
    e.salary BETWEEN s.min_salary AND s.max_salary
        AND s.grade IN (4 , 5)
        AND e.emp_id IN (SELECT 
            e.emp_id
        FROM
            employee e
        WHERE
            e.job_name IN ('MANAGER' , 'ANALYST'));