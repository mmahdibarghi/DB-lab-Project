CREATE TABLE [Helper](
	[HelperID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Status] [nvarchar](10) NOT NULL CHECK  (upper([Status])='ACTIVE' OR upper([Status])='DEACTIVE'),
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[NationalCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([NationalCode])=1),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1),
	[Address] [nvarchar](200) NOT NULL,
	[PostCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([PostCode])=1),
	[TotalHelped] [money]);


CREATE TABLE [CharityBoxReceiver](
	[CharityBoxReceiverID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[NationalCode] [nvarchar](10) NOT NULL CHECK (ISNUMERIC([NationalCode])=1),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1));


	
CREATE TABLE [Admin](
	[AdminID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Username] [nvarchar](50) Not Null,
	[Password] [nvarchar](255) Not Null,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CreatingDate] [date] NOT NULL DEFAULT GETDATE(),
	[PhoneNumber] [nvarchar](13) NOT NULL CHECK (ISNUMERIC([PhoneNumber])=1));



-------------------------------


CREATE TABLE CharityBox (
    [CharityBoxID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [HelperID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Status] [nvarchar](10) NOT NULL CHECK  (upper(Status)='ACTIVE' OR upper(Status)='DEACTIVE' OR upper(Status)='ARCHIVE'),
	[StartDate] [date] NOT NULL DEFAULT GETDATE(),
	[Type] [nvarchar](50) NOT NULL CHECK  (upper(Type)='BIG-PLASTIC' OR upper(Type)='SMALL-PLASTIC' OR upper(Type)='BIG-STEEL' OR upper(Type)='SMALL-STEEL')
	FOREIGN KEY (HelperID) REFERENCES Helper (HelperID)
);
 

 
CREATE TABLE Assign (
    [AssignID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [CharityBoxReceiverID] [int] NOT NULL,
	[CharityBoxID] [int] NOT NULL,
	[AssignDate] [date] DEFAULT GETDATE(),
	FOREIGN KEY (CharityBoxReceiverID) REFERENCES CharityBoxReceiver (CharityBoxReceiverID),
	FOREIGN KEY (CharityBoxID) REFERENCES CharityBox (CharityBoxID)
);



CREATE TABLE Account (
    [AccountID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] [varchar](30) NOT NULL,
	[AccountNum] [varchar](12) NOT NULL CHECK (ISNUMERIC(AccountNum)=1),
    [CardNum] [varchar](16) CHECK (ISNUMERIC(CardNum)=1),
	[TotalBalance] [money] DEFAULT 0
);


CREATE TABLE PersonInNeed (
    [PersonInNeedID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
    [NationalCode] [varchar](10) NOT NULL CHECK (ISNUMERIC([NationalCode])=1),
	[PhoneNumber] [varchar](13) NOT NULL CHECK (ISNUMERIC(PhoneNumber)=1),
	[Address] [varchar](60) NOT NULL,
	[PostCode] [varchar](10),
	[Status] [varchar](10) CHECK  (upper(Status)='ACTIVE' OR upper(Status)='DEACTIVE'),
	[CreateDate] [date] DEFAULT getdate(),
	[TotalMoneyReceived] [money] DEFAULT 0
);



CREATE TABLE Donation (
    [DonationID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[AccountID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
    [Amount] [money] NOT NULL,
	[Date] [date] NOT NULL DEFAULT getdate(),
	FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	FOREIGN KEY (ClientID) REFERENCES PersonInNeed(PersonInNeedID)
);




CREATE TABLE PayToCharity (
    [PaymentID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[HelperID] [int] NOT NULL,
	[CharityBoxID] [int],
    [CharityBoxReceiverID] [int],
	[AccountID] [int] NOT NULL,
	[AdminID] [int] NOT NULL,
	[Amount] [money] Not NULL,
	[PaymentDate] [date] NOT NULL DEFAULT getdate(),
	[PaymentType] [varchar](10) NOT NULL,
	[Authority] [varchar](256),
	[RefCode] [varchar](256),
	[HasPaid] [bit] NOT NULL,
	[CardNumber] [varchar](16),
	[Bank] [varchar](30),
	[Description] [varchar](200)
	FOREIGN KEY (CharityBoxReceiverID) REFERENCES CharityBoxReceiver (CharityBoxReceiverID),
	FOREIGN KEY (CharityBoxID) REFERENCES CharityBox (CharityBoxID),
	FOREIGN KEY (HelperID) REFERENCES Helper (HelperID),
	FOREIGN KEY (AdminID) REFERENCES Admin (AdminID),
	FOREIGN KEY (AccountID) REFERENCES Account (AccountID)
);



