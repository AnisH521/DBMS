/*QUESTION*/

/*Consider the database schema Employee(Eid, Name, Depid, Qualification, Age), 
Salary(Eid, Basic, D.A. HRA, Bonus, Total_Salary) and
Department(Depid, Desc, HoD, Location)
write SQL queries for the following:

Contains: 
Eid in both the tables is the primary key.
Age must be greater than 18 and less than 60.
Eid is a 6 digit alphanumeric code stars with 'EMP" followed by 3 digit number. (Maintain at insertion)
Depid is a 6 digit alphanumeric code stats with 'Dep' followed by 3 digit number. (Maintain at insertion)
D.A is 25% of the Basic Salary.
HRA is 8% of the Basic Salary.
Bonus is 5% of Basic Salary.
Depid is the primary key in the Department table.
HoD represents Head of the Department must be an Employee from Employee table, stores Eid.
Desc is department description.

Task: 
Create the Department table with the above-mentioned details.
Insert all the Department details in the Department table.
Add new Field NoE in the Department table. NoE represents the number of employees present in the Employee Department for a specific department.
Update the NoE field values using a query by counting the number of employees from the Employees table.

Queries:
Display the name and qualification of all the HoDs whose department is located in Kolkata.
Display the name, department, and salary of all the employees that are HoD of some department
Display the details of all the employees who are younger than average employee age.
Display the details of the highest-paid HoD.
Change the HoD of Dep103 to Emp109.
Display the department details and average salary received by each Department.*/


/*SOULTION*/

/*Create Database Assign_3*/

CREATE DATABASE Assign_3;

/*USING the Database*/

USE Assign_3;

/*Creating Table Employee*/

CREATE TABLE Employee(
	EID VARCHAR(6) Primary Key,
    Name VARCHAR(15) NOT NULL,
    DEPID VARCHAR(6) NOT NULL,
    Qualification VARCHAR(10) NOT NULL,
    Age INT CHECK (Age < 60 AND Age > 18) NOT NULL);
    
/*Creating TAble Salary*/

CREATE TABLE Salary(
	EID VARCHAR(6) Primary Key,
    Basic DECIMAL(12,4) NOT NULL,
    DA DECIMAL(12,4) AS (Basic*0.25),
    HRA DECIMAL(12,4) AS (Basic*0.08),
    Bonus DECIMAL(12,4) AS (Basic*0.05),
    Total_salary DECIMAL(12,4) AS (Basic + DA + HRA + Bonus));
    
/*Creating Table Department*/

CREATE TABLE Department(
	DEPID VARCHAR(6) PRIMARY KEY,
    Description VARCHAR(20) DEFAULT NULL,
    HOD VARCHAR(6) NOT NULL,
    Location VARCHAR(20) NOT NULL);
    
/*Inserting Data Into Tables*/

INSERT INTO Employee Values
('EMP101','Kaustav Sen','DEP101','Post_Grad',22),
('EMP102','Subhranil Sur','DEP103','Post_Grad',23),
('EMP103','Sharmistha Das','DEP105','Graduate',22),
('EMP104','Harshita Kaur','DEP102','Madhyamik',22),
('EMP105','Suman Das','DEP103','HS',23),
('EMP106','Hrisikesh Mal','DEP104','Post_Grad',22),
('EMP107','Ayantika Dey','DEP103','Madhyamik',23),
('EMP108','Rakesh Parwal','DEP101','Graduate',24),
('EMP109','Somsubhra Das','DEP105','Madhyamik',22),
('EMP110','sayani Sen','DEP102','HS',24),
('EMP111','Ankit Debnath','DEP102','Madhyamik',23),
('EMP112','Raktim Ghoshal','DEP102','Madhyamik',23),
('EMP113','Samrat Bardhan','DEP104','Post_Grad',21),
('EMP114','Mukesh Bardhan','DEP103','Post_Grad',21),
('EMP115','Avik Roy','DEP101','Post_Grad',21);

INSERT INTO Salary (EID,Basic) VALUES
	('EMP101',8000),
    ('EMP102',7000),
    ('EMP103',9800),
    ('EMP104',8700),
    ('EMP105',8000),
    ('EMP106',8800),
    ('EMP107',9000),
    ('EMP108',8080),
    ('EMP109',10000),
    ('EMP110',10500),
    ('EMP111',8800),
    ('EMP112',7500),
    ('EMP113',8000),
    ('EMP114',9000),
    ('EMP115',5000);
    
INSERT INTO Department VALUES
	('DEP101','Human Resource','EMP103','Howrah'),
	('DEP102','Management','EMP109','Sealdah'),
	('DEP103','Sales','EMP110','Kolkata'),
	('DEP104','Product Design','EMP104','Kolkata'),
	('DEP105','Marketing','EMP101','Kolkata');
    
/*Add new Field NoE in the Department table. NoE represents the number of employees present in the Employee Department for a specific department*/

ALTER TABLE Department ADD COLUMN NOE INT NOT NULL;

/*Update the NoE field values using a query by counting the number of employees from the Employees table.*/

UPDATE Department 
SET 
    NOE = (SELECT 
            COUNT(*)
        FROM
            Employee e
        WHERE
            DEPID = 'DEP101')
WHERE
    DEPID = 'DEP101';

UPDATE Department 
SET 
    NOE = (SELECT 
            COUNT(*)
        FROM
            Employee e
        WHERE
            DEPID = 'DEP102')
WHERE
    DEPID = 'DEP102';
    
UPDATE Department 
SET 
    NOE = (SELECT 
            COUNT(*)
        FROM
            Employee e
        WHERE
            DEPID = 'DEP103')
WHERE
    DEPID = 'DEP103';
    
UPDATE Department 
SET 
    NOE = (SELECT 
            COUNT(*)
        FROM
            Employee e
        WHERE
            DEPID = 'DEP104')
WHERE
    DEPID = 'DEP104';
    
UPDATE Department 
SET 
    NOE = (SELECT 
            COUNT(*)
        FROM
            Employee e
        WHERE
            DEPID = 'DEP105')
WHERE
    DEPID = 'DEP105';

/*QUERIES*/

/*Display the name and qualification of all the HoDs whose department is located in Kolkata*/

SELECT 
    e.Name, e.Qualification, d.HOD
FROM
    Employee e,
    Department d
WHERE
    e.EID = d.HOD AND Location = 'Kolkata'; 

/*Display the name, department, and salary of all the employees that are HoD of some department*/

SELECT e.Name , d.Description , s.Total_Salary FROM Employee e , Salary s , Department d WHERE (e.EID=d.HOD AND e.EID=s.EID);
 

/*Display the details of all the employees who are younger than average employee age*/

SELECT * FROM Employee WHERE Age < (SELECT AVG(Age) FROM Employee);

/*Display the details of the highest-paid HoD*/

SELECT 
    d.HOD,
    e.Name,
    e.Qualification,
    e.Age,
    d.Description,
    s.Total_Salary
FROM
    Employee e,
    Department d,
    Salary s
WHERE
    (e.EID = d.HOD AND e.EID = s.EID)
        AND s.Total_Salary = (SELECT 
            MAX(Total_Salary)
        FROM
            Employee e,
            Department d,
            Salary s
        WHERE
            (e.EID = d.HOD AND e.EID = s.EID)); 
            
/*Change the HoD of Dep103 to Emp109*/

UPDATE Department SET HOD = 'EMP109' WHERE DEPID = 'DEP103';

/*Display the department details and average salary received by each Department*/

SELECT 
    d.DEPID,
    d.Description,
    AVG(s.Total_Salary) AS 'Average Salary'
FROM
    Employee e,
    Department d,
    Salary s
WHERE
    d.DEPID = e.DEPID AND e.EID = s.EID
GROUP BY DEPID
ORDER BY d.DEPID;
