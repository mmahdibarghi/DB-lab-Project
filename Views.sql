CREATE VIEW HelpingDetailsView AS
Select Helper.FirstName, Helper.LastName, PayToCharity.Amount, PayToCharity.PaymentDate , Account.Name, Account.AccountNum
From Helper INNER JOIN PayToCharity ON PayToCharity.HelperID = Helper.HelperID
INNER JOIN Account ON PayToCharity.AccountID = Account.AccountID;


