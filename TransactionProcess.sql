create table Accounts(
AccountId int primary key, 
AccountName varchar(50),
Balance decimal(10, 2)
);

insert into Accounts (AccountID, AccountName, Balance) values (1, 'Alice', 5000.00);
insert into Accounts (AccountID, AccountName, Balance) values (2, 'Bob', 3000.00);

start transaction;

update Accounts set Balance = Balance - 1000.00 where AccountID = 1; 

update Accounts set Balance = Balance + 1000.00 where AccountID = 2;

commit;

select * from Accounts;

start transaction;

update Accounts Set Balance = Balance -1000.00 where AccountID = 1;

savepoint sp1;

Update Accounts set balance = balance + 1000.00 where AccountID = 2;

commit; 

select * from Accounts;

delimiter //

create procedure TransferFunds( 
in FromAccount int, 
in toAccounnt int , 
in amount decimal(10, 2)
)

begin
declare exit handler for sqlexception
begin 
rollback;
end; 


start transaction; 

update Accounts set balance = balance - ammount where accountid = fromAccount; 

update Accounts set balance = balance + ammount where accountid = toAccount; 

commit;
end; 



