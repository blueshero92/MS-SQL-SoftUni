SELECT * FROM WizzardDeposits

--Problem 01 Records’ Count

  SELECT COUNT([Id]) 
      AS [Count]
    FROM [WizzardDeposits];

--Problem 02 Longest Magic Wand

SELECT MAX([MagicWandSize])
    AS [LongestMagicWand]
  FROM [WizzardDeposits];

--Problem 03 Longest Magic Wand per Deposit Groups

   SELECT [DepositGroup],
          MAX([MagicWandSize])
       AS [LongestMagicWand]
     FROM [WizzardDeposits]
 GROUP BY [DepositGroup];

--Problem 04 Smallest Deposit Group Per Magic Wand Size

SELECT 
   TOP 2
       [DepositGroup]
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize);

--Problem 05 Deposits Sum

  SELECT [DepositGroup],
     SUM([DepositAmount])
      AS [TotalSum]
    FROM WizzardDeposits
GROUP BY [DepositGroup];

--Problem 06 Deposits Sum for Ollivander Family

  --Solution 1
    SELECT [DepositGroup],
         SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup];

  --Solution 2
  SELECT [DepositGroup],
     SUM ([DepositAmount])
	  AS [TotalSum]
    FROM WizzardDeposits
GROUP BY [MagicWandCreator], [DepositGroup]
  HAVING MagicWandCreator = 'Ollivander family'


--Problem 07 Deposits Filter

  SELECT [DepositGroup],
         SUM([DepositAmount])
      AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
  HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC;

--Problem 08 Deposit Charge

  SELECT [DepositGroup],
         [MagicWandCreator],
     MIN([DepositCharge])
	  AS [MinDepositCharge]
    FROM WizzardDeposits
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator], [DepositGroup];

--Problem 09 Age Groups

 SELECT [AgeGroup],
        COUNT(*)
	 AS [WizardCount]
   FROM
       (
	   SELECT 
            CASE
	            WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
		        WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
		        WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
		        WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
		        WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
		        WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
	            WHEN [Age] > 60 THEN '[61+]'
	        END AS [AgeGroup]			
        FROM [WizzardDeposits]
		) 
	  AS [TempAgeGroup]
GROUP BY [AgeGroup];


GO

--Problem 10 First Letter

  SELECT SUBSTRING([FirstName], 1,1)
      AS [FirstLetter]
    FROM [WizzardDeposits]
   WHERE [DepositGroup] = 'Troll Chest'
GROUP BY [FirstName]
ORDER BY [FirstName];


--Problem 11 Average Interest

  SELECT [DepositGroup],
         [IsDepositExpired],
	 AVG([DepositInterest])
	  AS [AverageInterest]
    FROM [WizzardDeposits]
   WHERE [DepositStartDate] > '01/01/1985'
GROUP BY [DepositGroup],[IsDepositExpired]
ORDER BY [DepositGroup] DESC,
         [IsDepositExpired];


--Problem 12 Rich Wizard, Poor Wizard

SELECT SUM([Difference]) 
    AS [SumDifference]
  FROM
         (
           SELECT [hw].[FirstName] AS [Host Wizard],
                  [hw].[DepositAmount] AS [Host Wizard Deposit],
           	      [gw].[FirstName] AS [Guest Wizard],
                  [gw].[DepositAmount] AS [Guest Wizard Deposit],
           	      [hw].[DepositAmount] - [gw].[DepositAmount] AS [Difference]	   
             FROM [WizzardDeposits]
               AS [hw]
             JOIN [WizzardDeposits]
               AS [gw]
           	   ON [hw].[Id] = [gw].[Id] - 1
		  ) 
	 AS [DifferenceTempTable];




GO

USE SoftUni;

GO


--Problem 13 Departments Total Salaries


  SELECT [DepartmentID],
     SUM ([Salary])
	  AS [TotalSalary]
    FROM Employees
GROUP BY [DepartmentID]
ORDER BY [DepartmentID];


--Problem 14 Employees Minimum Salaries

  SELECT [DepartmentID],
     MIN ([Salary])
	  AS [MinimumSalary]
    FROM [Employees]
   WHERE HireDate > '01/01/2000' AND [DepartmentID] IN (2,5,7)
GROUP BY [DepartmentID];

--Problem 15 Employees Average Salaries

SELECT *
  INTO [EmployeesCopy]
  FROM [Employees]
 WHERE [Salary] > 30000;

DELETE 
  FROM [EmployeesCopy]
 WHERE [ManagerID] = 42;

UPDATE [EmployeesCopy]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1;

  SELECT [DepartmentID],
     AVG ([Salary])
	  AS [AverageSalary]
    FROM [EmployeesCopy]
GROUP BY [DepartmentID];

--Problem 16 Employees Maximum Salaries

  SELECT [DepartmentID],
     MAX ([Salary])
	  AS [MaxSalary]
    FROM [Employees]
GROUP BY [DepartmentID]
  HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000;

--Problem 17 Employees Count Salaries 

SELECT COUNT([Salary])
    AS [Count]
  FROM [Employees]

 WHERE [ManagerID] IS NULL;


