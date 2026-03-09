
CREATE DATABASE IMD
USE IMD
CREATE TABLE Directors
(
	Director_Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100),
	SurName NVARCHAR(100)
)
CREATE TABLE Actors
(
	Actors_Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100),
	Surname NVARCHAR(100)
)
CREATE TABLE Genres
(
	Genres_Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100)
)
CREATE TABLE Movies
(
	Movies_Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100),
	ImdbPoint INT,
    Duration INT,
    Director_Id INT,
	FOREIGN KEY (Director_Id) REFERENCES Directors(Director_Id)
	
)
CREATE TABLE MovieActors
(
	Movies_Id INT,
	Actors_Id INT,
	PRIMARY KEY (Movies_Id, Actors_Id),
	FOREIGN KEY (Movies_Id) REFERENCES Movies(Movies_Id),
    FOREIGN KEY (Actors_Id) REFERENCES Actors(Actors_Id)
)
CREATE TABLE MovieGenres
(
	Movies_Id INT,
	Genres_Id INT,
	PRIMARY KEY (Movies_Id, Genres_Id),
	FOREIGN KEY (Movies_Id) REFERENCES Movies(Movies_Id),
    FOREIGN KEY (Genres_Id) REFERENCES Genres(Genres_Id)
)
INSERT INTO Directors (Name, Surname) VALUES 
('Christopher', 'Nolan');
INSERT INTO Actors (Name, Surname) VALUES 
('Christian', 'Bale'),
('Heath', 'Ledger'),
('Aaron', 'Eckhart'),
('Michael', 'Caine'),
('Gary', 'Oldman');
INSERT INTO Genres (Name) VALUES
('Action'),
('Crime'),
('Drama');
INSERT INTO Movies (Name, ImdbPoint, Duration, Director_Id) VALUES 
('The Dark Knight', 9, 152, 1);
INSERT INTO MovieActors (Movies_Id, Actors_Id) VALUES 
(1,1),
(1,2),
(1,3),
(1,4),
(1,5);
INSERT INTO MovieGenres (Movies_Id, Genres_Id) VALUES 
(1,1),
(1,2),
(1,3);
SELECT 
    Movies.Name,
    Movies.ImdbPoint,
    Movies.Duration,
	Actors.Name,
	Actors.Surname,
	Genres.Name AS GenreName,
	Directors.Name,
	Directors.SurName
FROM Movies
	JOIN MovieGenres 
	ON Movies.Movies_Id = MovieGenres.Movies_Id
	JOIN Genres 
	ON MovieGenres.Genres_Id = Genres.Genres_Id
	JOIN MovieActors 
	ON Movies.Movies_Id = MovieActors.Movies_Id
	JOIN Actors 
	ON MovieActors.Actors_Id = Actors.Actors_Id
	JOIN Directors 
	ON Movies.Director_Id = Directors.Director_Id	
SELECT 
    Movies.Name,
    Movies.ImdbPoint,
    Genres.Name AS GenreName
FROM Movies
JOIN MovieGenres 
ON Movies.Movies_Id = MovieGenres.Movies_Id
JOIN Genres 
ON MovieGenres.Genres_Id = Genres.Genres_Id
WHERE ImdbPoint > 6;
SELECT 
    Movies.Name,
    Movies.ImdbPoint,
    Genres.Name AS GenreName
FROM Movies
JOIN MovieGenres 
ON Movies.Movies_Id = MovieGenres.Movies_Id
JOIN Genres
ON MovieGenres.Genres_Id = Genres.Genres_Id
WHERE Genres.Name LIKE '%a%';
SELECT 
    Movies.Name,
    Movies.ImdbPoint,
    Movies.Duration,
    Genres.Name AS GenreName
FROM Movies 
JOIN MovieGenres
ON Movies.Movies_Id = MovieGenres.Movies_Id
JOIN Genres
ON MovieGenres.Genres_Id = Genres.Genres_Id
WHERE LEN(Movies.Name) > 10
AND Movies.Name LIKE '%t'

CREATE DATABASE Spotify
USE Spotify
CREATE TABLE Artists
(
	Artists_Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100),
	SurName NVARCHAR(100)
)
CREATE TABLE Albums
(
	Name NVARCHAR(100),
	Albums_Id INT PRIMARY KEY IDENTITY,
	Artists_Id INT,
	FOREIGN KEY (Artists_Id) REFERENCES Artists(Artists_Id)
)
CREATE TABLE Musics
(	
	Musics_Id INT PRIMARY KEY IDENTITY,
	Albums_Id INT,
	Artists_Id INT,
	Name NVARCHAR(100),
	TotalSecond INT,
	FOREIGN KEY (Albums_Id) REFERENCES Albums(Albums_Id),
	FOREIGN KEY (Artists_Id) REFERENCES Artists(Artists_Id)
)
INSERT INTO Artists (Name) VALUES
('Eminem'),
('Dr. Dre'),
('Rihanna');
INSERT INTO Albums (Name, Artists_Id) VALUES
('Curtain Call: The Hits', 1),
('The Eminem Show', 1),
('2001', 2);
INSERT INTO Musics (Name, TotalSecond, Albums_Id, Artists_Id) VALUES
('Lose Yourself', 326, 1, 1),
('Without Me', 290, 2, 1),
('Sing For The Moment', 340, 2, 1),
('Still D.R.E.', 270, 3, 2),
('Love The Way You Lie', 263, 1, 1);
SELECT 
    Musics.Name,
	Musics.TotalSecond,
	Artists.Name AS ArtistName,
	Artists.SurName AS ArtistSurName,
	Albums.Name AS AlbumName


FROM Musics
	JOIN Albums 
	ON Musics.Albums_Id = Albums.Albums_Id
	JOIN Artists 
	ON Musics.Artists_Id = Artists.Artists_Id
SELECT 
    Albums.Name,
    COUNT(Musics.Musics_Id) AS SongsCount
FROM Albums
JOIN Musics 
ON Musics.Albums_Id = Albums.Albums_Id
GROUP BY Albums.Name
