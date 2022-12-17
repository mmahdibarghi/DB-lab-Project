CREATE PROCEDURE HelpToInNeed
	@PersonInNeedNationalCode varchar(10),
	@AccountName varchar(30),
    @Amount money
AS
BEGIN
DECLARE @PersonInNeedID int  
DECLARE @AccountID int
DECLARE @AccountAmount money
SET @PersonInNeedID = (select PersonInNeedID FROM PersonInNeed WHERE NationalCode = @PersonInNeedNationalCode)
SET @AccountID = (select AccountID FROM Account WHERE Account.Name = @AccountName)
SET @AccountAmount = (select TotalBalance FROM Account WHERE Account.Name = @AccountName)
IF (@AccountAmount>=@Amount)
Begin
INSERT INTO Donation (ClientID,	AccountID, Amount)
VALUES (@PersonInNeedID, @AccountID, @Amount);
End
END

