-- from the terminal run:
-- psql < music.sql

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
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album INTEGER REFERENCES albums ON DELETE NULL,
);

INSERT INTO songs
  (title, duration_in_seconds, album)
VALUES
  ('MMMBop', 238, 1), ('Bohemian Rhapsody', 355, 2);

CREATE TABLE song_artist
(
    song_id INTEGER REFERENCES songs ON DELETE NULL,
    artist_id INTEGER REFERENCES artists ON DELETE NULL
);

INSERT INTO song_artist
    (song_id, artist_id)
VALUES
    (1,1), (2,2);

CREATE TABLE song_producer
(
    song_id INTEGER REFERENCES songs ON DELETE NULL,
    producer_id INTEGER REFERENCES producers ON DELETE NULL
);

INSERT INTO song_producer
    (song_id, producer_id)
VALUES
    (1,1), (1,2), (2,3);



INSERT INTO songs
  (title, duration_in_seconds, release_date, artists, album, producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');