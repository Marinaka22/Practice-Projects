/*Create Employee Table
Execute SQL code to create an employee table named XYZ.employee with fields:
emp_id, f_name, l_name, job_id, salary, manager_id, dept_id
Utilize any necessary joins, subqueries, or set operations during the creation if applicable*/
CREATE TABLE IF NOT EXISTS employee (
	emp_id INTEGER PRIMARY KEY,
	f_name VARCHAR(50),
	l_name VARCHAR(50),
	job_id INTEGER,
	salary INTEGER,
	manager_id INTEGER,
	dept_id INTEGER
);

--Insert Values
INSERT INTO employee (emp_id, f_name, l_name, job_id, salary, manager_id, dept_id) VALUES
(101, 'John',    'Smith',    'JP123', 70000, 02, 30),
(102, 'Emily',   'Johnson',  'EN456', 80000, 03, 40),
(103, 'Michael', 'Williams', 'MW789', 90000, 04, 20),
(104, 'Emma',    'Jones',    'EJ567', 75000, 02, 10),
(105, 'Calvin',  'Miller',   'CM345', 85000, 03, 30),
(106, 'Sophia',  'Davis',    'SD678', 95000, 04, 20),
(107, 'Liam',    'Moore',    'LM901', 72000, 02, 40),
(108, 'Olivia',  'Anderson', 'OA234', 87000, 03, 10),
(109, 'William', 'Brown',    'WB567', 92000, 04, 30),
(110, 'Ava',     'Taylor',   'AT890', 78000, 02, 20);

SELECT * FROM employee;

/*Retrieve Names with Higher Salary (Using Joins)
Execute SQL code to retrieve the first and last names of employees with a salary higher than Calvin. Utilize joins to compare employee salaries.*/
SELECT e.f_name, e.l_name
FROM employee e
JOIN employee c
	ON e.salary > c.salary
WHERE c.f_name= 'Calvin';

--with Salary showing
SELECT e.f_name, e.l_name, e.salary
FROM employee e
JOIN employee c
	ON e.salary > c.salary
WHERE c.f_name= 'Calvin'
ORDER BY e.salary DESC;

/*Display ID and Last Name Above Average Salary (Using Subqueries)
Execute SQL code to display employee ID and last name of those with a salary greater than the average salary of all employees. 
Utilize subqueries to calculate the average.*/
SELECT emp_id, l_name
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

/*Display ID and First Name Above MW789 (Sorted by Salary Using Set Operations)
Execute SQL code to display employee ID and first name of those with a salary higher than the job_id - MW789, sorted by salary. 
Utilize set operations to compare salaries with the job_id - MW789.*/
SELECT e.emp_id, e.f_name, e.salary
FROM employee e
JOIN employee m
	ON e.salary > m.salary 
WHERE m.job_id = 'MW789' AND e.dept_id = 20
UNION 
SELECT e.emp_id, e.f_name, e.salary 
FROM employee e
JOIN employee m
	ON e.salary > m.salary 
WHERE m.job_id = 'MW789' AND e.dept_id = 30
ORDER BY e.salary;

/*Display Top Three Earners (Using Joins and Subqueries)
Execute SQL code to display the top three earners' first names, employee IDs, and salaries. Utilize a subquery in the 
FROM  clause to identify the top earners based on salary and a join to retrieve full employee details.*/
SELECT e.f_name, e.emp_id, e.salary
FROM employee e
JOIN (
	SELECT  emp_id
	FROM employee
	ORDER BY salary DESC
	LIMIT 3)
t ON e.emp_id = t.emp_id
ORDER BY e.salary DESC;





