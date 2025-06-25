USE SoftUni;

--Problem 01 Employee Address

    SELECT
	   TOP 5
	       [e].[EmployeeID],
		   [e].[JobTitle],
		   [e].[AddressID],
		   [a].[AddressText]
      FROM [Employees]
        AS [e]
INNER JOIN [Addresses]
        AS [a]
		ON [e].[AddressID] = [a].[AddressID]
  ORDER BY [e].[AddressID];


--Problem 02 Addresses with Towns

      SELECT 
	     TOP 50
		 [e].[FirstName],
		 [e].[LastName],
		 [t].[Name] 
		 AS [Town],
		 [a].[AddressText]
        FROM [Employees]
		  AS [e]
  INNER JOIN [Addresses]
          AS [a]
		  ON [e].[AddressID] = [a].[AddressID]
  INNER JOIN [Towns]
          AS [t]
		  ON [a].[TownID] = [t].[TownID]
    ORDER BY [e].[FirstName],
	         [e].[LastName];

--Problem 03 Sales Employees

      SELECT [e].[EmployeeID],
	         [e].[FirstName],
			 [e].[LastName],
			 [d].[Name]
          AS [DepartmentName]
	    FROM [Employees]
		  AS [e]
  INNER JOIN [Departments]
          AS [d]
		  ON [e].[DepartmentID] = [d].[DepartmentID]
	   WHERE [d].[Name] = 'Sales'
    ORDER BY [e].[EmployeeID];


--Problem 04 Employee Departments

    SELECT 
	   TOP 5
	       [e].[EmployeeID],
	       [e].[FirstName],
		   [e].[Salary],
		   [d].[Name]
        AS [DepartmentName]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
	 WHERE [e].[Salary] > 15000
  ORDER BY [e].[DepartmentID];


--Problem 05 Employees Without Projects 

   SELECT
      TOP 3
	      [e].[EmployeeID],
		  [e].[FirstName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
	   ON [e].[EmployeeID] = [ep].[EmployeeID]
LEFT JOIN [Projects]
       AS [p]
	   ON [ep].ProjectID = [p].ProjectID
	WHERE [p].[ProjectID] IS NULL
 ORDER BY [e].EmployeeID;

--Problem 06 Employees Hired After

    SELECT [e].[FirstName],
	       [e].[LastName],
		   [e].[HireDate],
		   [d].[Name]
		AS [DeptName]
      FROM [Employees]
	    AS [e]
INNER JOIN [Departments]
        AS [d]
	    ON [e].[DepartmentID] = [d].[DepartmentID]
	 WHERE [e].[HireDate] > '1/1/1999' AND [d].[Name] IN ('Sales', 'Finance')
  ORDER BY [e].[HireDate];


--Problem 07 Employees With Project 

   SELECT
      TOP 5
	      [e].[EmployeeID],
		  [e].[FirstName],
		  [p].[Name]
	   AS [ProjectName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
	   ON [e].[EmployeeID] = [ep].[EmployeeID]
LEFT JOIN [Projects]
       AS [p]
	   ON [ep].ProjectID = [p].ProjectID
	WHERE [p].[StartDate] > '08/13/2002' AND [p].EndDate IS NULL
 ORDER BY [e].[EmployeeID]; 

--Problem 08 Employee 24 

   SELECT [e].[EmployeeID],
		  [e].[FirstName],
	 CASE
		  WHEN DATEPART(YEAR, [p].[StartDate]) >= 2005 THEN NULL
	      ELSE [p].[Name]
	  END
	   AS [ProjectName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
	   ON [e].[EmployeeID] = [ep].[EmployeeID]
LEFT JOIN [Projects]
       AS [p]
	   ON [ep].ProjectID = [p].ProjectID
    WHERE [e].[EmployeeID] = 24


--Problem 09 Employee Manager

   SELECT [e].[EmployeeID],
          [e].[FirstName],
		  [e].[ManagerID],
		  [m].[FirstName]
	   AS [ManagerName]
     FROM [Employees]
       AS [e]
LEFT JOIN [Employees]
       AS [m]
	   ON [e].[ManagerID] = [m].[EmployeeID]
    WHERE [e].[ManagerID] IN (3, 7)
 ORDER BY [e].[EmployeeID];


--Problem 10 Employees Summary 

   SELECT
      TOP 50
	      [e].[EmployeeID],
		  CONCAT_WS(' ', [e].[FirstName], [e].[LastName])
	   AS [EmployeeName],
	      CONCAT_WS(' ', [m].[FirstName], [m].[LastName])
       AS [ManagerName],
	      [d].[Name]
	   AS [DepartmentName]
     FROM [Employees]
       AS [e]
LEFT JOIN [Employees]
       AS [m]
	   ON [e].[ManagerID] = [m].[EmployeeID]
LEFT JOIN [Departments]
       AS [d]
	   ON [e].[DepartmentID] = [d].[DepartmentID]
 ORDER BY [e].[EmployeeID];


--Problem 11 Min Average Salary

SELECT 
      TOP 1
          AVG([Salary])
       AS [MinAverageSalary]
    FROM Employees
GROUP BY [DepartmentID]
ORDER BY [MinAverageSalary];


GO

USE [Geography];

GO

--Problem 12 Highest Peaks in Bulgaria


    SELECT [c].[CountryCode],
	       [m].[MountainRange],
		   [p].[PeakName],
		   [p].[Elevation]
      FROM [Countries]
        AS [c]
INNER JOIN [MountainsCountries]
        AS [mc]
		ON [c].[CountryCode] = [mc].[CountryCode]
INNER JOIN [Mountains]
        AS [m]
		ON [m].[Id] = [mc].[MountainId]
INNER JOIN [Peaks]
        AS [p]
		ON [p].[MountainId] = [m].[Id]
     WHERE [c].[CountryName] = 'Bulgaria' AND [p].[Elevation] > 2835
  ORDER BY [p].[Elevation] DESC;


--Problem 13 Count Mountain Ranges 

   SELECT [c].[CountryCode],
          COUNT([m].[MountainRange])
       AS [MountainRanges]
     FROM [Countries]
	   AS [c]
LEFT JOIN [MountainsCountries]
       AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Mountains]
       AS [m]
	   ON [m].[Id] = [mc].[MountainId]
    WHERE [c].CountryCode IN ('US', 'RU', 'BG')
 GROUP BY [c].[CountryCode];


--Problem 14 Countries With or Without Rivers

   SELECT
      TOP 5
          [c].[CountryName],
          [r].[RiverName]
     FROM [Continents]
	   AS [con]
LEFT JOIN [Countries]
       AS [c]
	   ON [con].[ContinentCode] = [c].[ContinentCode]
LEFT JOIN [CountriesRivers]
       AS [cr]
	   ON [cr].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
	   ON [cr].[RiverId] = [r].[Id]
	WHERE [con].[ContinentCode] = 'AF'
 ORDER BY [c].[CountryName];


--Problem 16 Countries Without any Mountains

   SELECT COUNT([c].[CountryCode])
       AS [Count]
	 FROM [Countries]
       AS [c]
LEFT JOIN [MountainsCountries]
       AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Mountains]
       AS [m]
	   ON [m].[Id] = [mc].[MountainId]
	WHERE [m].[Id] IS NULL
 GROUP BY [m].[Id];


--Problem 17 Highest Peak and Longest River by Country

   SELECT 
      TOP 5
          [c].[CountryName],
	      MAX([p].[Elevation])
	   AS [HighestPeakElevation],
          MAX([r].[Length])
	   AS [LongestRiverLength]
     FROM [Countries]
	   AS [c]
LEFT JOIN [CountriesRivers]
       AS [cr]
	   ON [cr].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
	   ON [cr].[RiverId] = [r].[Id]
LEFT JOIN [MountainsCountries]
       AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Mountains]
       AS [m]
	   ON [m].[Id] = [mc].[MountainId]
LEFT JOIN [Peaks]
       AS [p]
	   ON [p].[MountainId] = [m].[Id]
 GROUP BY [c].[CountryName]
 ORDER BY [HighestPeakElevation] DESC,
          [LongestRiverLength] DESC;

