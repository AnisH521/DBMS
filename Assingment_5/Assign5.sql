CREATE DATABASE Assign5;

USE Assign5;

/*Department(DepID, DDesc, Area, EstdDate)*/

CREATE TABLE Department (
    DEPID VARCHAR(6) PRIMARY KEY,
    DDesc VARCHAR(20) DEFAULT NULL,
    Area VARCHAR(20) NOT NULL,
    EstdDate DATE
);

/*Personal(Empno, Name, DOB, Native_place, Hobby)*/

CREATE TABLE Personal (
    EMPNO INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    Native_Place VARCHAR(20) NOT NULL,
    Hobby VARCHAR(20) DEFAULT NULL
); 

/*Job(Empno, App_date, Salary, Retd_date, Dept)*/

CREATE TABLE Job (
    EMPNO INT AUTO_INCREMENT PRIMARY KEY,
    App_Date DATE NOT NULL,
    Salary DECIMAL(12 , 4 ) NOT NULL,
    Retd_date DATE DEFAULT NULL,
    Dept VARCHAR(6) NOT NULL,
    FOREIGN KEY (Dept)
        REFERENCES Department (DEPID)
);

/*HoD(DepID, Head)*/

CREATE TABLE HOD (
    DEPID VARCHAR(6) NOT NULL,
    Head INT NOT NULL,
    FOREIGN KEY (DEPID)
        REFERENCES Department (DEPID),
    FOREIGN KEY (Head)
        REFERENCES Personal (EMPNO)
);

/*Insert at least 5 department details, 15 employee details*/

INSERT INTO Department VALUES
('DEP101','Human Resource','Howrah','2012-06-21'),
('DEP102','Management','Sealdah','2012-08-21'),
('DEP103','Sales','Kolkata','2013-03-09'),
('DEP104','Product Design','Kolkata','2016-12-01'),
('DEP105','Marketing','Kolkata','2010-11-01');

/*INSERTING VALUES INTO Personal*/

INSERT INTO Personal (Name,DOB,Native_Place,Hobby) VALUES
('Sharmistha Das','1996-12-03','Behala','Teaching'),
('Suman Das','1994-12-03','Dhakuria','Playing Games'),
('Subhranil Sarkar','1986-11-07','Krishnanagar','Reading Books'),
('Haider Ali','1990-12-19','Murshidabad','Reading Books'),
('Anish Naskar','1984-09-07','Dhakuria','Watching Movie'),
('Sharmistha Shenoy','1996-12-03','Khardah','Teaching'),
('Anindita Dey','1994-12-09','Dhakuria','Playing Games'),
('Subhranil Sen','1986-11-07','Krishnanagar','Reading Books'),
('Wasim Zafar','1990-12-19','Murshidabad','Reading Books'),
('Anish Das','1984-09-07','Dhakuria','Watching Movie'),
('Roop Das','1999-12-03','Behala','Walking'),
('Suman Das','1990-12-03','Dhakuria','Playing Games'),
('Subhranil Paul','1986-11-07','Krishnanagar','Reading Books'),
('Haider Ali','1990-12-19','Murshidabad','Reading Books'),
('Anish Naskar','1980-09-07','Dhakuria','Watching Movie');

/*INSERTING VALUES INTO job*/

INSERT INTO Job (App_Date,Salary,Retd_date,Dept) VALUES
('2010-07-08','9000','2026-01-25','DEP101'),
('2011-07-08','10000','2029-01-25','DEP101'),
('2007-06-08','8000','2031-01-25','DEP104'),
('2010-07-08','5000','2025-01-25','DEP103'),
('2010-07-08','12000','2026-08-25','DEP105'),
('2012-04-09','9000','2036-01-25','DEP102'),
('2000-07-08','13000','2022-01-25','DEP102'),
('2011-07-08','9000','2026-01-25','DEP101'),
('2007-07-08','10000','2021-01-25','DEP105'),
('2011-07-08','9000','2029-01-25','DEP103'),
('2012-04-09','9000','2036-01-25','DEP102'),
('2000-07-08','13000','2022-01-25','DEP102'),
('2011-07-08','9000','2026-01-25','DEP101'),
('2007-07-08','10000','2021-01-25','DEP105'),
('2011-07-08','9000','2029-01-25','DEP103');

/*INSERTING INTO HOD*/

INSERT INTO HOD VALUES
('DEP101',1),
('DEP102',7),
('DEP103',15),
('DEP104',3),
('DEP105',5);

/*QUERIES*/

/*Show Empno, Name, Hobby, and Salary in decreasing order of Salary*/

SELECT 
    p.empno, p.name, p.hobby, j.salary
FROM
    personal p,
    job j
WHERE
    p.empno = j.empno
ORDER BY Salary DESC;

/*Show how many employees shall retire today if the maximum length of service is 20 years*/

SELECT 
    COUNT(*)
FROM
    job
WHERE
    (YEAR(CURDATE()) - YEAR(App_date) = 20);

/*Show those employee names and DOB who have served more than 17 years as of today*/

SELECT 
    p.Name, p.DOB
FROM
    job j,
    Personal p
WHERE
    (YEAR(CURDATE()) - YEAR(App_date) > 17)
        AND p.EMPNO = j.EMPNO;

/*Show appointment date and native place of those whose name starts with ‘A’ or ends in ‘d’*/

SELECT 
    j.app_date, p.Native_Place
FROM
    job j,
    Personal p
WHERE
    j.EMPNO = p.EMPNO
        AND ((p.Name LIKE 'A%') OR (p.Name LIKE '%d'));

/*Show the additional burden on the company in case salary of employees having a hobby as sports is increased by 10%*/
/*I Used Reading Books As Hobby In this Case as sports instance was not available in My Hobby Attribute*/

SELECT 
    ((SUM(j.salary) + SUM(j.salary) * 0.1) - SUM(j.salary)) AS 'Additional Burden'
FROM
    Job j,
    Personal p
WHERE
    J.EMPNO = P.EMPNO
        AND P.hobby = 'Reading Books';

