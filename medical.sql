-- from the terminal run:
-- psql < medical.sql

DROP DATABASE IF EXISTS medical;

CREATE DATABASE medical;

\c medical

CREATE TABLE doctors
(
  id SERIAL PRIMARY KEY,
  doctor_name TEXT NOT NULL,
);

INSERT INTO doctors
  (doctor_name)
VALUES
  ('Robert Brown'),
  ('Yosef Libman');


CREATE TABLE patients
(
  id SERIAL PRIMARY KEY,
  patient_name TEXT NOT NULL,
);

INSERT INTO patients
  (patient_name)
VALUES
  ('Lada Dance'),
  ('Mary Pepper')
  ('Charlie Kramer');

CREATE TABLE diseases
(
  id SERIAL PRIMARY KEY,
  disease TEXT NOT NULL,
);

INSERT INTO diseases
  (disease)
VALUES
  ('COVID'),
  ('arrhythmia')
  ('bronchitis'),
  ('tachycardia');


CREATE TABLE visits
(
  id SERIAL PRIMARY KEY,
  patient_id INTEGER REFERENCES patients ON DELETE CASCADE,
  doctor_id INTEGER REFERENCES doctors ON DELETE SET NULL,
  visit_date DATE,
);

INSERT INTO visits
  (patient_id, doctor_id, date)
VALUES
  (1,1,'8/25/2021'),
  (1,2,'8/25/2021'),
  (2,1,'8/25/2021'),
  (3,1,'8/25/2021');
  
   
CREATE TABLE diagnoses
(
  id SERIAL PRIMARY KEY,
  visit_id INTEGER REFERENCES patients ON DELETE CASCADE,
  desease_id INTEGER REFERENCES doctors ON DELETE SET NULL,
);  
  
INSERT INTO diagnoses
  (pvisit_id, desease)
VALUES
  (1,1),
  (1,3),
  (2,2),
  (3,1);