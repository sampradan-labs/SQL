USE TaskManagement
-- Simple select
select * from Employee

-- select without from
select 'Without using from clause' as [Message], 
	  '1001' as [Code Number], 
	  'HA ha ha' as Comments

-- select using variable
DECLARE @varName NVARCHAR(50)
SET @varName = 'A new value'

SELECT @varName as [Using Variables]

-- Use select to assign a value to a variable
DECLARE @var2 INT
SET @var2 = 1001

SELECT @var2 = 1002

-- Select top few records

SELECT TOP 2 EmpId,EmpName FROM Employee

-- Select with order by asc

SELECT * from Employee ORDER BY EmpName ASC

-- Select with order by desc

SELECT * from Employee ORDER BY EmpId DESC

-- Get the newest employee who joined

SELECT TOP 1 * FROM Employee ORDER BY EmpId DESC

-- Get distinct records from table
-- 1. Get distinct names of Employees

SELECT DISTINCT EmpName FROM Employee

-- 2. Get distinct EmployeeIds with Names
SELECT DISTINCT EmpId, EmpName from Employee

-- Select with Where Clause
SELECT * FROM Employee WHERE EmpName = 'Garima' AND EmpId=10011
SELECT * from Employee WHERE EmpName = 'Garima' OR EmpId = 10011
SELECT TOP 2 * FROM Employee WHERE EmpName <> 'Garima'
SELECT * FROM Employee WHERE EmpName IN ('Manoj', 'Garima', 'Meena')
SELECT * FROM Employee WHERE EmpName NOT IN ('Manoj','Garima','Meena')
SELECT * FROM Employee WHERE EmpId BETWEEN 1002 AND 2002

-- Micro Lab: Get all employees who joined in a particular month Eg: 1-10-2023 to 31-10-2023
-- Get all the names that start with M
-- * Use Wildcards: *: One or more, _: Only one character, %: one or more

SELECT * from Employee WHERE EmpName LIKE 'M%'
-- Get all empNames ending with a: %a
-- Get all EmpNames that have 1 space: % %
-- Get all EmpNames that have the 2nd character as 'a': _a%

------------------------------------------------------------------
-- Nested Select statements in place of columns
SELECT (SELECT EmpName from Employee where EmpId=1001) as [Employee Name],
        (SELECT 5+5) as [Percent Hike]

-- Select statements to assign a value for a variable		
DECLARE @EmpId INT
SET @EmpId = (SELECT Top 1 EmpId FROM Employee Where EmpName='Meena')
SELECT @EmpId as [EmpId Assigned To Variable]

-- Select statements to assign & print value of a variable
DECLARE @newValue INT
SELECT @newValue = (SELECT Top 1 EmpId From Employee Where EmpName = 'Meena')
SELECT @newValue
-- Print as log message: See messages tab of result window. Used CAST() to cast a value to a different datatype
PRINT 'The final value of the variable @newValue = '+ CAST(@newValue AS nVarchar)

-- MicroLab: Get EmpNames displayed as EmpName-EmpId. Eg: Meena-2001
SELECT EmpName + '-' + CAST(EmpId as NVARCHAR) as FormattedName FROM Employee

-- SELECT working as CREATE TABLE
-- Clone a table - ONLY Its schema
SELECT * INTO EmployeeClone
FROM Employee
WHERE 0=1

-- Create a quick Backup table
SELECT * INTO EmployeeBackup
FROM Employee
WHERE ManagerId IS NOT NULL


