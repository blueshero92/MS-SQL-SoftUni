USE SoftUni;

GO

--Problem 01 Employees with Salary Above 35000 

CREATE PROCEDURE [usp_GetEmployeesSalaryAbove35000]
              AS
		  SELECT [FirstName],
		         [LastName]
			FROM [Employees]
		   WHERE [Salary] > 35000


GO

--Problem 02 Employees with Salary Above Number

CREATE OR ALTER PROC [usp_GetEmployeesSalaryAboveNumber] @Salary DECIMAL(18,4) = 48100
                  AS 
		      SELECT [FirstName],
		             [LastName]
		        FROM Employees
		       WHERE [Salary] >= @Salary;

GO

--Problem 03 Town Names Starting With 

CREATE OR ALTER PROC [usp_GetTownsStartingWith] @TownName VARCHAR(80) = 'b'
                  AS
			  SELECT [Name]
			      AS [Town]
			    FROM [Towns]
			   WHERE [Name] LIKE @TownName + '%';

EXEC usp_GetTownsStartingWith 'b'

GO


--Problem 04 Employees from Town

CREATE OR ALTER PROC [usp_GetEmployeesFromTown] @TownName VARCHAR(80)
                  AS
			  SELECT [e].[FirstName],
			         [e].[LastName]
				FROM [Employees]
				  AS [e]
				JOIN [Addresses]
				  AS [a]
				  ON [e].[AddressID] = [a].[AddressID]
				JOIN [Towns]
				  AS [t]
				  ON [t].[TownID] = [a].[TownID]
			   WHERE [t].[Name] = @TownName;

EXEC usp_GetEmployeesFromTown 'Sofia';

GO

--Problem 05 Salary Level Function

   CREATE 
       OR 
    ALTER 
 FUNCTION [ufn_GetSalaryLevel](@salary DECIMAL(18,4))
 RETURNS VARCHAR(10)
			  AS 
		   BEGIN
				DECLARE @level VARCHAR(10) = 'Average'
					   IF (@salary < 30000) SET @level = 'Low'
					   IF (@salary > 50000) SET @level = 'High'						    
				       RETURN @level
			 END;

GO

  SELECT [Salary],
         dbo.ufn_GetSalaryLevel(Salary)
	  AS [Salary Level]
    FROM [Employees]


--Problem 06 Employees by Salary Level

CREATE OR ALTER PROCEDURE [usp_EmployeesBySalaryLevel] @SalaryLevel VARCHAR(10) 
                       AS
				   SELECT [FirstName],
				          [LastName]
					 FROM [Employees]
				    WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel;

EXEC usp_EmployeesBySalaryLevel 'High';

GO

--Problem 07 Define Function

  CREATE 
      OR 
   ALTER 
FUNCTION [ufn_IsWordComprised](@setOfLetters VARCHAR(100), @word VARCHAR(70)) 
RETURNS
    BIT
	 AS
	   BEGIN
	         DECLARE @wordIndex TINYINT = 1;
			 WHILE (@wordIndex <= LEN(@word))
			 BEGIN
			   DECLARE @currentLetter CHAR(1);
			   SET @currentLetter = SUBSTRING(@word, @wordIndex, 1)
			   IF (CHARINDEX(@currentLetter, @setOfLetters) = 0)
			     BEGIN
				      RETURN 0;
				   END;
				SET @wordIndex += 1
	         END
		  RETURN 1;		 
	   END;

GO




--Problem 08 Delete Employees and Departments

CREATE
    OR
 ALTER
  PROC [dbo].[usp_DeleteEmployeesFromDepartment] @DepartmentId INT
    AS
 BEGIN	  
	    DELETE 
		  FROM [EmployeesProjects]
	     WHERE [EmployeeID] IN
		                       (
			                      SELECT [EmployeeID]
				                    FROM [Employees]				                   
				                   WHERE [DepartmentID] = @DepartmentId
			                   );

		UPDATE [Employees]
		   SET [ManagerID] = NULL
		 WHERE [ManagerID] IN 
		                      (
			                      SELECT [EmployeeID]
				                    FROM [Employees]				                   
				                   WHERE [DepartmentID] = @DepartmentId
			                   );

	  
        ALTER TABLE [Departments]
	    ALTER COLUMN [ManagerId] INT NULL


		UPDATE [Departments]
		   SET [ManagerID] = NULL
		 WHERE [ManagerID] IN 
		                      (
			                      SELECT [EmployeeID]
				                    FROM [Employees]				                   
				                   WHERE [DepartmentID] = @DepartmentId
			                   );


		DELETE
		  FROM [Employees]
		 WHERE [DepartmentID] = @DepartmentId
		                         
		
		DELETE 
		  FROM [Departments]
		 WHERE [DepartmentID] = @DepartmentId


		SELECT COUNT(*)
		    AS [Count]
		  FROM [Employees]
		 WHERE [DepartmentId] = @DepartmentId;
								 
   END;
   
	 

EXEC [dbo].[usp_DeleteEmployeesFromDepartment] 10;




GO

USE Bank;

--Problem 09 Find Full Name

   CREATE
       OR
    ALTER
PROCEDURE [usp_GetHoldersFullName]
       AS
   SELECT CONCAT_WS(' ', [FirstName], [LastName])
       AS [Full Name]
	 FROM [AccountHolders];


EXEC [usp_GetHoldersFullName];

GO

--Problem 10 People with Balance Higher Than

   CREATE
       OR
    ALTER
PROCEDURE [usp_GetHoldersWithBalanceHigherThan] @money DECIMAL (18,2)
       AS
   SELECT [ah].[FirstName],
          [ah].[LastName]
     FROM [AccountHolders]
	   AS [ah]
	 JOIN [Accounts]
	   AS [a]
	   ON [ah].[Id] = [a].[AccountHolderId]
 GROUP BY [FirstName], [LastName]
   HAVING SUM([Balance]) > @money
 ORDER BY [ah].[FirstName], [ah].[LastName];


GO

--Problem 11 Future Value Function

  CREATE
      OR
   ALTER
FUNCTION ufn_CalculateFutureValue (@initialSum DECIMAL(20,4), @interestRate FLOAT, @years INT)
 RETURNS 
 DECIMAL(20,4)
    AS
	  BEGIN
	       DECLARE @futureValue FLOAT;
		   SET @futureValue = @initialSum * POWER(1 + @interestRate, @years)
		   RETURN @futureValue;
	  END;


SELECT [dbo].[ufn_CalculateFutureValue] (1000, 0.1, 5);

GO

--Problem 12 Calculating Interest

CREATE
    OR
 ALTER
  PROC [dbo].[usp_CalculateFutureValueForAccount] (@AccountId INT, @InterestRate FLOAT)
    AS 
	  (
	       SELECT [a].[Id]
		          AS [Account Id],
				  [ah].[FirstName]
				  AS [First Name],
				  [ah].[LastName]
				  AS [Last Name],
				  [a].[Balance]
				  AS [Current Balance], 
				  [dbo].[ufn_CalculateFutureValue] ([a].[Balance], @InterestRate, 5)
				  AS [Balance in 5 years]
		     FROM [AccountHolders]
		       AS [ah]
		     JOIN [Accounts]
		       AS [a]
			   ON [a].[AccountHolderId] = [ah].[Id]
			WHERE [a].[Id] = @AccountId
		 GROUP BY [a].[Id],
		          [ah].[FirstName],
				  [ah].[LastName],
				  [a].[Balance]
	 );


GO


EXEC [dbo].[usp_CalculateFutureValueForAccount] 4, 0.1

