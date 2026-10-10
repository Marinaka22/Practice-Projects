CREATE TABLE Students (
    StudentID  INTEGER PRIMARY KEY,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    DOB        DATE,
    Major      VARCHAR(50),
    GPA        DECIMAL(3,2)
);

CREATE TABLE Courses (
    CourseID    INTEGER PRIMARY KEY,
    CourseName  VARCHAR(100) NOT NULL,
    Department  VARCHAR(50)
);

CREATE TABLE Instructors (
    InstructorID    INTEGER PRIMARY KEY,
    InstructorName  VARCHAR(100) NOT NULL,
    Department      VARCHAR(50)
);

CREATE TABLE Enrolments (
    EnrollmentID  INTEGER PRIMARY KEY,
    StudentID     INTEGER,
    CourseID      INTEGER,
    Semester      VARCHAR(20),
    Grade         VARCHAR(2)
);

--Create a view InstructorSchedule
CREATE VIEW InstructorSchedule AS
SELECT i.InstructorID,
       i.InstructorName,
       c.CourseName,
       i.Department
FROM Instructors i
LEFT JOIN Courses c ON i.Department = c.Department;

SELECT * FROM InstructorSchedule ORDER BY InstructorID;

--Modify CourseSummary
CREATE VIEW CourseSummary AS
SELECT c.CourseID,
       c.CourseName,
       GROUP_CONCAT(DISTINCT e.Semester) AS semesters_offered,
       COUNT(e.StudentID) AS total_students
FROM Courses c
LEFT JOIN Enrolments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

SELECT * FROM CourseSummary;

--Update InstructorSchedule
CREATE VIEW InstructorSchedule AS
SELECT DISTINCT i.InstructorID,
       i.InstructorName,
       c.CourseName,
       i.Department
FROM Instructors i
JOIN Courses c     ON i.Department = c.Department
JOIN Enrolments e  ON c.CourseID = e.CourseID
WHERE e.Semester = 'Spring 2024';

SELECT * FROM InstructorSchedule ORDER BY InstructorID;

--Create a view EligibleGraduates
CREATE VIEW EligibleGraduates AS
SELECT StudentID,
       FirstName,
       LastName,
       Major,
       GPA
FROM Students
WHERE GPA >= 3.7;

SELECT * FROM EligibleGraduates ORDER BY GPA DESC;

--Alter EligibleGraduates
CREATE VIEW EligibleGraduates AS
SELECT StudentID,
       FirstName,
       LastName,
       Major,
       GPA
FROM Students
WHERE GPA >= 3.7;

SELECT * FROM EligibleGraduates ORDER BY GPA DESC;

--Rename CourseSummary
DROP VIEW IF EXISTS CourseEnrolmentSummary;
DROP VIEW IF EXISTS CourseSummary;

CREATE VIEW CourseEnrolmentSummary AS
SELECT c.CourseID,
       c.CourseName,
       GROUP_CONCAT(DISTINCT e.Semester) AS semesters_offered,
       COUNT(e.StudentID) AS total_students
FROM Courses c
LEFT JOIN Enrolments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

SELECT * FROM CourseEnrolmentSummary;

--Drop EligibleGraduates
DROP VIEW EligibleGraduates;
SELECT name FROM sqlite_master WHERE type = 'view';

--Create a CTE
WITH SemesterCourses AS (
    SELECT DISTINCT c.CourseID,
           c.CourseName,
           c.Department
    FROM Courses c
    JOIN Enrolments e ON c.CourseID = e.CourseID
    WHERE e.Semester = 'Spring 2024'
)
SELECT *
FROM SemesterCourses
ORDER BY CourseID;