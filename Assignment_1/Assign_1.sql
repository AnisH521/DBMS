/*CREATING DATABASE ASSIGN_1*/

CREATE DATABASE Assign_1;

USE Assign_1;

/*Creating Table Employee*/

CREATE TABLE Employee (
    EID VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(40) NOT NULL,
    DEPID INT NOT NULL,
    Qualification VARCHAR(10) NOT NULL,
    Age INT NOT NULL
);

/*Inserting Values Into Employee*/

INSERT INTO Employee Values
('EMP123','Kaustav Sen',2,'Post_Grad',22),
('EMP124','Subhranil Sarkar',2,'Post_Grad',23),
('EMP125','Sharmistha Shenoy',3,'Graduate',22),
('EMP126','Harshita Kaur',2,'Madhyamik',22),
('EMP127','Suman Das',3,'HS',23),
('EMP128','Hrisikesh Mondal',2,'Post_Grad',22),
('EMP129','Ayantika Dey',3,'Madhyamik',23),
('EMP130','Rakesh Parwal',2,'Graduate',24),
('EMP131','Somsubhra Das',2,'Madhyamik',22),
('EMP132','sayani Sen',2,'HS',24);

/*Creating Table Salary*/

CREATE TABLE Salary(
EID VARCHAR(6) PRIMARY KEY,
Basic DECIMAL(12,4) NOT NULL,
DA DECIMAL(12,4) AS (Basic*0.25),
HRA DECIMAL(12,4) AS (Basic*0.08),
Bonus DECIMAL(12,4) AS (Basic*0.05)
);

/*Inserting Data Into Salary*/

INSERT INTO Salary (EID,Basic) VALUES
	('EMP123',7000),
	('EMP124',7500),
	('EMP125',5000),
	('EMP126',6450),
	('EMP127',8965),
	('EMP128',9000),
	('EMP129',7500),
	('EMP130',4000),
	('EMP131',2000),
	('EMP132',9050);

/*To display the frequency of employees department-wise*/

SELECT 
    COUNT(*) AS Frequency ,
    DEPID
FROM
    Employee
GROUP BY DEPID;

/*To list the names of those employees only whose name starts with ‘H’.*/

SELECT 
    EID, Name
FROM
    Employee
WHERE
    Name LIKE 'H%';
    
/*To add a new column in the salary table. The column name is Total_Sal*/


ALTER TABLE 
	Salary 
ADD 
	Total_Sal DECIMAL(12,4) NOT NULL;
	
/*To store the corresponding values in the Total_Sal column as Basic + D.A. + HRA + Bonus*/

UPDATE 
	Salary
SET
	Total_Sal = (Basic + DA + HRA + Bonus);
