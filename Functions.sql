CREATE FUNCTION FindOutHelper()
RETURNS TABLE 
AS 
RETURN
SELECT *
 FROM 
 (SELECT 
    PersonInNeedId ,
	FirstName ,
	LastName ,
    NationalCode ,
	PhoneNumber ,
	[Address] ,
	PostCode ,
	[Status] ,
	CreateDate ,
	TotalMoneyReceived ,
	NTILE(4) OVER(ORDER BY TotalMoneyReceived ASC) as quartile
	FROM  PersonInNeed ) as Temp
 WHERE quartile = 1;

SELECT * FROM GetMostInNeedQuarter();



select * from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID
where PaymentDate > getdate()



SELECT a.username, a.date, a.value
FROM myTable a
LEFT OUTER JOIN myTable b
ON a.username = b.username 
AND a.date < b.date
WHERE b.username IS NULL
ORDER BY a.date desc;





select HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID ResultTable
inner join (
    select HelperID, max(PaymentDate) as MaxDate
    from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID
    group by HelperID
) TmpTable on ResultTable.HelperID = TmpTable.HelperID and ResultTable.PaymentDate = TmpTable.MaxDate
