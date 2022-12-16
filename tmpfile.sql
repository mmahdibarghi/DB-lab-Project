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


select Helper.HelperID, PaymentDate as MaxDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID
group by HelperID


select HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID as ResultTable
inner join (
    select HelperID, max(PaymentDate) as MaxDate
    from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID
    group by HelperID
) as TmpTable on ResultTable.HelperID = TmpTable.HelperID and ResultTable.PaymentDate = TmpTable.MaxDate
















WITH tmpTable(HelperID, LastName, FirstName, PaymentDate) as
(select Helper.HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID) 
SELECT tmpTable.HelperID, tmpTable.LastName, tmpTable.FirstName, tmpTable.PaymentDate
FROM tmpTable
LEFT OUTER JOIN tmpTable as tmpTable2
ON tmpTable.HelperID = tmpTable2.HelperID 
AND tmpTable.PaymentDate < tmpTable2.PaymentDate
WHERE tmpTable2.HelperID IS NULL And tmpTable.PaymentDate < DATEADD(m,-2,GETDATE())
ORDER BY tmpTable.PaymentDate desc;










CREATE FUNCTION GetHelperWithOutRecentlyHelp()
RETURNS TABLE 
AS Return
WITH tmpTable(HelperID, LastName, FirstName, PaymentDate) as
(select Helper.HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID) 
SELECT tmpTable.HelperID, tmpTable.LastName, tmpTable.FirstName, tmpTable.PaymentDate
FROM tmpTable
LEFT OUTER JOIN tmpTable as tmpTable2
ON tmpTable.HelperID = tmpTable2.HelperID 
AND tmpTable.PaymentDate < tmpTable2.PaymentDate
WHERE tmpTable2.HelperID IS NULL And tmpTable.PaymentDate < DATEADD(m,-2,GETDATE())





(select Helper.HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN Helper ON Helper.HelperID = PayToCharity.HelperID) as tmpTable

select * from tmpTable

