--create table for retiring employees with title
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
    t.title, 
    t.from_date, 
    t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

--create table for retiring employees at last position worked
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

--create table for number of retirees by deparment
SELECT COUNT(emp_no), title  
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--create table for mentorship eligible employees with title
SELECT distinct on (emp_no) e.emp_no, 
    e.first_name, 
    e.last_name,
    e.birth_date, 
    d.from_date, 
    d.to_date,
	titles.title
INTO mentorship_eligibilty
FROM employees as e
JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
INNER JOIN titles 
ON (e.emp_no = titles.emp_no)
WHERE (d.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;