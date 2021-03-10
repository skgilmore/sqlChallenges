-- Task One: Query all of the entries in the Genre table
Select *
from Genre
order by Label

--Task Two: Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords
Select *
from Artist 
order by ArtistName;

--Task Three: Write a SELECT query that lists all the songs in the Song table and include the Artist name
Select
s.Id,
s.Title,
a.ArtistName
from Song s
join Artist a on s.ArtistId = a.id
order by Title;

-- Task 4: Write a SELECT query that lists all the Artists that have a Pop Album
select *
from Album
left join Artist on Album.ArtistId = Artist.Id
left join Genre on Album.ArtistId  = Artist.Id
where GenreId = 9
-- genre did not return any results so used another to get results

-- Task 5 
select *
from Album
where Album.GenreId = 4  or Album.GenreId = 2;


--Task 6
Select Distinct
al.Id,
al.Title
From Album al  
left join song s on al.Id = s.AlbumId
where s.AlbumId is null;

--Task 7: Using the INSERT statement, add one of your favorite artists to the Artist table.
--insert into Artist (ArtistName,YearEstablished) values ( 'Matchbox20', 1990) 

-- Task 8: Using the INSERT statement, add one, or more, albums by your artist to the Album table.
--insert into Album (Title,ArtistId,AlbumLength,GenreId,Label,ReleaseDate)
 --Values ('MadSeason', 29, 188, 2, 'SunStudios', 1/02/1996)

 --Task 9: Using the INSERT statement, add some songs that are on that album to the Song table.
--insert into Song(Title,ArtistId,SongLength,GenreId,ReleaseDate,AlbumId)
--Values ('3AM', 29, 338, 2, 1/02/1996, 26)

--Task 10 :Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. 
--Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.
/*Reminder: Direction of join matters. Try the following statements and see the difference in results.
SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;
SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;
*/
Select s.Title songTitle, al.Title albumTitle, ar.ArtistName
 from song s
	left join Album al on s.AlbumId = al.Id
	left join artist ar on s.ArtistId = ar.id
where s.Title = '3AM'
	or ar.ArtistName = 'Matchbox 20'


/* Task 11:Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.*/
-- count goes in the select. cant use count w/o group will get an aggregate funtion error
Select count(s.id) as SongCount, al.Title as AlbumTitle, ar.ArtistName 
from song s
		left join Album al on s.AlbumId = al.Id
		left join Artist ar on al.ArtistId = ar.Id
group by al.Title, ar.ArtistName

/* Task 12 : Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence*/

select count(s.id) as SongCount, ar.ArtistName 
from song s 
		left join Artist ar on s.ArtistId = ar.Id
		group by ar.Id, ar.ArtistName

/* Task 13: Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence. */

select count (s.GenreId), Genre.Label
from song s
		left join Genre on s.GenreId = Genre.Id
		group by s.GenreId, Genre.Label;


/* Task 14: Write a SELECT query that lists the Artists that have put out records on more than one record label.
Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword */

Select count(distinct Album.Label) as whatItBe, Artist.ArtistName
from Artist
		 join album  on Artist.id = Album.ArtistId
group by  Artist.ArtistName
having count(distinct Album.Label) >1

-- Task 15: Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

select Album.AlbumLength , Album.Title
from album 
where Album.AlbumLength = (
select max(Album.AlbumLength)
from Album);

-- Task 16: Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
select Song.SongLength , Song.Title
from Song
where song.SongLength = (
select max(Song.SongLength)
from song);

-- Task 17: Modify the previous query to also display the title of the album.
select Song.SongLength , Song.Title, Album.Title
from Song
join Album on Album.Id = song.AlbumId
where song.SongLength = (
select max(Song.SongLength)
from song);