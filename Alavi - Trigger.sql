

CREATE TRIGGER ChangeAccountBalance
ON PayToCharity
AFTER INSERT
AS BEGIN	
UPDATE Account 
SET TotalBalance =TotalBalance + 
(select SUM(Amount) FROM inserted GROUP BY AccountID HAVING Account.AccountID = inserted.AccountID)
Where Account.AccountID IN (SELECT AccountID FROM inserted GROUP BY AccountID)
END;



CREATE TRIGGER ChangeAccountBalanceWithDonation
ON Donation
AFTER insert
AS BEGIN	
UPDATE Account 
SET TotalBalance =TotalBalance - 
(select SUM(Amount) FROM inserted GROUP BY AccountID HAVING Account.AccountID = inserted.AccountID)
Where Account.AccountID IN (SELECT AccountID FROM inserted GROUP BY AccountID)
END;


