--Problem 01 Find Names of All Employees by First Name

SELECT FirstName,
       LastName
  FROM Employees
WHERE FirstName LIKE 'Sa%';

    --Alternative Solution:
SELECT FirstName,
       LastName
  FROM Employees
 WHERE CHARINDEX('Sa', FirstName) = 1;


--Problem 02 Find Names of All Employees by Last Name

SELECT FirstName,
       LastName
  FROM Employees
 WHERE LastName LIKE '%ei%';

--Problem 03 Find First Names of All Employees 

SELECT FirstName
  FROM Employees       
 WHERE DepartmentID IN (3, 10) 
       AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005
 
--Problem 04 Find All Employees Except Engineers

SELECT FirstName,
       LastName
  FROM Employees
WHERE JobTitle NOT LIKE '%engineer%';
   
   -- Alternative Solution:
SELECT FirstName,
       LastName
  FROM Employees
WHERE CHARINDEX('engineer', JobTitle) = 0;

--Problem 05 Find Towns with Name Length 

  SELECT [Name]
    FROM Towns
   WHERE LEN([Name]) IN (5,6)
ORDER BY [Name];

--Problem 06 Find Towns Starting With

  SELECT TownID,
       [Name]
    FROM Towns
   WHERE SUBSTRING ([Name], 1, 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name];

    --Alternative Solution:
  SELECT TownID,
       [Name]
    FROM Towns
   WHERE LEFT ([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name];


--Problem 07 Find Towns Not Starting With 

  SELECT TownID,
       [Name]
    FROM Towns
   WHERE LEFT ([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name];


--Problem 08 Create View Employees Hired After 2000 Year

CREATE VIEW V_EmployeesHiredAfter2000 
         AS
     SELECT FirstName, 
	        LastName
	   FROM Employees
	  WHERE DATEPART(YEAR, HireDate) > 2000;


--Problem 09 Length of Last Name


SELECT FirstName,
       LastName
  FROM Employees
 WHERE LEN(LastName) = 5;


--Problem 10 Rank Employees by Salary

  SELECT EmployeeID,
         FirstName,
	     LastName, 
	     Salary, 
	     DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID)
	   AS [Rank]
    FROM Employees
   WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC;


--Problem 11 Find All Employees with Rank 2

 SELECT *
   FROM
       (  SELECT EmployeeID,
                 FirstName,
	             LastName, 
	             Salary, 
	             DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID)
	          AS [Rank]
            FROM Employees
           WHERE Salary BETWEEN 10000 AND 50000       
	   )
	  AS e
   WHERE [Rank] = 2
ORDER BY Salary DESC;

--Problem 12 Countries Holding 'A' 3 or More Times

USE [Geography]

  SELECT CountryName, 
         IsoCode
    FROM Countries
   WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode;

--Problem 13 Mix of Peak and River Names

  SELECT [p].[PeakName], 
         [r].[RiverName],
	     LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1), [r].[RiverName]))
	  AS [Mix]
    FROM [Peaks]
      AS [p]
    JOIN [Rivers]
      AS [r]
	  ON RIGHT(p.PeakName, 1) = LEFT (r.RiverName, 1)
ORDER BY [Mix];
	   
--Problem 14 Games From 2011 and 2012 Year

USE Diablo;

SELECT TOP (50) [Name],                
				FORMAT([Start], 'yyyy-MM-dd')
		AS [Start]
	  FROM Games	    
     WHERE DATEPART(YEAR, Start) IN (2011, 2012)
 ORDER BY [Start], [Name]; 
   

--Problem 15 User Email Providers

SELECT Username,
       SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email))
	   AS [Email Provider]
	 FROM Users
ORDER BY [Email Provider], Username;
	 

--Problem 16 Get Users with IP Address Like Pattern

  SELECT Username, 
         IpAddress
    FROM Users
   WHERE IpAddress LIKE ('___.1%.%.___')
ORDER BY Username;

--Problem 17 Show All Games with Duration & Part of the Day

  SELECT [Name],
         CASE
	         WHEN DATEPART(HOUR, g.[Start]) BETWEEN 0 AND 11 THEN 'Morning'
		     WHEN DATEPART(HOUR, g.[Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		     ELSE 'Evening'
	      END 
	      AS [Part of the Day],
		  CASE
	         WHEN g.Duration <= 3 THEN 'Extra Short'
		     WHEN g.Duration BETWEEN 4 AND 6 THEN 'Short'
		     WHEN g.Duration > 6 THEN 'Long'
		     ELSE 'Extra Long'
	      END
		   AS [Duration]
    FROM Games
	  AS g
ORDER BY g.[Name],[Duration];

--Problem 18 Orders Table

CREATE DATABASE BuiltInFunctions;

USE BuiltInFunctions;

CREATE TABLE Orders (
Id INT PRIMARY KEY IDENTITY(1, 1),
ProductName VARCHAR(60) NOT NULL,
OrderDate DATETIME NOT NULL
);

INSERT INTO Orders (ProductName, OrderDate) 
VALUES
('Butter', '2016-09-19 00:00:00.000'),
('Milk', '2016-09-30 00:00:00.000'),
('Cheese', '2016-09-04 00:00:00.000'),
('Bread', '2015-12-20 00:00:00.000'),
('Tomatoes', '2015-01-01 00:00:00.000');

GO

SELECT ProductName,
       OrderDate,
	   DATEADD(DAY, 3, OrderDate)
	AS [Pay Due],
	   DATEADD(MONTH, 1, OrderDate)
	AS [Deliver Due]
  FROM Orders;

GO

--Problem 19 People Table

CREATE TABLE People (
Id INT PRIMARY KEY IDENTITY(1, 1),
[Name] VARCHAR(60) NOT NULL,
Birthdate DATETIME NOT NULL
);

INSERT INTO People 
([Name], BirthDate) VALUES
('Victor', '2000-12-07 00:00:00.000'),
('Steven', '1992-09-10 00:00:00.000'),
('Stephen', '1910-09-19 00:00:00.000'),
('John', '2010-01-06 00:00:00.000');

SELECT [Name],
       DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
	   DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
	   DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
	   DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]

 FROM People;
