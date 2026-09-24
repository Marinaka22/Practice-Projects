/*Write a query to create a students table with the student ID, 
 * first name, last name, class, and age fields. 
 * Ensure that the last name, first name, and student ID fields have 
 * the NOT NULL constraint, and that the student ID field is a primary key
 */
CREATE TABLE students (
    s_id INTEGER PRIMARY KEY AUTOINCREMENT,
    s_fname VARCHAR(100) NOT NULL,
    s_lname VARCHAR(100) NOT NULL,
    student_class VARCHAR(100),
    age INTEGER
);

--Write a query to create a marksheet table with score, year, ranking, class, and student ID fields 
CREATE TABLE marksheet (
    score INTEGER,
    year INTEGER,
    class INTEGER,
    ranking INTEGER,
    s_id INTEGER REFERENCES students(s_id)
);

--Write a query to insert values into the students table (refer to the csv files for data) 
INSERT INTO students (s_id, s_fname, s_lname, student_class, age) VALUES
(1, 'krishna', 'gee', 10, 18),
(2, 'Stephen', 'Christ', 10, 17),
(3, 'Kailash', 'kumar', 10, 18),
(4, 'ashish', 'jain', 10, 16),
(5, 'khusbu', 'jain', 10, 17),
(6, 'madhan', 'lal', 10, 16),
(7, 'saurab', 'kothari', 10, 15),
(8, 'vinesh', 'roy', 10, 14),
(9, 'rishika', 'r', 10, 15),
(10, 'sara', 'rayan', 10, 16),
(11, 'rosy', 'kumar', 10, 16);

--Write a query to insert values into the marksheet table (refer to the csv files for data) 
INSERT INTO marksheet (score, year, class, ranking, s_id) VALUES
(989, 2014, 10, 1, 1),
(454, 2014, 10, 10, 2),
(880, 2014, 10, 4, 3),
(870, 2014, 10, 5, 4),
(720, 2014, 10, 7, 5),
(670, 2014, 10, 8, 6),
(900, 2014, 10, 3, 7),
(540, 2014, 10, 9, 8),
(801, 2014, 10, 6, 9),
(420, 2014, 10, 11, 10),
(970, 2014, 10, 2, 11);

/*Write a query to display the student ID and first name of every student in the 
students table whose age is greater than or equal to 16 and whose last name is Kumar*/
SELECT s_id, s_fname
FROM students
WHERE age >= 16
  AND s_lname = 'Kumar';

--Write a query to display the details of every student from the marksheet table whose score is between 800 and 1000
SELECT *
FROM marksheet
WHERE score BETWEEN 800 AND 1000;

--Write a query to increase the score in the marksheet table by five and create a new score column to display this new score 
ALTER TABLE marksheet ADD COLUMN new_score INTEGER;

UPDATE marksheet
SET new_score = score + 5;

--Write a query to display the marksheet table in descending order of the score 
SELECT *, score + 5 AS new_score
FROM marksheet;

--Write a query to display the details of every student whose first name starts with an ‘a’ 
SELECT *
FROM students
WHERE s_fname LIKE 'a%';
