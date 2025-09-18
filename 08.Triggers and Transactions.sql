USE [Bank];

GO

--Problem 01 Create Table Logs

CREATE TABLE [Logs] (
[LogId] INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
[AccountId] INT NOT NULL,
[OldSum] MONEY,
[NewSum] MONEY
);


GO


 CREATE
     OR
  ALTER
TRIGGER [dbo].[tg_SumChange]
     ON [Accounts]
	FOR UPDATE
	 AS
	    INSERT 
	      INTO [Logs] ([AccountId], [OldSum], [NewSum])
		SELECT [i].[Id],
			   [d].[Balance],
			   [i].[Balance]
		  FROM [inserted]
		    AS [i]
		  JOIN [deleted]
		    AS [d]
			ON [i].[Id] = [d].[Id]
		 WHERE [i].[Balance] != [d].[Balance];




GO

SELECT * FROM Logs

--Problem 02 Create Table Emails

CREATE TABLE [NotificationEmails] (
[Id] INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
[Recipient] INT NOT NULL,
[Subject] VARCHAR (300) NOT NULL,
[Body] VARCHAR (300) NOT NULL
);


GO

 CREATE
     OR
  ALTER
TRIGGER [dbo].[tg_CreateNewEmail]
     ON [Logs]
    FOR INSERT
	 AS
	   INSERT
	     INTO [NotificationEmails] ([Recipient], [Subject], [Body])
	   SELECT [i].[AccountId], 
	          CONCAT_WS(' ', 'Balance change for account:', [i].[AccountId]),
			  CONCAT_WS(' ', 'On', GETDATE(), 'your balance was changed from', [i].[OldSum], 'to', [i].[NewSum])
	     FROM [inserted]
		   AS [i]
		WHERE [i].[OldSum] != [i].[NewSum];
		

GO		


--Problem 03 Deposit Money

CREATE
    OR
 ALTER
  PROC [dbo].[usp_DepositMoney] @AccountId INT, @MoneyAmount MONEY
    AS	  
	    UPDATE [Accounts]
		   SET [Balance] += @MoneyAmount
		 WHERE [Id] = @AccountId


GO



--Problem 04 Withdraw Money Procedure

CREATE
    OR
 ALTER
  PROC [dbo].[usp_WithdrawMoney] @AccountId INT, @MoneyAmount MONEY
    AS	  
	    UPDATE [Accounts]
		   SET [Balance] -= @MoneyAmount
		 WHERE [Id] = @AccountId


GO


--Problem 05 Money Transfer

CREATE
    OR
 ALTER
  PROC [dbo].[usp_TransferMoney] @SenderId INT, @RecieverId INT, @Amount MONEY
    AS
	  EXEC [dbo].[usp_WithdrawMoney] @SenderId, @Amount
	  EXEC [dbo].[usp_DepositMoney] @RecieverId, @Amount


GO

USE [SoftUni];

GO



--Problem 08

CREATE 
    OR 
 ALTER
  PROC [dbo].[usp_AssignProject] @EmployeeId INT, @ProjectID INT
    AS
 BEGIN 	
      BEGIN TRY 
	           BEGIN TRANSACTION
	                             DECLARE @ProjectCount INT 
								  SELECT @ProjectCount = COUNT(*)
	                                FROM [EmployeesProjects]
	                               WHERE [EmployeeID] = @EmployeeId
	                  
	                             IF(@ProjectCount >= 3)
	                              BEGIN
	                                   RAISERROR ('The employee has too many projects!', 16, 1)
	                              	ROLLBACK TRANSACTION
	                              	RETURN;
		                          END
		              
		                         INSERT INTO [EmployeesProjects] ([EmployeeID], [ProjectID])
		                              VALUES (@EmployeeId, @ProjectID)
		              
		                         COMMIT TRANSACTION;
	    END TRY
      BEGIN CATCH
	        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;        
                           THROW;
        END CATCH
END;
	   
    

GO

--Problem 09 Delete Employees

CREATE TABLE [Deleted_Employees] (
[EmployeeId] INT PRIMARY KEY IDENTITY NOT NULL,
[FirstName] VARCHAR(200) NOT NULL, 
[LastName] VARCHAR(200) NOT NULL,
[MiddleName] VARCHAR(200),
[JobTitle] VARCHAR(200) NOT NULL,
[DepartmentId] INT NOT NULL,
[Salary] DECIMAL (18, 2) NOT NULL
);

GO


 CREATE
     OR 
  ALTER
TRIGGER [dbo].[tg_StoreDeletedEmployees]
     ON [Employees]
	FOR DELETE
	 AS 
	   INSERT 
	     INTO [Deleted_Employees] ([FirstName], [LastName], [MiddleName], 
		                           [JobTitle], [DepartmentId], [Salary])
	   SELECT [FirstName],
	          [LastName],
			  [MiddleName],
			  [JobTitle],
			  [DepartmentID],
			  [Salary]
	     FROM [deleted];
		
		
