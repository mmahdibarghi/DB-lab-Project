

CREATE FUNCTION HelperAVG (@HelperNationalCode varchar(10))
RETURNS TABLE
AS
RETURN
(
  select avg(PayToCharity.Amount) as AvaregePayment
  from Helper inner join PayToCharity on Helper.HelperID = PayToCharity.HelperID
  WHERE DATEDIFF(day, GETDATE(), PayToCharity.PaymentDate) <= 365
  and Helper.NationalCode = '2048854941' 
);
