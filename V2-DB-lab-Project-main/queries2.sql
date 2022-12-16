CREATE TABLE [Helper](
	[HelperID] [int] IDENTITY (1,1) PRIMARY KEY,
	[Status] [nvarchar](10) NOT NULL CHECK  (upper([Status])='ACTIVE' OR upper([Status])='DEACTIVE'),
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[NationalCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([NationalCode])=1),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1),
	[Address] [nvarchar](200) NOT NULL,
	[PostCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([PostCode])=1),
	[TotalHelped] [money]);

INSERT INTO [Helper] ([Status],[FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber],[Address],[PostCode])
VALUES ('ACTIVE','Leila','Alavi',getdate(),'1478965230','09124478653','Iran, Tehran','8864953210');

INSERT INTO [Helper] ([Status],[FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber],[Address],[PostCode])
VALUES ('ACTIVE','Maohammad Mahdi','Barghi',getdate(),'7308965230','09124466313','Iran, Esfahan','7653953210');

INSERT INTO [Helper] ([Status],[FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber],[Address],[PostCode])
VALUES ('ACTIVE','Mehrdad','Eshraghi',getdate(),'1477565230','09124773153','Iran, Yazd','8712463210');

INSERT INTO [Helper] ([Status],[FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber],[Address],[PostCode])
VALUES ('ACTIVE','Sepehr','Khodadadi',getdate(),'1861165230','09137468653','Iran, Mashhad','8864994630');

INSERT INTO [Helper] ([Status],[FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber],[Address],[PostCode])
VALUES ('ACTIVE','AmirReza','Hosseini',getdate(),'1476735230','09129128653','Iran, Tehran','8864756310');

CREATE TABLE [CharityBoxReceiver](
	[CharityBoxReceiverID] [int] IDENTITY (1,1) PRIMARY KEY,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[NationalCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([NationalCode])=1),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1));

INSERT INTO [CharityBoxReceiver] ([FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber])
VALUES ('Zahra','Pooladi',getdate(),'1478965230','09124478653');

INSERT INTO [CharityBoxReceiver] ([FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber])
VALUES ('Ali','Shayan',getdate(),'7308965230','09124466313');

INSERT INTO [CharityBoxReceiver] ([FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber])
VALUES ('Mona','Samani',getdate(),'1477565230','09124773153');

INSERT INTO [CharityBoxReceiver] ([FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber])
VALUES ('Sara','Khomeini',getdate(),'1861165230','09137468653');

INSERT INTO [CharityBoxReceiver] ([FirstName],[LastName],[CreatingDate],[NationalCode],[PhoneNumber])
VALUES ('Dena','Sadati',getdate(),'1476735230','09129128653');

CREATE TABLE [Admin](
	[AdminID] [int] IDENTITY (1,1) PRIMARY KEY,
	[Username] [nvarchar](50) Not Null,
	[Password] [nvarchar](255) Not Null,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1));


INSERT INTO [Admin] ([Username],[Password],[FirstName],[LastName],[CreatingDate],[PhoneNumber])
VALUES ('DenaHosseini','%$^%UWEGFHRE','Dena','Hosseini',getdate(),'09129128653');

CREATE TABLE PersonInNeed (
    PersonInNeedId int PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
    NationalCode varchar(10) NOT NULL,
	PhoneNumber varchar(13) NOT NULL,
	Address varchar(60) NOT NULL,
	PostCode varchar(10),
	Status varchar(10),
	CreateDate date DEFAULT getdate(),
	TotalMoneyReceived money DEFAULT 0
);


CREATE TABLE CharityBox (
    CharityBoxID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    HelperID int NOT NULL,
	Code int NOT NULL,
	Status nvarchar(10) NOT NULL CHECK  (upper(Status)='ACTIVE' OR upper(Status)='DEACTIVE' OR upper(Status)='ARCHIVE'),
	StartDate date NOT NULL DEFAULT GETDATE(),
	Type nvarchar(50) NOT NULL CHECK  (upper(Type)='BIG-PLASTIC' OR upper(Type)='SMALL-PLASTIC' OR upper(Type)='BIG-STEEL' OR upper(Type)='SMALL-STEEL')
	FOREIGN KEY (HelperID) REFERENCES Helper (HelperID)
);
 

 
CREATE TABLE Assign (
    AssignID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    CharityBoxReceiverID int NOT NULL,
	CharityBoxID int NOT NULL,
	AssignDate date DEFAULT GETDATE(),
	FOREIGN KEY (CharityBoxReceiverID) REFERENCES CharityBoxReceiver (CharityBoxReceiverID),
	FOREIGN KEY (CharityBoxID) REFERENCES CharityBox (CharityBoxID)
);



CREATE TABLE Account (
    AccountID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name varchar(30) NOT NULL,
	AccountNum varchar(12) NOT NULL CHECK (ISNUMERIC(AccountNum)=1),
    CardNum varchar(16) CHECK (ISNUMERIC(CardNum)=1),
	TotalBalance money DEFAULT 0
);


CREATE TABLE Donation (
    DonationID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	AccountID int NOT NULL,
	ClientID int NOT NULL,
    Amount money NOT NULL,
	Date date NOT NULL DEFAULT getdate(),
	FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	FOREIGN KEY (ClientID) REFERENCES PersonInNeed(PersonInNeedID)
);




CREATE TABLE PayToCharity (
    PaymentID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	HelperID int NOT NULL,
	CharityBoxID int,
    CharityBoxReceiverID int,
	AccountID int NOT NULL,
	AdminID int NOT NULL,
	Amount money Not NULL,
	PaymentDate date NOT NULL,
	PaymentType varchar(10) NOT NULL,
	Authority varchar(256),
	RefCode varchar(256),
	HasPaid bit NOT NULL,
	CardNumber varchar(16),
	Bank varchar(30),
	Description varchar(200)
	FOREIGN KEY (CharityBoxReceiverID) REFERENCES CharityBoxReceiver (CharityBoxReceiverID),
	FOREIGN KEY (CharityBoxID) REFERENCES CharityBox (CharityBoxID),
	FOREIGN KEY (HelperID) REFERENCES Helper (HelperID),
	FOREIGN KEY (AdminID) REFERENCES Admin (AdminID),
	FOREIGN KEY (AccountID) REFERENCES Account (AccountID)
);



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

SELECT * FROM GetMostInNeedQuarter();

CREATE TRIGGER ChangeAccountBalance ON PayToCharity
FOR INSERT AS 
BEGIN
UPDATE Account
SET TotalBalance = 
(SELECT SUM(Amount)
FROM PayToCharity INNER JOIN Account ON PayToCharity.AccountId = Account.AccountId
WHERE PayToCharity.AccountId IN 
(
SELECT PayToCharity.AccountId
FROM
(
SELECT *
FROM INSERTED EXCEPT 
SELECT *
FROM PayToCharity) as Temp
)
)
END;

CREATE VIEW ReciverView
AS 
SELECT 
	Helper.[FirstName] ,
	Helper.[LastName] ,
	Helper.[PhoneNumber] ,
	Helper.[Address] ,
	Helper.[PostCode]	
FROM 
Helper INNER JOIN CharityBox ON Helper.HelperID = CharityBox.HelperID 
 INNER JOIN Assign ON Assign.CharityBoxID = CharityBox.CharityBoxID 
 INNER JOIN CharityBoxReceiver ON Assign.CharityBoxReceiverID = CharityBoxReceiver.CharityBoxReceiverID 
GO

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
