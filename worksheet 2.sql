-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dname VARCHAR(50),
    Dnumber INT PRIMARY KEY,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);

-- Insert data into DEPARTMENT table
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES
('Research', 5, '333445555', '1988-05-22'),
('Administration', 4, '987654321', '1995-01-01'),
('Headquarters', 1, '888665555', '1981-06-19');

-- Create EMPLOYEE table without the Super_ssn constraint
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Dno INT,
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into EMPLOYEE table
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Dno) VALUES
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, 1);

-- Update EMPLOYEE table to add Super_ssn values
ALTER TABLE EMPLOYEE ADD Super_ssn CHAR(9), ADD FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

UPDATE EMPLOYEE SET Super_ssn = '333445555' WHERE Ssn = '123456789';
UPDATE EMPLOYEE SET Super_ssn = '888665555' WHERE Ssn = '333445555';
UPDATE EMPLOYEE SET Super_ssn = '987654321' WHERE Ssn = '999887777';
UPDATE EMPLOYEE SET Super_ssn = '888665555' WHERE Ssn = '987654321';
UPDATE EMPLOYEE SET Super_ssn = '333445555' WHERE Ssn = '666884444';
UPDATE EMPLOYEE SET Super_ssn = '333445555' WHERE Ssn = '453453453';
UPDATE EMPLOYEE SET Super_ssn = '987654321' WHERE Ssn = '987987987';
UPDATE EMPLOYEE SET Super_ssn = NULL WHERE Ssn = '888665555';

-- Create DEPT_LOCATIONS table
CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT,
    Dlocation VARCHAR(50),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into DEPT_LOCATIONS table
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- Create PROJECT table
CREATE TABLE PROJECT (
    Pname VARCHAR(50),
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(50),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into PROJECT table
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Create WORKS_ON table
CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(3, 1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- Insert data into WORKS_ON table
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 30.0),
('987987987', 10, 35.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

-- Create DEPENDENT table
CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(50),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- Insert data into DEPENDENT table
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('666884444', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

SELECT Fname, Minit, Lname, Address
FROM EMPLOYEE
WHERE Sex = 'M';

SELECT E.Fname AS Employee_Fname, E.Minit AS Employee_Minit, E.Lname AS Employee_Lname, 
       S.Fname AS Supervisor_Fname, S.Minit AS Supervisor_Minit, S.Lname AS Supervisor_Lname, 
       D.Dname AS Department_Name
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE S ON E.Super_ssn = S.Ssn
JOIN DEPARTMENT D ON E.Dno = D.Dnumber;

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Ssn = D.Mgr_ssn
WHERE D.Dname = 'Administration';

SELECT E.Fname, E.Minit, E.Lname, P.Pname
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber;

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
WHERE D.Sex = 'F' AND D.Relationship = 'Daughter';

SELECT DISTINCT D.Dname
FROM DEPARTMENT D
JOIN DEPT_LOCATIONS L ON D.Dnumber = L.Dnumber
WHERE L.Dlocation = 'Houston';

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE E.Dno = 5 AND W.Hours > 10 AND P.Pname = 'ProductX';

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name;

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN EMPLOYEE S ON E.Super_ssn = S.Ssn
WHERE S.Fname = 'Franklin' AND S.Lname = 'Wong';

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE P.Pname = 'ProductX' AND E.Salary > 28000;







