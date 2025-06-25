--Problem 1 Create Database
CREATE DATABASE Minions;

GO

--Problem 2 Create Tables
USE Minions;

CREATE TABLE [Minions](
Id INT PRIMARY KEY NOT NULL,
[Name] VARCHAR(50) NOT NULL, 
Age INT
);

CREATE TABLE Towns(
Id INT PRIMARY KEY NOT NULL,
[Name] VARCHAR(80) NOT NULL
);

--Problem 3 Alter Minions Table
ALTER TABLE Minions
ADD TownId INT NOT NULL;

ALTER TABLE Minions
ADD CONSTRAINT [FK_Minions_Towns_Id]
FOREIGN KEY (TownId) REFERENCES Towns(Id);

--Problem 4  Insert Records in Both Tables
INSERT INTO Towns (Id, [Name])
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

--Problem 5 Truncate Table Minions
TRUNCATE TABLE Minions;

--Problem 6 Drop All Tables
DROP TABLE IF EXISTS Minions, Towns;


--Problem 7 Create Table People
USE Minions;

CREATE TABLE People (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
[Name] NVARCHAR(200) NOT NULL, 
Picture VARBINARY(MAX), 
Height DECIMAL(18, 2), 
[Weight] DECIMAL(18, 2),
Gender BIT NOT NULL, 
Birthdate DATE NOT NULL, 
Biography NVARCHAR(MAX)
);

INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
VALUES
('Deyan', NULL, 1.78, 76.5, 0, '1.15.1992', NULL), 
('Mitko', NULL, 1.68, 73.5, 0, '8.25.1990', NULL), 
('Rusana', NULL, 1.73, 58.2, 1, '4.21.2001', NULL),
('Gercheto', NULL, 1.53, 43.3, 1, '3.21.2001', NULL),
('Hris', NULL, 1.79, 75, 0, '1.10.1991', NULL);

--Problem 8  Create Table Users
CREATE TABLE Users (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
Username VARCHAR(30) UNIQUE NOT NULL, 
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX), 
LastLoginTime DATETIME2, 
IsDeleted BIT
);

INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
VALUES
('Deyan', 'someCoolPassword', NULL, GETDATE(), 0), 
('Mitko', 'pass123', NULL, GETDATE(), 1), 
('Rusana', 'lovegogo', NULL, GETDATE(), 0),
('Gercheto','asmrtist', NULL, GETDATE(), 1),
('Hris', '12j134', NULL, GETDATE(), NULL);

--Problem 9 Change Primary Key
ALTER TABLE Users
DROP [PK__Users__3214EC072A90D296]

ALTER TABLE Users
ADD PRIMARY KEY(Id, Username);

--Problem 10 Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT [CK_Check_Password_Length_5]
CHECK(LEN([Password]) >= 5);

--Problem 11 Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT[Set_Default_For_LastLoginTime]
DEFAULT GETDATE() FOR LastLoginTime

--Problem 12 Set Unique Field
ALTER TABLE Users
DROP[UQ__Users__536C85E4CB7F9C68]

ALTER TABLE Users
ADD CONSTRAINT[Check_Username_Min_3]
CHECK(LEN([Username]) >= 3);

--Problem 13 Movies Database
CREATE DATABASE Movies;

GO

USE Movies;

CREATE TABLE Directors (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
);

CREATE TABLE Genres (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 
GenreName NVARCHAR(50) NOT NULL, 
Notes NVARCHAR(MAX)
);

CREATE TABLE Categories (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 
CategoryName NVARCHAR(50) NOT NULL, 
Notes NVARCHAR(MAX)
);

CREATE TABLE [Movies] (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Title NVARCHAR(50) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL, 
CopyrightYear INT NOT NULL, 
[Length] DECIMAL(18, 2) NOT NULL, 
GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL, 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
Rating DECIMAL (18, 1), 
Notes NVARCHAR(MAX)
);

INSERT INTO Directors (DirectorName, Notes)
VALUES
('Mel Gibson', NULL), 
('James Gunn', NULL),
('Christopher Nolan', NULL),
('Frank Darabond', NULL), 
('Martin Scorcese', NULL);

INSERT INTO Genres(GenreName, Notes)
VALUES
('Drama', NULL), 
('Thriller', NULL),
('Action', NULL),
('Horror', NULL), 
('Comedy', NULL);

INSERT INTO Categories(CategoryName, Notes)
VALUES
('Best Movie', NULL), 
('Best Score', NULL),
('Best Drama', NULL),
('Best Visual Effects', NULL), 
('Best Actor', NULL);

INSERT INTO Movies (Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes)
VALUES
('Hacksaw Ridge', 1, 2016, 2.19, 1, 3, 8.1, NULL),
('The Dark Knight', 3, 2008, 2.32, 3, 1, 9, NULL),
('The Mist', 4, 2007, 2.06, 4, 4, 7.1, NULL),
('Superman', 2, 2025, 1.58, 3, 4, NULL, NULL),
('The Irishman', 5, 2019, 3.29, 2, 1, 7.8, NULL);

--Problem 14 Car Rental Database
CREATE DATABASE CarRental;

GO

USE CarRental;

CREATE TABLE Categories (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
CategoryName NVARCHAR(50) NOT NULL, 
DailyRate DECIMAL(18, 2) NOT NULL, 
WeeklyRate DECIMAL(18, 2) NOT NULL, 
MonthlyRate DECIMAL(18, 2) NOT NULL, 
WeekendRate DECIMAL(18, 2) NOT NULL
);

CREATE TABLE Cars (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
PlateNumber INT NOT NULL, 
Manufacturer VARCHAR(50) NOT NULL, 
Model VARCHAR(50) NOT NULL, 
CarYear INT NOT NULL, 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
Doors TINYINT NOT NULL, 
Picture VARBINARY(MAX), 
Condition VARCHAR(10),
Available BIT NOT NULL
);

CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
FirstName VARCHAR(50) NOT NULL, 
LastName VARCHAR(50) NOT NULL, 
Title VARCHAR(50) NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE Customers (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
DriverLicenceNumber CHAR(9) NOT NULL , 
FullName VARCHAR(50) NOT NULL, 
[Address] VARCHAR(80) NOT NULL, 
City VARCHAR(80) NOT NULL, 
ZipCode CHAR(4) NOT NULL, 
Notes VARCHAR(MAX)
);


CREATE TABLE RentalOrders (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
TankLevel DECIMAL (18, 2), 
KilometrageStart DECIMAL(18, 2) NOT NULL, 
KilometrageEnd DECIMAL (18, 2) NOT NULL, 
TotalKilometrage DECIMAL(18, 2) NOT NULL, 
StartDate DATE NOT NULL, 
EndDate DATE NOT NULL, 
TotalDays SMALLINT NOT NULL, 
RateApplied DECIMAL(18, 2) NOT NULL, 
TaxRate DECIMAL(18, 2) NOT NULL,
OrderStatus VARCHAR(80) NOT NULL, 
Notes VARCHAR(MAX)
);

INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('Economy', 30.00, 180.00, 600.00, 50.00),
('SUV', 60.00, 350.00, 1200.00, 100.00),
('Luxury', 120.00, 700.00, 2500.00, 200.00);

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES 
(123456, 'Toyota', 'Corolla', 2020, 1, 4, NULL, 'New', 1),
(789012, 'Ford', 'Escape', 2022, 2, 4, NULL, 'New', 1),
(345678, 'Mercedes', 'E-Class', 2021, 3, 4, NULL, 'Used', 0);


INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES 
('John', 'Doe', 'Manager', NULL),
('Jane', 'Smith', 'Sales Representative', NULL),
('Michael', 'Johnson', 'Mechanic', NULL);


INSERT INTO Customers (DriverLicenceNumber, FullName, [Address], City, ZipCode, Notes)
VALUES 
('D12345678', 'Alice Brown', '123 Maple St.', 'New York', '1000', NULL),
('D23456789', 'Bob White', '456 Oak Rd.', 'Los Angeles', '9000', NULL),
('D34567890', 'Charlie Green', '789 Pine Ave.', 'Chicago', '6060', NULL);

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES 
(1, 1, 1, 50.00, 0.00, 100.00, 100.00, '2025-01-10', '2025-01-15', 5, 30.00, 8.00, 'Declined', NULL),
(2, 2, 2, 70.00, 50.00, 200.00, 150.00, '2025-01-12', '2025-01-19', 7, 60.00, 15.00, 'Completed', NULL),
(3, 3, 3, 80.00, 100.00, 300.00, 200.00, '2025-01-15', '2025-01-20', 5, 120.00, 20.00, 'Cancelled', NULL);

--Problem 15 Hotel Database
CREATE DATABASE Hotel;

GO

USE Hotel;

CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
FirstName VARCHAR(50) NOT NULL, 
LastName VARCHAR(50) NOT NULL, 
Title VARCHAR (50) NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE Customers (
AccountNumber CHAR(10) PRIMARY KEY NOT NULL, 
FirstName VARCHAR(50) NOT NULL, 
LastName VARCHAR(50) NOT NULL,
PhoneNumber CHAR(10) NOT NULL, 
EmergencyName VARCHAR(50), 
EmergencyNumber CHAR(10), 
Notes VARCHAR(MAX)
);

CREATE TABLE RoomStatus (
RoomStatus VARCHAR(50) PRIMARY KEY NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE RoomTypes (
RoomType VARCHAR(50) PRIMARY KEY NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE BedTypes (
BedType VARCHAR(50) PRIMARY KEY NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE Rooms (
RoomNumber INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
RoomType VARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL, 
BedType VARCHAR(50) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
Rate DECIMAL(18, 2) NOT NULL,
RoomStatus VARCHAR(50) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL, 
Notes VARCHAR(MAX)
);

CREATE TABLE Payments (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
PaymentDate DATE NOT NULL, 
AccountNumber CHAR(10) FOREIGN KEY REFERENCES Customers(AccountNumber),
FirstDateOccupied DATE NOT NULL, 
LastDateOccupied DATE NOT NULL, 
TotalDays INT NOT NULL, 
AmountCharged DECIMAL(18, 2) NOT NULL, 
TaxRate DECIMAL(18, 2) NOT NULL,
TaxAmount DECIMAL(18, 2) NOT NULL, 
PaymentTotal DECIMAL(18, 2) NOT NULL,
Notes VARCHAR(MAX)
);

CREATE TABLE Occupancies (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
DateOccupied DATE NOT NULL, 
AccountNumber CHAR(10) FOREIGN KEY REFERENCES Customers(AccountNumber),
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber), 
RateApplied DECIMAL (18, 2) NOT NULL, 
PhoneCharge TINYINT, 
Notes VARCHAR(MAX)
);

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES 
('John', 'Doe', 'Manager', 'Oversees daily hotel operations.'),
('Jane', 'Smith', 'Receptionist', 'Handles customer check-ins and inquiries.'),
('Michael', 'Johnson', 'Housekeeping Supervisor', 'Supervises the housekeeping staff.');

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
VALUES 
('CUST0001', 'Alice', 'Brown', '1234567890', 'John Brown', '0987654321', 'Frequent customer, VIP status.'),
('CUST0002', 'Bob', 'White', '2345678901', 'Emily White', '1122334455', 'First-time guest.'),
('CUST0003', 'Charlie', 'Green', '3456789012', 'Diana Green', '2233445566', 'Special requests for a quiet room.');

INSERT INTO RoomStatus (RoomStatus, Notes)
VALUES 
('Available', 'Room is ready for new check-ins.'),
('Occupied', 'Room is currently occupied by a guest.'),
('Under Maintenance', 'Room is being cleaned or repaired.');

INSERT INTO RoomTypes (RoomType, Notes)
VALUES 
('Single', 'Standard room with one bed.'),
('Double', 'Room with two beds, suitable for two guests.'),
('Suite', 'Luxury room with separate living and sleeping areas.');

INSERT INTO BedTypes (BedType, Notes)
VALUES 
('King', 'Large bed suitable for two guests.'),
('Queen', 'Moderate-sized bed for two guests.'),
('Single', 'Smaller bed suitable for one guest.');

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus, Notes)
VALUES 
('Single', 'King', 100.00, 'Available', 'Room with a king-size bed.'),
('Double', 'Queen', 150.00, 'Occupied', 'Room with two queen-size beds.'),
('Suite', 'King', 300.00, 'Under Maintenance', 'Luxury suite with a king-size bed and living area.');

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
VALUES 
(1, '2025-01-10', 'CUST0001', '2025-01-05', '2025-01-10', 5, 500.00, 10.00, 50.00, 550.00, 'Paid in full for 5-day stay.'),
(2, '2025-01-12', 'CUST0002', '2025-01-07', '2025-01-12', 5, 750.00, 10.00, 75.00, 825.00, 'Paid for a 5-night stay in a double room.'),
(3, '2025-01-15', 'CUST0003', '2025-01-10', '2025-01-15', 5, 1500.00, 12.00, 180.00, 1680.00, 'Paid for luxury suite for 5 nights.');

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES 
(1, '2025-01-05', 'CUST0001', 1, 100.00, 10, 'Stayed for 5 days, no additional services.'),
(2, '2025-01-07', 'CUST0002', 2, 150.00, 15, 'Stayed in a double room for 5 days.'),
(3, '2025-01-10', 'CUST0003', 3, 300.00, 20, 'Stayed in suite with additional phone charges.');


--Problem 16 Create SoftUni Database
CREATE DATABASE SoftUni;

GO

USE SoftUni;

CREATE TABLE Towns (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
[Name] NVARCHAR(80) NOT NULL
);

CREATE TABLE Addresses (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
AddressText NVARCHAR(80) NOT NULL, 
TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
);

CREATE TABLE Departments (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
[Name] NVARCHAR(80) NOT NULL
);

CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL, 
FirstName NVARCHAR(80) NOT NULL, 
MiddleName NVARCHAR(80) NOT NULL,
LastName NVARCHAR(80) NOT NULL,
JobTitle NVARCHAR(80) NOT NULL,
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL, 
HireDate DATE NOT NULL, 
Salary DECIMAL (18, 2) NOT NULL, 
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
);

--Problem 18 Basic Insert
INSERT INTO Towns ([Name])
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO Departments ([Name])
VALUES
('Engineering'), 
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02.01.2013', 3500.00),
('Peter', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03.02.2004', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08.28.2016', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '12.09.2007', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '08.28.2016', 599.88);

--Problem 19 Basic Select All Fields
SELECT * FROM Towns;
SELECT * FROM Departments;
SELECT * FROM Employees;

--Problem 20 Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY ([Name]);

SELECT * FROM Departments
ORDER BY ([Name]);

SELECT * FROM Employees
ORDER BY ([Salary]) DESC;


--Problem 21 Basic Select Some Fields
SELECT ([Name]) FROM Towns
ORDER BY ([Name]);

SELECT ([Name]) FROM Departments
ORDER BY ([Name]);

SELECT ([FirstName]), ([LastName]), ([JobTitle]), ([Salary]) FROM Employees
ORDER BY ([Salary]) DESC;

--Problem 22 Increase Employees Salary
UPDATE Employees
SET Salary += Salary * 0.10;

SELECT Salary FROM Employees;

--Problem 23 Decrease Tax Rate
USE Hotel;

UPDATE Payments
SET TaxRate -= TaxRate * 0.03;

SELECT TaxRate FROM Payments;

--Problem 24 Delete All Records
TRUNCATE TABLE Occupancies;