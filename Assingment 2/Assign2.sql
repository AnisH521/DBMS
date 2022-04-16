/*Question/*

Consider the database schema Employee(Eid,
Name, Depid, Qualification, Age), Salary(Eid, Basic, D.A. HRA, Bonus, Total_Salary) and
write SQL queries for the following:

Contains: 
Eid in both the tables is the primary key.
Age must be greater than 18 and less than 60.
Eid is a 6 digit alphanumeric code stars with 'EMP" followed by 3 digit number. 

(Maintain at insertion)
Depid is a 6 digit alphanumeric code stats with 'Dep' followed by 3 digit number. (Maintain at insertion)
D.A is 25% of the Basic Salary.
HRA is 8% of the Basic Salary.
Bonus is 5% of Basic Salary.

Task: 
Update the Depid field of Employee table with char(6) not null data type.
Insert at least 5 more rows in each table.


Queries:
Display the name of the oldest employee.
Display the name, age, and qualification of the employees who are associated with Depid = 'Dep103'.
Display the average salary of the employees.
Display the employees' details who gets salary more than average salary.
Display the average salary of the employees who are associated with Depid = 'Dep101'.


/*Solution*/


/*Using Assingment 1*/

USE Assign_1;

/*Task:*/
/*Update the Depid field of Employee table with char(6) not null data type.*/

ALTER TABLE Employee MODIFY DEPID char(6) NOT NULL;

/*Deleting and then updating DEPID Column in Employee*/

ALTER TABLE Employee DROP COLUMN Depid;

ALTER TABLE Employee ADD COLUMN DEPID VARCHAR(6) NOT NULL AFTER Name;
 
UPDATE Employee SET DEPID ='DEP101' WHERE EID = 'EMP123';
UPDATE Employee SET DEPID ='DEP102' WHERE EID = 'EMP124';
UPDATE Employee SET DEPID ='DEP103' WHERE EID = 'EMP125';
UPDATE Employee SET DEPID ='DEP104' WHERE EID = 'EMP126';
UPDATE Employee SET DEPID ='DEP105' WHERE EID = 'EMP127';
UPDATE Employee SET DEPID ='DEP101' WHERE EID = 'EMP128';
UPDATE Employee SET DEPID ='DEP101' WHERE EID = 'EMP129';
UPDATE Employee SET DEPID ='DEP103' WHERE EID = 'EMP130';
UPDATE Employee SET DEPID ='DEP103' WHERE EID = 'EMP131';
UPDATE Employee SET DEPID ='DEP105' WHERE EID = 'EMP132';

/*Insert at least 5 more rows in each table.*/

INSERT INTO 
	Employee 
VALUES
	('EMP133','Ankit Debnath','DEP102','Madhyamik',23),
    ('EMP134','Raktim Ghoshal','DEP102','Madhyamik',23),
    ('EMP135','Samrat Bardhan','DEP104','Post_Grad',21),
    ('EMP136','Mukesh Bardhan','DEP103','Post_Grad',21),
    ('EMP137','Avik Roy','DEP101','Post_Grad',21);
    
ALTER TABLE Salary DROP COLUMN Total_Sal;

ALTER TABLE Salary ADD COLUMN Total_Sal DECIMAL(12,4) AS (BASic + DA + HRA + Bonus) NOT NULL;
    
INSERT INTO
	Salary (EID,Basic)
VALUES
	('EMP133',8000),
    ('EMP134',7000),
    ('EMP135',9800),
    ('EMP136',8700),
    ('EMP137',8000);
    
/*Queries:*/

/*Display the name of the oldest employee.*/

SELECT 
    Name, MAX(Age) AS Oldest_Employee
FROM
    Employee;

/*Display the name, age, and qualification of the employees who are associated with Depid = 'Dep103'*/

SELECT 
    Name, Age, Qualification
FROM
    Employee
WHERE
    DEPID = 'DEP103';

/*Display the average salary of the employees*/

SELECT 
    AVG(Total_Sal) AS Average_Salary
FROM
    Salary;

/*Display the employees' details who gets salary more than average salary*/

SELECT 
    e.Name, e.EID, e.DEPID, s.Total_Sal
FROM
    Employee e,
    Salary s
WHERE
    Total_Sal > (SELECT 
            AVG(Total_Sal)
        FROM
            Salary)
        AND e.EID = s.EID;

/*Display the average salary of the employees who are associated with Depid = 'Dep101'*/

SELECT 
    e.DEPID, COUNT(*) AS 'Number of Employee', AVG(Total_Sal)
FROM
    Employee e,
    Salary s
WHERE
    e.EID = s.EID AND DEPID = 'DEP101';
