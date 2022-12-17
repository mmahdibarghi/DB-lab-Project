CREATE TRIGGER ChangeInNeedPersonTotalRecivedMoney
ON Donation
AFTER INSERT
AS BEGIN	
UPDATE PersonInNeed 
SET PersonInNeed.TotalMoneyReceived = 
(
SELECT SUM(Amount) FROM Donation GROUP BY ClientID
HAVING  ClientID IN (SELECT ClientID FROM inserted)
)
Where PersonInNeed.PersonInNeedID IN (SELECT ClientID FROM inserted)
END;









CREATE TRIGGER ChangeInNeedPersonTotalRecivedMoney
ON Donation
AFTER INSERT
AS BEGIN	
UPDATE PersonInNeed 
SET PersonInNeed.TotalMoneyReceived =TotalMoneyReceived + 
(select SUM(Amount) FROM inserted GROUP BY ClientID)
Where PersonInNeed.PersonInNeedID IN (SELECT ClientID FROM inserted GROUP BY ClientID)
END;


drop trigger ChangeInNeedPersonTotalRecivedMoney













CREATE TRIGGER ChangeAccountBalance ON PayToCharity
FOR INSERT AS 
BEGIN
UPDATE Account
SET TotalBalance = 
(SELECT SUM(Amount)
FROM PayToCharity INNER JOIN Account ON PayToCharity.AccountId = Account.AccountId
WHERE PayToCharity.AccountId IN 
(
SELECT PayToCharity.AccountId
FROM
(
SELECT *
FROM INSERTED EXCEPT 
SELECT *
FROM PayToCharity) as Temp
)
)
END;




CREATE TRIGGER ChangeAccountBalance
ON PayToCharity
AFTER INSERT
AS BEGIN	
UPDATE Account 
SET TotalBalance =TotalBalance + 
(select SUM(Amount) FROM inserted GROUP BY AccountID HAVING Account.AccountID = inserted.AccountID)
Where Account.AccountID IN (SELECT AccountID FROM inserted GROUP BY AccountID)
END;


drop TRIGGER ChangeAccountBalance

























CREATE TRIGGER UpdateTotalHelp
ON PayToCharity
After INSERT	
AS
    SElect @amountInserted = inserted.amount from inserted
    select @helperId = inserted.helperId from inserted
	Update Helper
    set TotalHelped = TotalHelped + @amountInserted
    where Helper.HelperId = @helperId

