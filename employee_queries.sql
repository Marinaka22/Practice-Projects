CREATE TABLE IF NOT EXISTS emp_record_table(
	EMP_ID VARCHAR(10) PRIMARY KEY,
	FIRST_NAME VARCHAR(30) NOT NULL,
	LAST_NAME VARCHAR(30) NOT NULL,
	GENDER VARCHAR(1),
	ROLE VARCHAR(40),
	DEPT VARCHAR(30),
	EXP INTEGER,
	COUNTRY VARCHAR(30), 
	CONTINENT VARCHAR(30),
	SALARY INTEGER,
	EMP_RATING INTEGER,
	MANAGER_ID VARCHAR(10),
	PROJ_ID VARCHAR(10)
);
	
CREATE TABLE IF NOT EXISTS data_science_team(
	EMP_ID VARCHAR(10) PRIMARY KEY,
	FIRST_NAME VARCHAR(30) NOT NULL,
	LAST_NAME VARCHAR(30) NOT NULL,
	GENDER VARCHAR(1),
	ROLE VARCHAR(40),
	DEPT VARCHAR(30),
	COUNTRY VARCHAR(30),
	CONTINENT VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS proj_table(
	PROJECT_ID VARCHAR(10) PRIMARY KEY,
	PROJ_NAME VARCHAR(50) NOT NULL,
	DOMAIN VARCHAR(30),
	START_DATE DATE,
	CLOSURE_DATE DATE,
	DEV_QTR VARCHAR(5),
	STATUS VARCHAR(20)
);

SELECT * FROM proj_table;
SELECT * FROM emp_record_table;
SELECT * FROM proj_table;

/*Write a query to return EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, 
 and make a list of employees and details of their department.*/
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.GENDER, e.DEPT,
       p.PROJ_NAME, p.STATUS
FROM emp_record_table e
LEFT JOIN proj_table p ON p.PROJECT_ID = e.PROJ_ID
ORDER BY e.DEPT, e.EMP_ID;

/*Write a query to return EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two, greater than four, and between two and four*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT AS DEPARTMENT, EMP_RATING,
	CASE 
		WHEN EMP_RATING < 2 THEN 'Less Then Two'
		WHEN EMP_RATING < 4 THEN 'Greater than four'
		ELSE 'between two and four'
	END AS RATING_GROUP	
FROM emp_record_table
ORDER BY EMP_RATING;

/*Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the 
Finance department from the employee table and then give the resultant column alias as NAME.*/
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS NAME,
       p.PROJ_NAME
FROM emp_record_table e
LEFT JOIN proj_table p ON p.PROJECT_ID = e.PROJ_ID
WHERE e.DEPT = 'FINANCE';

/*Write a SQL query to retrieve the employee ID, first name, role, and department of employees 
 who hold leadership positions (Manager, President, or CEO).*/
SELECT e.EMP_ID, e.FIRST_NAME, e.ROLE, e.DEPT,
       m.FIRST_NAME || ' ' || m.LAST_NAME AS REPORTS_TO
FROM emp_record_table e
LEFT JOIN emp_record_table m ON m.EMP_ID = e.MANAGER_ID
WHERE e.ROLE IN ('MANAGER', 'PRESIDENT', 'CEO');

/*Write a query to list all the employees from the healthcare and finance departments using union or union all. 
 Take data from the employee record table.*/
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPT, p.PROJ_NAME
FROM emp_record_table e
LEFT JOIN proj_table p ON p.PROJECT_ID = e.PROJ_ID
WHERE e.DEPT = 'HEALTHCARE'

UNION

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPT, p.PROJ_NAME
FROM emp_record_table e
LEFT JOIN proj_table p ON p.PROJECT_ID = e.PROJ_ID
WHERE e.DEPT = 'FINANCE';

/*Write a query to list employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
 * Also include the respective employee rating along with the max emp rating for the department*/
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPT, e.EMP_RATING,
       m.MAX_DEPT_RATING
FROM emp_record_table e
JOIN (SELECT DEPT, MAX(EMP_RATING) AS MAX_DEPT_RATING
      FROM emp_record_table
      GROUP BY DEPT) m
  ON e.DEPT = m.DEPT
ORDER BY e.DEPT, e.EMP_RATING DESC;

/*Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.*/
SELECT ROLE,
       MIN(SALARY) AS MIN_SALARY,
       MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE
ORDER BY ROLE;

/*Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, RANK() OVER (ORDER BY EXP DESC) AS EXP_RANK
FROM emp_record_table
ORDER BY DEPT;

/*Write a query to create a view that displays employees in various countries whose salary is more than six thousand. 
 Take data from the employee record table.*/
CREATE VIEW employees_high_salary AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

SELECT * FROM employees_high_salary;

/*Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT AS DEPARTMENT, EXP
FROM emp_record_table
WHERE EXP > 10;

/*Write a query in the project table to check whether the job profile assigned to each employee 
in the data science team matches the organization’s set standard.The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.*/
SELECT
    EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EXP, ROLE AS CURRENT_ROLE, STANDARD_ROLE,
    CASE
        WHEN ROLE = STANDARD_ROLE THEN 'MATCH'
        ELSE 'DOES NOT MATCH'
    END AS ROLE_CHECK
FROM (
    SELECT
        EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EXP, ROLE,
        CASE
            WHEN EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
            WHEN EXP > 2  AND EXP <= 5  THEN 'ASSOCIATE DATA SCIENTIST'
            WHEN EXP > 5  AND EXP <= 10 THEN 'SENIOR DATA SCIENTIST'
            WHEN EXP > 10 AND EXP <= 12 THEN 'LEAD DATA SCIENTIST'
            WHEN EXP > 12 AND EXP <= 16 THEN 'MANAGER'
        END AS STANDARD_ROLE
    FROM data_science_team
) AS t
ORDER BY EMP_ID;

/*Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING,
	0.05 * SALARY * EMP_RATING AS BONUS
FROM emp_record_table;

/*Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.*/
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVG_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

