------------ Functions ---------------
SELECT * FROM GetMostInNeedQuarter();

SElECT * FROM GetHelperWithOutRecentlyHelp();




-------- Stored procedure ---------
EXEC HelpToInNeed @PersonInNeedNationalCode='5620012559', @AccountName='Aaron', @Amount=1000 ;
