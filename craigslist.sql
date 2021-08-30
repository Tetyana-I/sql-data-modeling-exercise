-- from the terminal run:
-- psql < craigslist.sql

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE users
(
  id SERIAL PRIMARY KEY,
  username VARCHAR(20) NOT NULL
);

CREATE TABLE categories
(
  id SERIAL PRIMARY KEY,
  category TEXT NOT NULL
);

CREATE TABLE locations
(
  id SERIAL PRIMARY KEY,
  location TEXT NOT NULL
);

CREATE TABLE regions
(
  id SERIAL PRIMARY KEY,
  region TEXT NOT NULL
);


CREATE TABLE posts
(
    id SERIAL PRIMARY KEY,
    post VARCHAR(30),
    post_text TEXT NOT NULL,
    user_id INTEGER REFERENCES users ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations ON DELETE CASCADE,
    region_id INTEGER REFERENCES regions ON DELETE CASCADE,
    category_id INTEGER REFERENCES regions ON DELETE CASCADE
);