-- Query all of the entries in the Genre table

SELECT * FROM Genre

-- Using the INSERT statement, add one of your favorite artists to the Artist table.

INSERT INTO Artist (ArtistName, YearEstablished)
VALUES ('The Kinks', 1964)

-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId)
VALUES ('Face to Face', 1966, 3832, 'Pye', 
(SELECT ArtistId FROM Artist WHERE ArtistName = 'The Kinks'), 
(SELECT GenreId FROM Genre WHERE Label = 'Rock')),
('Village Green Preservation Society', 1968, 3858, 'Pye', 
(SELECT ArtistId FROM Artist WHERE ArtistName = 'The Kinks'), 
(SELECT GenreId FROM Genre WHERE Label = 'Rock'))


-- Using the INSERT statement, add some songs that are on that album to the Song table.

INSERT INTO Song (Title, SongLength, ReleaseDate, AlbumId, ArtistId, GenreId)
VALUES ('Picture Book', 234,
(SELECT ReleaseDate FROM Album WHERE Title = 'Village Green Preservation Society'), 
(SELECT AlbumId FROM Album WHERE Title = 'Village Green Preservation Society'), 
(SELECT ArtistID FROM Artist WHERE ArtistName = 'The Kinks'), 
(SELECT GenreID FROM Genre WHERE Label = 'Rock')),
('Sunny Afternoon', 336,
(SELECT ReleaseDate FROM Album WHERE Title = 'Face to Face'),
(SELECT AlbumId FROM Album WHERE Title = 'Face to Face'), 
(SELECT ArtistID FROM Artist WHERE ArtistName = 'The Kinks'), 
(SELECT GenreID FROM Genre WHERE Label = 'Rock'))

---  or  ---

Insert INTO Song
SELECT "Queen of Darkness", 344, 1966, g.GenreId, ar.ArtistId, al.AlbumId
FROM Artist ar, Genre g, Album al
WHERE ar.ArtistName = "The Kinks"
AND g.Label = "Rock"
AND al.Title = "Face to Face"

-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

SELECT s.Title AS "Song", al.Title AS "Album", ar.ArtistName "Artist"
FROM Song s
LEFT JOIN Album al ON al.AlbumId = s.AlbumId
LEFT JOIN Artist ar ON ar.ArtistId = s.ArtistId
WHERE ar.ArtistName = "The Kinks"


-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(Song.SongId) "Song Count", Album.Title "Album"
From Song
Join Album
On Song.AlbumId = Album.AlbumId
Group by Album.Title

-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(Song.SongId) "Song Count", Artist.ArtistName "Artist"
From Song
Join Artist
On Song.ArtistId = Artist.ArtistId
Group by Artist.ArtistName


-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(Song.SongId) "Song Count", Genre.Label "Genre"
From Song
Join Genre
On Song.GenreId = Genre.GenreId
Group by Genre.Label


-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

SELECT MAX(AlbumLength) "Album Length", Title "Title"
From Album


-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

SELECT MAX(SongLength) "Song Length", Title "Title", 
From Song


-- Modify the previous query to also display the title of the album.

SELECT MAX(Song.SongLength) "Song Length", Song.Title "Song", Album.Title "Album"
From Song
Join Album
On Song.AlbumId = Album.AlbumId