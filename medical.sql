-- from the terminal run:
-- psql < medical.sql

DROP DATABASE IF EXISTS medical;

CREATE DATABASE medical;

\c medical

CREATE TABLE doctors
(
  id SERIAL PRIMARY KEY,
  doctor_name TEXT NOT NULL
);

INSERT INTO doctors
  (doctor_name)
VALUES
  ('Robert Brown'),
  ('Yosef Libman');


CREATE TABLE patients
(
  id SERIAL PRIMARY KEY,
  patient_name TEXT NOT NULL
);

INSERT INTO patients
  (patient_name)
VALUES
  ('Lada Dance'),
  ('Mary Pepper'),
  ('Charlie Kramer');

CREATE TABLE diseases
(
  id SERIAL PRIMARY KEY,
  disease TEXT NOT NULL
);

INSERT INTO diseases
  (disease)
VALUES
  ('COVID'),
  ('arrhythmia'),
  ('bronchitis'),
  ('tachycardia');


CREATE TABLE visits
(
  id SERIAL PRIMARY KEY,
  patient_id INTEGER REFERENCES patients ON DELETE CASCADE,
  doctor_id INTEGER REFERENCES doctors ON DELETE CASCADE,
  visit_date DATE
);

INSERT INTO visits
  (patient_id, doctor_id, visit_date)
VALUES
  (1,1,'8/25/2021'),
  (1,2,'8/25/2021'),
  (2,1,'8/25/2021'),
  (3,1,'8/26/2021');
  
  
CREATE TABLE diagnoses
(
  visit_id INTEGER REFERENCES patients ON DELETE CASCADE,
  disease_id INTEGER REFERENCES diseases ON DELETE CASCADE
);  
  
INSERT INTO diagnoses
  (visit_id, disease_id)
VALUES
  (1,1),
  (1,3),
  (2,2),
  (3,1);
  

  
-- QUERIES CHECK:
-- What deseases has a patient 'Lada Dance'?

-- SELECT d.disease FROM diseases d JOIN diagnoses di ON di.disease_id = d.id
-- JOIN visits vi ON di.visit_id = vi.id
-- WHERE vi.id IN (SELECT v.id FROM visits v JOIN patients p ON p.id = v.patient_id
-- WHERE p.patient_name = 'Lada Dance');



