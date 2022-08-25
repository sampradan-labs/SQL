USE MoviesDb
GO
CREATE VIEW vw_Movies AS
select * from Movies
GO

CREATE PROCEDURE sp_GetNamesThatStartWithI AS
select * from Movies Where Name LIKE 'I%' ORDER BY Id,Name DESC
GO

CREATE FUNCTION fn_Get ()
RETURNS int
AS
BEGIN 
  RETURN (SELECT Count(*) from Movies)
END
GO

-- In how many theatres a movie is running
-- Given movieId = 1

CREATE FUNCTION fn_GetTheatreCountForMovie(@movieId INT)
RETURNS int
AS
BEGIN
RETURN (select count(*) from MovieTheatre where MovieId=@movieId)
END

------------------------- EXECUTING ABOVE OBJECTS ---------------------------
--Executing View
Select * from vw_Movies

--Executing Stored Procedure
exec [dbo].[sp_GetNamesThatStartWithI] 

-- Executing scalar function
select [dbo].[fn_Get]() col1
select [dbo].[fn_GetTheatreCountForMovie](1)
--- Call both functions in one select statement
select [dbo].[fn_Get]() Output1, [dbo].[fn_GetTheatreCountForMovie](1) Output2

----- Experimenting with Logic ----------
-- Create a variable
DECLARE @Variable1 INT
SET @Variable1 = 2
select [dbo].[fn_Get]() Output1, 
[dbo].[fn_GetTheatreCountForMovie](@Variable1) Output2
GO
------------------------------------------------------------
-- Assign the value of a function output to a variable

ALTER FUNCTION fn_GetOutputs(@movieId INT)
RETURNS @Result Table (Col1 INT, Col2 INT)
AS
BEGIN
DECLARE @Output1 INT
DECLARE @Output2 INT
DECLARE @Variable1 INT
SET @Variable1 = @movieId
SET @Output1 = (SELECT [dbo].[fn_Get]())
SET @Output2 = (SELECT [dbo].[fn_GetTheatreCountForMovie](@Variable1))
Insert into @Result SELECT @Output1 O1, @Output2 O2
RETURN
END

--- Execute functions that return a table
SELECT * FROM fn_GetOutputs(1)






