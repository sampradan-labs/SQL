USE MoviesDb
GO

-- Select all movies
select * from Movies
-- Select all theatres
select * from Theatre
-- Select all movies that are shown in theatre id=1

select Name from Movies where Id IN (SELECT MovieId FROM MovieTheatre WHERE TheatreId = 1)

-- Sort all movies that start with "I" in desc order
select * from Movies Where Name LIKE 'I%' ORDER BY Id,Name DESC
-- Contains I in moviename
select * from Movies where Name LIKE '%I%'
-- Contains second character as 'n'
select * from Movies where Name LIKE '_n%'
-- movie either starts G,I,A
select * from Movies where name like 'G%' OR  name like 'I%' OR name like 'A%'
-- movies that start with G,I,A and end with s
select * from Movies where name like '[GIA]%s'

-- Get all theatres that show the movies {1,2,3}
select distinct * from theatre t INNER JOIN MovieTheatre mt ON t.Id = mt.theatreId where mt.movieid in (1,2,3)

-- Get all the theatres that show movies
select distinct t.Id, t.Name, t.TotalScreens from theatre t LEFT OUTER JOIN MovieTheatre mt 
																ON t.Id = mt.TheatreId

-- Get total count	of theatres that show movies
select COUNT( distinct t.Id) as TheatreCount from theatre t LEFT OUTER JOIN MovieTheatre mt ON t.Id = mt.TheatreId

--Get total theatre count per movie
select COUNT(t.Id) as TheatreCount, m.Name from theatre t 
						LEFT OUTER JOIN MovieTheatre mt ON t.Id = mt.TheatreId
						INNER JOIN Movies m ON mt.MovieId = m.Id						
GROUP BY m.Name
Having m.Name LIKE 'I%'
Order By Count(t.Id) ASC

-- GET total movie count per theatre

-- Get all Theatre details and movie details for a movie 1006
select t.Name as TheatreName, m.Name as MovieName from theatre t 
						FULL OUTER JOIN movietheatre mt ON t.id = mt.TheatreId
					    FULL OUTER JOIN movies m ON m.Id = mt.MovieId
					WHERE m.Id = 1006


-- Get which movie is NOT shown in any theatre
select * from movies where Id not in (select MovieId from MovieTheatre)

-- Get all movies and theatres that show movies and not show movies
select * from Movies CROSS JOIN Theatre

----------
-- Get emps who are not in any department



