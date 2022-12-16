CREATE FUNCTION GetMostInNeedQuarter()
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





 
CREATE FUNCTION GetHelperWithOutRecentlyHelp()
RETURNS TABLE 
AS Return
WITH tmpTable(HelperID, LastName, FirstName, PaymentDate) as
(select Helper.HelperID, LastName, FirstName, PaymentDate
from PayToCharity INNER JOIN
Helper ON Helper.HelperID = PayToCharity.HelperID) 
SELECT tmpTable.HelperID, tmpTable.LastName, tmpTable.FirstName, tmpTable.PaymentDate
FROM tmpTable
LEFT OUTER JOIN tmpTable as tmpTable2
ON tmpTable.HelperID = tmpTable2.HelperID 
AND tmpTable.PaymentDate < tmpTable2.PaymentDate
WHERE tmpTable2.HelperID IS NULL And tmpTable.PaymentDate < DATEADD(m,-2,GETDATE())


