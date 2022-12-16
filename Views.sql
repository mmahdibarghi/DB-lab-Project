CREATE VIEW HelpingDetailsView AS
Select Helper.FirstName, Helper.LastName, PayToCharity.Amount, PayToCharity.PaymentDate , Account.Name, Account.AccountNum
From Helper INNER JOIN PayToCharity ON PayToCharity.HelperID = Helper.HelperID
INNER JOIN Account ON PayToCharity.AccountID = Account.AccountID;



CREATE VIEW ReciverView
AS 
SELECT 
	Helper.[FirstName] ,
	Helper.[LastName] ,
	Helper.[PhoneNumber] ,
	Helper.[Address] ,
	Helper.[PostCode]	
FROM 
Helper INNER JOIN CharityBox ON Helper.HelperID = CharityBox.HelperID 
 INNER JOIN Assign ON Assign.CharityBoxID = CharityBox.CharityBoxID 
 INNER JOIN CharityBoxReceiver ON Assign.CharityBoxReceiverID = CharityBoxReceiver.CharityBoxReceiverID 
GO