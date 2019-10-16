CREATE TABLE departments(
dept_no VARCHAR,
dept_name VARCHAR
);

CREATE TABLE dept_emp(
emp_no INT,
dept_no VARCHAR,
from_date DATE,
to_date DATE
);

CREATE TABLE dept_manager(
dept_no VARCHAR,
emp_no INT,
from_date DATE,
to_date DATE
);

CREATE TABLE employees(
emp_no INT,
birth_date DATE,
first_name VARCHAR,
last_name VARCHAR,
gender VARCHAR,
hire_date DATE
);

CREATE TABLE salaries(
emp_no INT,
salary INT,
from_date DATE,
to_date DATE
);

CREATE TABLE titles(
emp_no INT,
title VARCHAR,
from_date DATE,
to_date DATE
);

--1. List the following details of each employee: 
--employee number, last name, first name, gender, and salary.
create view first as
select emp.emp_no, emp.last_name, emp.first_name, emp.gender, salaries.salary from employees as emp
inner join salaries ON
emp.emp_no = salaries.emp_no;

--2. List employees who were hired in 1986.
create view second as
SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

--5. List all employees whose first name is "Hercules" and last names begin with "B."

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.