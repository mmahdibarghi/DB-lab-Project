use BaranRahmat
go

CREATE VIEW HelpingDetailsView AS
Select Helper.FirstName, Helper.LastName, PayToCharity.Amount, PayToCharity.PaymentDate , Account.Name, Account.AccountNum
From Helper INNER JOIN PayToCharity ON PayToCharity.HelperID = Helper.HelperID


Select Helper.FirstName, Helper.LastName, PayToCharity.Amount, PayToCharity.PaymentDate , Account.Name, Account.AccountNum
From Helper INNER JOIN PayToCharity ON PayToCharity.HelperID = Helper.HelperID