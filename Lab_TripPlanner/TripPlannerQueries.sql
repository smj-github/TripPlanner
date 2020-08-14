CREATE DATABASE TripPlanner;
GO

USE TripPlanner 
GO

CREATE TABLE TripUser(
TripUserID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(25) NOT NULL,
LastName NVARCHAR(25) NOT NULL,
DOB DATE NOT NULL,
UserAddress NVARCHAR(100) NOT NULL,
PhoneNumber NCHAR(15) NOT NULL);
GO

CREATE TABLE Passport(
PassportID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
PassportNo NVARCHAR(10) NOT NULL,
ExpirationDate DATE NOT NULL,
AddressOnPassport NVARCHAR(50) NOT NULL);
GO

ALTER TABLE Passport
ADD TripUserIDFk INT NOT NULL;
GO

ALTER TABLE Passport
ADD CONSTRAINT FK_PassportUser
FOREIGN KEY (TripUserIDFk) REFERENCES TripUser(TripUserID);
GO

ALTER TABLE TripUser
ADD PassportIDFk INT NOT NULL;
GO

ALTER TABLE TripUser
ADD CONSTRAINT FK_TripUserPassport
FOREIGN KEY (PassportIDFk) REFERENCES Passport(PassportID);
GO

CREATE TABLE Hotel(
HotelID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(50) NOT NULL,
HotelAddress NVARCHAR(100) NOT NULL,
PhoneNumber NCHAR(15) NOT NULL,
CostPerNight FLOAT NOT NULL);
GO

CREATE TABLE HotelUsers(
HotelUserID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
HotelIDFk INT NOT NULL,
TripUserIDFk INT NOT NULL,
CheckInDate DATETIME,
CheckOutDate DATETIME);
GO

ALTER TABLE HotelUsers
ADD CONSTRAINT FK_Hotel
FOREIGN KEY (HotelIDFk) REFERENCES Hotel(HotelID);
GO

ALTER TABLE HotelUsers
ADD CONSTRAINT FK_User
FOREIGN KEY (TripUserIDFk) REFERENCES TripUser(TripUserID);
GO

CREATE TABLE Trip(
TripID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
Budget FLOAT NOT NULL,
StartDestination NVARCHAR(50) NOT NULL,
EndDestination NVARCHAR(50) NOT NULL,
TravelMode NVARCHAR(30) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL);
GO

CREATE TABLE TripsHotels(
TripHotelID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
TripIDFk INT NOT NULL,
HotelIDFk INT NOT NULL);
GO

ALTER TABLE TripsHotels
ADD CONSTRAINT FK_Trips
FOREIGN KEY (TripIDFk) REFERENCES Trip(TripID);
GO

ALTER TABLE TripsHotels
ADD CONSTRAINT FK_Hotels
FOREIGN KEY (HotelIDFk) REFERENCES Hotel(HotelID);
GO

CREATE TABLE TripsUsers(
TripUserID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
TripIDFk INT NOT NULL,
TripUserIDFk INT NOT NULL);
GO

ALTER TABLE TripsUsers
ADD CONSTRAINT FK_TripsUsers_Trips
FOREIGN KEY (TripIDFk) REFERENCES Trip(TripID);
GO

ALTER TABLE TripsUsers
ADD CONSTRAINT FK_TripsUsers_TripUser
FOREIGN KEY (TripUserIDFk) REFERENCES TripUser(TripUserID);
GO