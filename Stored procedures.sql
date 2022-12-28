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






CREATE PROCEDURE TotalPayToCharity
	@HelperID int ,
	@CharityBoxID int,
    @CharityBoxReceiverID int,
	@AccountID int ,
	@AdminID int ,
	@Amount money ,
	@PaymentDate date ,
	@PaymentType varchar(10),
	@Authority varchar(256),
	@RefCode varchar(256),
	@HasPaid bit ,
	@CardNumber varchar(16),
	@Bank varchar(30),
	@Description varchar(200)
AS
BEGIN
INSERT INTO PayToCharity (HelperID,	CharityBoxID , CharityBoxReceiverID , AccountID , AdminID , Amount , PaymentDate , PaymentType ,Authority ,RefCode ,HasPaid , CardNumber ,Bank , [Description] )
VALUES (@HelperID ,	@CharityBoxID ,    @CharityBoxReceiverID ,	@AccountID , @AdminID , @Amount , GETDATE() , @PaymentType ,	@Authority ,
	@RefCode ,	@HasPaid ,	@CardNumber ,@Bank ,@Description );
END





CREATE PROCEDURE SetCharityBox @CharityBoxId int, @HelperID int, @ReciverID int, @BoxType nvarchar(10)
AS
    INSERT INTO CharityBox(CharityBoxId, HelperID, Status, Type)
    VALUES (@CharityBoxId, @HelperID, "Active", @BoxType);
    INSERT INTO Assign(CharityBoxReceiverId, CharityBoxId)
    VALUES (@ReceiverId, @CharityBoxId;
    