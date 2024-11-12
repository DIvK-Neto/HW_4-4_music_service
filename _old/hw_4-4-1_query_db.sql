CREATE TABLE IF NOT EXISTS genre (
	id SERIAL PRIMARY KEY,
	title VARCHAR(40) NOT NULL
);


CREATE TABLE IF NOT EXISTS artist (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL
);


CREATE TABLE IF NOT EXISTS album (
	id SERIAL PRIMARY KEY,
	title VARCHAR(80) NOT NULL UNIQUE,
	year INTEGER NOT NULL CHECK (year BETWEEN 1900 AND EXTRACT(year FROM CURRENT_DATE))
);


CREATE TABLE IF NOT EXISTS collection (
	id SERIAL PRIMARY KEY,
	title VARCHAR(80) NOT NULL UNIQUE,
	year INTEGER NOT NULL CHECK (year BETWEEN 1900 AND EXTRACT(year FROM CURRENT_DATE))
);


CREATE TABLE IF NOT EXISTS track (
	id SERIAL PRIMARY KEY,
	album_id INTEGER REFERENCES album(id),
	title VARCHAR(80) NOT NULL,
	duration INTEGER
);


CREATE TABLE IF NOT EXISTS artistGenre (
	genre_id INTEGER REFERENCES genre(id),
	artist_id INTEGER REFERENCES artist(id),
	CONSTRAINT pk PRIMARY KEY (genre_id, artist_id)
);


CREATE TABLE IF NOT EXISTS artistAlbum (
	artist_id INTEGER REFERENCES artist(id),
	album_id INTEGER REFERENCES album(id),
	CONSTRAINT pk1 PRIMARY KEY (artist_id, album_id)
);


CREATE TABLE IF NOT EXISTS collectionTrack (
	collection_id INTEGER REFERENCES collection(id),
	track_id INTEGER REFERENCES track(id),
	CONSTRAINT pk2 PRIMARY KEY (collection_id, track_id)
);


