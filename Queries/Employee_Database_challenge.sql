DROP TABLE titles;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no));
ALTER TABLE titles ADD COLUMN id SERIAL PRIMARY KEY;
SELECT * FROM titles;
	
SELECT * FROM employees;


DROP TABLE retirement_table;

SELECT 
	emp.emp_no,
	emp.first_name,
	emp.last_name,
	tit.title,
	tit.from_date,
	tit.to_date
INTO retirement_table
FROM employees as emp
INNER JOIN titles as tit
ON emp.emp_no = tit.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp.emp_no, to_date DESC;

select * from retirement_table

SELECT DISTINCT ON (ret_tab.emp_no)
	ret_tab.emp_no,
	ret_tab.first_name,
	ret_tab.last_name,
	ret_tab.title
INTO unique_titles
FROM retirement_table as ret_tab
ORDER BY ret_tab.emp_no, ret_tab.to_date DESC;

select * from unique_titles;

SELECT COUNT(unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

SELECT DISTINCT ON (emp.emp_no)
	emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	dep.from_date,
	dep.to_date,
	tit.title
INTO mentorship_eligibility
FROM employees AS emp
INNER JOIN dept_emp AS dep
ON emp.emp_no = dep.emp_no
INNER JOIN titles AS tit
ON emp.emp_no = tit.emp_no
WHERE dep.to_date = '9999-01-01' AND emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp.emp_no;

SELECT * FROM mentorship_eligibility;