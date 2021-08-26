-- from the terminal run:
-- psql < music_new.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists
(
    id SERIAL PRIMARY KEY,
    artist TEXT NOT NULL
);

INSERT INTO artists 
    (artist)
VALUES
    ('Hanson'), ('Queen');

CREATE TABLE producers
(
    id SERIAL PRIMARY KEY,
    producer TEXT NOT NULL
);

INSERT INTO producers 
    (producer)
VALUES
    ('Dust Brothers'), ('Stephen Lironi'), ('Roy Thomas Baker');

CREATE TABLE albums
(
    id SERIAL PRIMARY KEY,
    album TEXT NOT NULL,
    release_date DATE NOT NULL
);

INSERT INTO albums 
    (album, release_date)
VALUES
    ('Middle of Nowhere','04-15-1997'), ('A Night at the Opera', '10-31-1975');

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  song  TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album INTEGER REFERENCES albums ON DELETE CASCADE
);

INSERT INTO songs
  (song, duration_in_seconds, album)
VALUES
  ('MMMBop', 238, 1), ('Bohemian Rhapsody', 355, 2);

CREATE TABLE song_artist
(
    song_id INTEGER REFERENCES songs ON DELETE CASCADE,
    artist_id INTEGER REFERENCES artists ON DELETE CASCADE
);

INSERT INTO song_artist
    (song_id, artist_id)
VALUES
    (1,1), (2,2);

CREATE TABLE album_producer
(
    album_id INTEGER REFERENCES albums ON DELETE CASCADE,
    producer_id INTEGER REFERENCES producers ON DELETE CASCADE
);

INSERT INTO album_producer
    (album_id, producer_id)
VALUES
    (1,1), (1,2), (2,3);



--QUERIES CHECKS:

--1. Who are producers of album "Middle of Nowhere"? 

-- SELECT producer FROM producers p
--  JOIN album_producer ap ON p.id = ap.producer_id
--  JOIN albums a ON a.id = ap.album_id
--  WHERE album = 'Middle of Nowhere';

--2. For which songs a producer was 'Roy Thomas Baker'?

-- SELECT song FROM songs s 
--     JOIN albums x ON s.album = x.id
-- WHERE x.id IN     
--     (
--         SELECT a.id FROM albums a 
--             JOIN album_producer ap ON ap.album_id = a.id
--             JOIN producers p ON ap.producer_id = p.id
--         WHERE p.producer = 'Roy Thomas Baker'
--     );


