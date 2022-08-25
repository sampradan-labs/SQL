
DECLARE @MovieName nvarchar(max)
DECLARE @TheatreCount int

DECLARE c1 CURSOR FOR
select m.Name, Count(mt.TheatreId) as TheatreCount from Movies m LEFT OUTER JOIN MovieTheatre mt 
												 ON m.Id = mt.MovieId
												 GROUP BY m.Name
OPEN c1
FETCH NEXT FROM c1
INTO @MovieName, @TheatreCount

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @TheatreCount > 2
		Print @MovieName + ' is a superhit movie'
	ELSE IF @TheatreCount >=1
		Print @MovieName + ' has average ratings'
	ELSE
		Print @MovieName + ' is a flop movie'

FETCH NEXT FROM c1 INTO @MovieName, @TheatreCount
END

CLOSE c1
DEALLOCATE c1
GO
------------------- USING CASE ---------------------

select  TOP 2 m.Name,  CASE WHEN Count(mt.TheatreId) > 2 THEN m.Name + ' is a Superhit movie'
				    WHEN Count(mt.TheatreId) >= 1 THEN m.Name + ' is has average ratings'
			        ELSE m.Name + ' is a flop movie'
			   END as MovieVerdict

from Movies m LEFT OUTER JOIN MovieTheatre mt 
												 ON m.Id = mt.MovieId
												 GROUP BY m.Name
ORDER BY Count(mt.TheatreId) DESC