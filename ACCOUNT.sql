create database College_Projects;
use College_Projects;
CREATE TABLE ACCOUNT (
    ANO INT NOT NULL PRIMARY KEY,
    Aname VARCHAR(15) NOT NULL,
    Address VARCHAR(30) NOT NULL
);
INSERT INTO ACCOUNT (ANO, Aname, Address) VALUES
(101, 'Nirja Singh', 'Bangalore'),
(102, 'Rohan Gupta', 'Chennai'),
(103, 'Ali Reza', 'Hyderabad'),
(104, 'Rishabh Jain', 'Chennai'),
(105, 'Simran Kaur', 'Chandigarh');

CREATE TABLE TRANSACT (
    TRNO CHAR(4) NOT NULL PRIMARY KEY,
    ANO INT NOT NULL,
    AMOUNT DECIMAL(10,2),
    TYPE VARCHAR(10),
    DOT DATE,
    CONSTRAINT fk_transact_ano FOREIGN KEY (ANO) REFERENCES ACCOUNT(ANO)
);
INSERT INTO TRANSACT (TRNO, ANO, AMOUNT, TYPE, DOT) VALUES
('T001', 101, 2500, 'Withdraw', '2017-12-21'),
('T002', 103, 3000, 'Deposit', '2017-06-01'),
('T003', 102, 2000, 'Withdraw', '2017-05-12'),
('T004', 103, 1000, 'Deposit', '2017-10-22'),
('T005', 102, 12000, 'Deposit', '2017-11-06');
ALTER TABLE ACCOUNT ADD COLUMN Account_Type VARCHAR(15) DEFAULT 'Saving';
ALTER TABLE TRANSACT ADD COLUMN Remarks VARCHAR(20) DEFAULT 'Regular';
ALTER TABLE TRANSACT DROP COLUMN Remarks;
ALTER TABLE TRANSACT DROP FOREIGN KEY fk_transact_ano;
ALTER TABLE TRANSACT ADD CONSTRAINT fk_transact_ano FOREIGN KEY (ANO) REFERENCES ACCOUNT(ANO);
DELETE FROM ACCOUNT WHERE ANO = 105;
DELETE FROM TRANSACT WHERE AMOUNT > 3000;
UPDATE ACCOUNT SET Address = 'Mumbai' WHERE Aname = 'Ali Reza';
UPDATE TRANSACT SET AMOUNT = AMOUNT * 1.01 WHERE TYPE = 'Deposit' AND AMOUNT > 2000;






