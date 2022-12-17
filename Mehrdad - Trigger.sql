CREATE TRIGGER UpdateTotalHelp
ON PayToCharity
After INSERT  
AS
  DECLARE @amountInserted money
    DECLARE @helperId int
    SElect @amountInserted = inserted.amount from inserted
    select @helperId = inserted.helperId from inserted
  Update Helper
    set TotalHelped = TotalHelped + @amountInserted
    where Helper.HelperId = @helperId