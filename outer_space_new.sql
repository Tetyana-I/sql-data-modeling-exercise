-- from the terminal run:
-- psql < outer_space_new.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space


CREATE TABLE galaxies
(
    id SERIAL PRIMARY KEY,
    galaxy TEXT NOT NULL
);

INSERT INTO galaxies
    (galaxy)
VALUES
    ('Milky Way');

CREATE TABLE stars
(
    id SERIAL PRIMARY KEY,
    star TEXT NOT NULL, 
    galaxy_id INTEGER REFERENCES galaxies ON DELETE CASCADE
);

INSERT INTO stars
    (star, galaxy_id)
VALUES
    ('The Sun', 1), ('Proxima Centauri', 1), ('Gliese 876', 1);


CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  planet TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER REFERENCES stars ON DELETE CASCADE
);

INSERT INTO planets
  (planet, orbital_period_in_years, orbits_around)
VALUES
  ('Earth', 1.00, 1),
  ('Mars', 1.88, 1),
  ('Venus', 0.62, 1),
  ('Neptune', 164.8, 1),
  ('Proxima Centauri b', 0.03, 2),
  ('Gliese 876 b', 0.23, 3);

CREATE TABLE moons
(
    id SERIAL PRIMARY KEY,
    moon TEXT NOT NULL,
    planet_id INTEGER REFERENCES planets ON DELETE CASCADE
);

INSERT INTO moons
    (moon, planet_id)
VALUES
    ('The Moon', 1),
    ('Phobos', 2), ('Deimos', 2),
    ('Naiad', 4), ('Thalassa', 4), ('Despina', 4), ('Galatea', 4), ('Larissa', 4), ('S/2004 N 1', 4),
    ('Proteus', 4), ('Triton', 4), ('Nereid', 4), ('Halimede', 4), ('Sao', 4), ('Laomedeia', 4), ('Psamathe', 4), ('Neso', 4);

