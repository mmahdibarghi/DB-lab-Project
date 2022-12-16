
CREATE TRIGGER ChangeInNeedPersonTotalRecivedMoney
ON Donation
AFTER INSERT
AS BEGIN	
UPDATE PersonInNeed 
SET PersonInNeed.TotalMoneyReceived =TotalMoneyReceived + 
(select SUM(Amount) FROM inserted GROUP BY ClientID HAVING PersonInNeed.PersonInNeedID = inserted.ClientID)
Where PersonInNeed.PersonInNeedID IN (SELECT ClientID FROM inserted GROUP BY ClientID)
END;
