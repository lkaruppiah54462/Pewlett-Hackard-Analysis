--querries
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM dept_emp;

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name) FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT *  FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date 
FROM retirement_info as ri
LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no INTO dept_ret
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM dept_ret;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
-- INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');
	 
SELECT * FROM emp_info	 

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
DROP TABLE emp_info		

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM dept_manager
SELECT * FROM departments

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name IN('Sales','Development'));


SELECT ce.emp_no,
ce.first_name,
ce.last_name,
ti.title,
de.from_date,
s.salary
INTO title_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (ce.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ce.emp_no = s.emp_no);

--REDONE because of unique key problem with title

SELECT * FROM titles


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
ti.title,
de.from_date,
s.salary
INTO title_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (ce.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ce.emp_no = s.emp_no);


SELECT * FROM title_info

SELECT * FROM titles

SELECT first_name,last_name,count(*) 
FROM title_info
GROUP BY
	first_name,
	last_name
HAVING count(*) > 1

SELECT * 
INTO title_unique_info
FROM 
(SELECT *,ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM title_info
 ) tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM title_unique_info


SELECT tui.emp_no,d.dept_name
INTO title_count_by_dept_raw
FROM title_unique_info as tui
LEFT JOIN dept_emp as de
ON tui.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no;

SELECT * FROM title_count_by_dept_raw

SELECT * 
INTO title_count_by_dept
FROM 
(SELECT *,ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY  dept_name DESC) rn
 FROM title_count_by_dept_raw
 ) tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM title_count_by_dept

SELECT COUNT(emp_no),dept_name
INTO title_count_by_dept1
FROM title_count_by_dept
GROUP BY dept_name

SELECT * FROM title_count_by_dept1


-- Create new table for mentoring employees
SELECT emp_no, first_name, last_name
INTO mentoring_info
FROM employees
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM mentoring_info;

-- eligible mentoring employees still working(9999-01-01)
SELECT mi.emp_no,
	mi.first_name,
	mi.last_name,
	de.to_date
INTO mentoring_emp
FROM mentoring_info as mi
LEFT JOIN dept_emp as de
ON mi.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


SELECT me.emp_no,
me.first_name,
me.last_name,
ti.title,
de.from_date,
de.to_date
INTO mentoring_title_info
FROM mentoring_emp as me
INNER JOIN dept_emp AS de
ON (me.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (me.emp_no = ti.emp_no);


SELECT * 
INTO mentoring_title_unique_info
FROM 
(SELECT *,ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentoring_title_info
 ) tmp WHERE rn = 1
ORDER BY emp_no;


SELECT mtui.emp_no,d.dept_name
INTO mentoring_title_count_by_dept_raw
FROM mentoring_title_unique_info as mtui
LEFT JOIN dept_emp as de
ON mtui.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no;


SELECT * 
INTO mentoring_title_count_by_dept
FROM 
(SELECT *,ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY  dept_name DESC) rn
 FROM mentoring_title_count_by_dept_raw
 ) tmp WHERE rn = 1
ORDER BY emp_no;


SELECT COUNT(emp_no),dept_name
INTO menoring_title_count_by_dept1
FROM mentoring_title_count_by_dept
GROUP BY dept_name

SELECT * FROM title_unique_info


SELECT COUNT(emp_no),title
INTO count_by_title
FROM title_unique_info
GROUP BY title

SELECT * FROM count_by_title