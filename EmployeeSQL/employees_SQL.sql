
--Creating tables. 
DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments(
    "dept_no" VARCHAR NOT NULL,
    "dept_name" VARCHAR NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp(
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL
);

DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager(
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL
);

DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees(
 "emp_no" INT   NOT NULL,
  "birth_date" DATE   NOT NULL,
  "first_name" VARCHAR   NOT NULL,
  "last_name" VARCHAR   NOT NULL,
  "gender" VARCHAR   NOT NULL,
   "hire_date" DATE   NOT NULL,
   CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries(
	"emp_no" INT   NOT NULL,
   	"salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles(
	"emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);
--Altering Tables to make foreign keys

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
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

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
create view third as
SELECT dman.dept_no, dep.dept_name, dman.emp_no, employees.first_name, employees.last_name, dman.from_date, dman.to_date 
FROM employees
JOIN dept_manager as dman 
ON  employees.emp_no = dman.emp_no
JOIN departments as dep
ON dman.dept_no = dep.dept_no ;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
create view forth as 
SELECT dept_emp.emp_no,  employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;
--5. List all employees whose first name is "Hercules" and last names begin with "B."
create view fifth as 
SELECT first_name, last_name 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE'B%';
--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
create view six as 
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
create view seven as 
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no 
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Development'
OR departments.dept_name = 'Sales' ;
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create view eight as 
SELECT last_name,
COUNT(last_name) AS "Name_frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
