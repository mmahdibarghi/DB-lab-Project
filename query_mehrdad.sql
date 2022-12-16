CREATE FUNCTION HelperAVG (@HelperNationalCode varchar(10))
RETURNS TABLE
AS
RETURN
(
  select avg(amount)
  from Helper join PayToCharity on Helper.HelperID = PayToCharity.HelperID
  when DATEDIFF(day, GETDATE(), PayToCharity.Date) <= 365
  and Helper.NationalCode = HelperNationalCode
);


CREATE TRIGGER UpdateTotalHelp
ON PayToCharity
After INSERT	
AS
    SElect @amountInserted = inserted.amount from inserted
    select @helperId = inserted.helperId from inserted
	Update Helper
    set TotalHelped = TotalHelped + @amountInserted
    where Helper.HelperId = @helperId


CREATE VIEW PersonInNeed AS
SELECT 
	FirstName, LastName, NationalCode, PhoneNumber,
    Address, PostCode, Status,
    CreateDate, TotalMoneyReceived,
    Amount, Date
FROM PersonInNeed
join Donation on PersonInNeed.PersonInNeedId = Donation.ClientId


CREATE PROCEDURE SetCharityBox @CharityBoxId int, @HelperID int, @ReciverID int, @BoxType nvarchar(10)
AS
    INSERT INTO CharityBox(CharityBoxId, HelperID, Status, Type)
    VALUES (@CharityBoxId, @HelperID, "Active", @BoxType);
    INSERT INTO Assign(CharityBoxReceiverId, CharityBoxId)
    VALUES (@ReceiverId, @CharityBoxId;
    