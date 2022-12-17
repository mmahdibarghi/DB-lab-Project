CREATE PROCEDURE SetCharityBox @CharityBoxId int, @HelperID int, @ReceiverID int, @BoxType nvarchar(10)
AS
    INSERT INTO CharityBox(CharityBoxId, HelperID, Status, Type)
    VALUES (@CharityBoxId, @HelperID, 'Active', @BoxType);
    INSERT INTO Assign(CharityBoxReceiverId, CharityBoxId)
    VALUES (@ReceiverId, @CharityBoxId);