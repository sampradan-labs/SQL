-- INNER JOIN
-- Get all Employee TaskNames
SELECT DISTINCT ET.EmpId, T.[Name] 
FROM Tasks as T INNER JOIN EmpTasks as ET
                ON T.Id = ET.TaskId

-- LEFT OUTER JOIN
-- Print all the tasks and to which employee Id it is assigned
SELECT DISTINCT T.[Name], ET.EmpId 
FROM   Tasks as T LEFT OUTER JOIN EmpTasks as ET
                  ON T.Id = ET.TaskId

-- RIGHT OUTER JOIN
-- Print all the Employees to whom Tasks are assigned
SELECT DISTINCT T.[Name], ET.EmpId 
FROM   Tasks as T RIGHT OUTER JOIN EmpTasks as ET
                  ON T.Id = ET.TaskId

--CROSS JOIN
SELECT * FROM Employee CROSS JOIN EmpTasks CROSS JOIN Tasks

-- A MIX OF JOINS
SELECT E.FName, T.[Name] FROM
Employee as E INNER JOIN EmpTasks as ET
              ON E.EmpId = ET.EmpId
		 RIGHT OUTER JOIN Tasks as T
		      ON ET.TaskId = T.Id
