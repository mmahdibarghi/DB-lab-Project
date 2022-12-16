CREATE TRIGGER ChangeInNeedPersonTotalRecivedMoney
ON Donation
AFTER INSERT
AS BEGIN
Select * from inserted;
UPDATE PersonInNeed 
SET PersonInNeed.TotalMoneyReceived = 
(
SELECT SUM(Amount) FROM Donation GROUP BY ClientID
HAVING  ClientID IN (SELECT ClientID FROM inserted)
)
Where PersonInNeed.PersonInNeedID IN (SELECT ClientID FROM inserted)
END;







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



CREATE TRIGGER UpdateTotalHelp
ON PayToCharity
After INSERT	
AS
    SElect @amountInserted = inserted.amount from inserted
    select @helperId = inserted.helperId from inserted
	Update Helper
    set TotalHelped = TotalHelped + @amountInserted
    where Helper.HelperId = @helperId

