select *
from Album
left join Artist on Album.ArtistId = Artist.Id
left join Genre on Album.ArtistId  = Artist.Id
where GenreId = 9






