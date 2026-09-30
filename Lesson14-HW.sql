/*Create a patients table with fields like date, patient ID, name, age, 
weight, gender, location, phone number, disease, doctor's name, and doctor ID. 
Write a query to create a patients table with the date, patient ID, patient name, 
age, weight, gender, location, phone number, disease, doctor name, and doctor ID fields*/

CREATE TABLE IF NOT EXISTS patients(
date DATE,
pid VARCHAR(20) PRIMARY KEY,
p_name VARCHAR(50) NOT NULL,
age INTEGER,
weight INTEGER,
gender VARCHAR(20),
location VARCHAR(50),
phone_no VARCHAR(20),
disease VARCHAR(50),
doctor_name VARCHAR(50),
doctor_id INTEGER
);

/*Insert values into the patients table. 
Write a query to insert values into the patients table*/
INSERT INTO patients(date, pid, p_name, age, weight,gender, location, phone_no, disease, doctor_name, doctor_id)
VALUES('2019-06-15', 'AP2021', 'Sarath', 67, 76, 'Male',   'chennai',   '5462829', 'Cardiac', 'Mohan',   21),
('2019-02-13', 'AP2022', 'John',   62, 80, 'Male',   'banglore',  '1234731', 'Cancer',  'Suraj',   22),
('2018-01-08', 'AP2023', 'Henry',  43, 65, 'Male',   'Kerala',    '9028320', 'Liver',   'Mehta',   23),
('2020-02-04', 'AP2024', 'Carl',   56, 72, 'Female', 'Mumbai',    '9293829', 'Asthma',  'Karthik', 24),
('2017-09-15', 'AP2025', 'Shikar', 55, 71, 'Male',   'Delhi',     '7821281', 'Cardiac', 'Mohan',   21),
('2018-07-22', 'AP2026', 'Piysuh', 47, 59, 'Male',   'Haryana',   '8912819', 'Cancer',  'Suraj',   22),
('2017-03-25', 'AP2027', 'Stephen',69, 55, 'Male',   'Gujarat',   '8888211', 'Liver',   'Mehta',   23),
('2019-04-22', 'AP2028', 'Aaron',  75, 53, 'Male',   'banglore',  '9012192', 'Asthma',  'Karthik', 24);

--Write a query to display the total number of patients in the table 
SELECT COUNT(*) AS total_patients
FROM patients;

--Write a query to display the patient id and patient name with the current date
SELECT pid, p_name, CURRENT_DATE AS current_date
FROM patients;

--Write a query to display the old patient name and the new patient name in uppercase
SELECT p_name AS old_patients_name, UPPER(p_name) AS new_patient_name
FROM patients;

--Write a query to display the patients' names along with the total number of characters in their name
SELECT p_name, LENGTH(p_name) AS total_characters
FROM patients;

--Write a query to combine the patient's name and the doctor's name in a new column
SELECT p_name || doctor_name AS patient_and_doctor
FROM patients;

--Write a query to extract the year for a given date and place it in a separate column
SELECT date, strftime('%Y', date) AS year
FROM patients;

--Write a query to display duplicate entries in the doctor name column
SELECT doctor_name,COUNT(*)
FROM patients
GROUP BY doctor_name
HAVING COUNT(*) > 1;