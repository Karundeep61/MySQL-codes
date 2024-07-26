CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY, 
    AccountName VARCHAR(50),
    Balance DECIMAL(10, 2)
);

INSERT INTO Accounts (AccountID, AccountName, Balance) VALUES (1, 'Alice', 5000.00);
INSERT INTO Accounts (AccountID, AccountName, Balance) VALUES (2, 'Bob', 3000.00);

START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 1000.00 WHERE AccountID = 1; 
UPDATE Accounts SET Balance = Balance + 1000.00 WHERE AccountID = 2;

COMMIT;

SELECT * FROM Accounts;

START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 1000.00 WHERE AccountID = 1;

SAVEPOINT sp1;

UPDATE Accounts SET Balance = Balance + 1000.00 WHERE AccountID = 2;

COMMIT;

SELECT * FROM Accounts;

DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN FromAccount INT, 
    IN ToAccount INT, 
    IN Amount DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
        ROLLBACK;
    END;

    START TRANSACTION; 

    UPDATE Accounts SET Balance = Balance - Amount WHERE AccountID = FromAccount; 
    UPDATE Accounts SET Balance = Balance + Amount WHERE AccountID = ToAccount; 

    COMMIT;
END //

DELIMITER ;
