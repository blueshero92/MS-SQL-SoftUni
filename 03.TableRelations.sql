--Problem 01 One-To-One Relationship

CREATE TABLE Passports (
PassportID INT PRIMARY KEY NOT NULL,
PassportNumber VARCHAR(64)
);

CREATE TABLE Persons (
PersonID INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(80) NOT NULL,
Salary DECIMAL (18,2),
PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE NOT NULL
);

INSERT INTO Passports
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')
;

INSERT INTO Persons
VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 101),
(3, 'Yana', 60200.00, 103)
;

--Problem 02 One-To-Many Relationship

CREATE TABLE Manufacturers (
ManufacturerID INT PRIMARY KEY IDENTITY(1, 1),
[Name] VARCHAR(60) NOT NULL,
EstablishedOn DATE NOT NULL, 
);

CREATE TABLE Models (
ModelID INT PRIMARY KEY IDENTITY(101,1) NOT NULL,
[Name] VARCHAR(64) NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
);

INSERT INTO Manufacturers
VALUES
('BMW', '07.03.1916'),
('Tesla', '01.01.2003'),
('Lada', '01.05.1966');

INSERT INTO Models 
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);


--Problem 03 Many-To-Many Relationship

CREATE TABLE Students (
StudentID INT PRIMARY KEY IDENTITY (1,1),
[Name] VARCHAR (80) NOT NULL
);

CREATE TABLE Exams (
ExamID INT PRIMARY KEY IDENTITY (101,1),
[Name] VARCHAR (80) NOT NULL
);

CREATE TABLE StudentsExams (
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
CONSTRAINT INT PRIMARY KEY (StudentID, ExamID)
);

INSERT INTO Students
VALUES
('Mila'),
('Toni'),
('Ron');


INSERT INTO Exams
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g');

INSERT INTO StudentsExams
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

--Problem 04 Self-Referencing

CREATE TABLE Teachers (
TeacherID INT PRIMARY KEY IDENTITY(101, 1),
[Name] VARCHAR(64) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
);

INSERT INTO Teachers
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);

--Problem 05 Online Store Database

CREATE TABLE Cities (
CityID INT PRIMARY KEY IDENTITY(1,1),
[Name] VARCHAR(80) NOT NULL
);

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY IDENTITY(1,1),
[Name] VARCHAR(80) NOT NULL,
Birthday DATE NOT NULL,
CityID INT FOREIGN KEY REFERENCES Cities(CityID)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);

CREATE TABLE ItemTypes (
ItemTypeID INT PRIMARY KEY IDENTITY (1,1),
[Name] VARCHAR(64) NOT NULL
);

CREATE TABLE Items (
ItemID INT PRIMARY KEY IDENTITY (1,1),
[Name] VARCHAR(64) NOT NULL,
ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
);

CREATE TABLE OrderItems (
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID)
);

--Problem 06 University Database 

CREATE TABLE Majors (
MajorID INT PRIMARY KEY IDENTITY (1,1),
[Name] VARCHAR(64) NOT NULL
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY IDENTITY(1,1),
StudentNumber VARCHAR(80) UNIQUE NOT NULL,
StudentName VARCHAR(80) NOT NULL,
MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
);

CREATE TABLE Payments (
PaymentID INT PRIMARY KEY IDENTITY(1,1),
PaymentDate DATETIME NOT NULL,
PaymentAmount DECIMAL(18,2) NOT NULL,
StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
);

CREATE TABLE Subjects (
SubjectID INT PRIMARY KEY IDENTITY (1,1),
SubjectName VARCHAR(64) NOT NULL
);

CREATE TABLE Agenda (
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID)
);

--Problem 09 Peaks in Rila

  SELECT MountainRange, PeakName, Elevation 
    FROM Peaks AS p
    JOIN Mountains AS m ON m.Id = p.MountainId
   WHERE MountainRange = 'Rila'
ORDER BY Elevation DESC;