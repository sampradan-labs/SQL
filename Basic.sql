/****** Script for SelectTopNRows command from SSMS  ******/

--Basic filter
SELECT TOP 2 * FROM dbo.Tasks
SELECT TOP (2) [Name] from dbo.tasks

--Basic filter with concatenation and using CAST()
SELECT TOP 2 [NAME]+'-'+ CAST([STATUS] AS nvarchar) FROM dbo.Tasks

--Basic filter with concatenatin and column ALIAS
SELECT TOP 2 [NAME]+'-'+ CAST([STATUS] AS nvarchar) AS 'Taskname With Status' FROM dbo.Tasks
--USING SWITCH CASE
/*
switch(someValue)
  {
    case 0: return "Not Completed"
	case null: return "Not Started"
	default: return "Completed"
	}
*/
SELECT CASE WHEN [STATUS]=0 THEN 'Not Completed'
            WHEN [STATUS]=NULL THEN 'Not Started'
            ELSE 'Completed'
	   END AS 'Task Status'
FROM dbo.Tasks

-- If status = 0, then output should show in-progress, else show output as completed
SELECT ([NAME]+' - '  + (CASE WHEN [STATUS]=0 THEN 'Not Completed'
						     ELSE 'Completed' 
					    END)) AS [Taskname with Status] 
FROM dbo.tasks

-- Using If--Then--Else. This cannot be used inside the SELECT CLAUSE
IF 1=0
      SELECT 'Not Completed'
ELSE 
	  SELECT 'Completed' AS 'Task Status'

-- SELECT * from dbo.Tasks (condition status is 1)
SELECT * FROM dbo.Tasks
WHERE [Status] = 1

-- DECLARE VARIABLES
--DECLARE @<varName> <datatype> = <value>
DECLARE @value BIT = 0
IF @value = 1
   SELECT * FROM dbo.Tasks WHERE [Status] = 1
ELSE
   SELECT * FROM dbo.Tasks WHERE [Status] = 0

-- Using the variable inside select clause
DECLARE @value BIT = 0
SELECT * FROM dbo.Tasks WHERE [Status] = @value

DECLARE @value BIT = 0
SELECT @value As [Status]

-- OFFSET-FETCH FILTER: Skip (OFFSET=n) a few rows, then fetch (FETCH=n) a few rows
SELECT * FROM dbo.tasks
ORDER BY ID
OFFSET 1 ROWS
FETCH NEXT 2 ROWS ONLY

--DONT SKIP ANY ROW, BUT USE OFFSET
SELECT * FROM dbo.tasks
ORDER BY ID
OFFSET 0 ROWS
FETCH NEXT 2 ROWS ONLY

-- Get all tasks between 28 Sept & 15th Oct 2021
   SELECT * FROM dbo.Tasks WHERE [StartDate] BETWEEN '2021-09-28' AND '2021-10-15'
-- Get all the tasks that start with the word 'Learning' in them
-- _,?,%
   SELECT * FROM dbo.Tasks WHERE [Name] LIKE 'Learning%'
-- Taskname with 3rd character as 'd'
   SELECT * FROM dbo.Tasks WHERE [Name] LIKE '__d%'

-- Get all distinct Tasks named Coding, Learning C#
   SELECT distinct [Name] FROM dbo.tasks WHERE [Name] IN ('Coding', 'Learning C#')
-- Total tasks named Coding
   SELECT COUNT([Name]) FROM dbo.Tasks WHERE [Name] LIKE 'Coding' AND [StartDate] > '2021-09-01'
   SELECT COUNT([Name]) FROM dbo.Tasks WHERE [Name] LIKE 'Coding' OR [StartDate] > '2021-09-01'

-- Group by Date
   SELECT [Name], COUNT(*) AS TotalTasks FROM dbo.Tasks WHERE StartDate >'2021-09-01' Group By [Name],[StartDate]

-- Group by Date with a condition
   SELECT [Name], COUNT(*) AS TotalTasks FROM dbo.Tasks WHERE StartDate >'2021-09-01' 
   Group By [Name]
   Having Count(*) = 1
-- Get the top 5 ranking people
-- Get the tasks ending with 'g'




























