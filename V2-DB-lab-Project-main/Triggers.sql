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

select * from Account;

drop TRIGGER ChangeAccountBalance;
CREATE TRIGGER ChangeAccountBalance ON PayToCharity
FOR INSERT AS 
BEGIN
UPDATE Account
SET TotalBalance = ISNULL(TotalBalance,0) +
(
SELECT ISNULL(INSERTED.Amount,0)
FROM Account LEFT JOIN INSERTED ON Account.AccountId = INSERTED.AccountId
)
END;

insert into PayToCharity (HelperID, CharityBoxID, CharityBoxReceiverID, AccountID, AdminID, Amount, PaymentDate, PaymentType, HasPaid) values (75, 5, 2, 3, '1', '$38.67', '2022-11-23', 'CharityBox', '1');

insert into PayToCharity (HelperID, CharityBoxID, CharityBoxReceiverID, AccountID, AdminID, Amount, PaymentDate, PaymentType, HasPaid) values (75, 5, 2, 4, '1', '$10', '2022-11-23', 'CharityBox', '1');


CREATE TRIGGER DecreaseAccountBalance ON Donation
FOR INSERT AS 
BEGIN
UPDATE Account
SET TotalBalance = ISNULL(TotalBalance,0) -
(SELECT SUM(Amount)
FROM Donation INNER JOIN Account ON Donation.AccountId = Account.AccountId
WHERE Donation.AccountId IN 
(
SELECT Donation.AccountId
FROM
(
SELECT *
FROM DELETED
) as Temp
)
)
END;



CREATE TRIGGER UpdateTotalHelp
ON PayToCharity
AFTER INSERT	
AS
    SELECT @amountInserted = inserted.amount FROM inserted
    SELECT @helperId = inserted.helperId FROM inserted
	UPDATE Helper
    SET TotalHelped = TotalHelped + @amountInserted
    WHERE Helper.HelperId = @helperId

