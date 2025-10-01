-- WHERE clause + AND & OR
-- Select the employees who make more than 50K
SELECT *
FROM employees
WHERE salary > 50000;

-- Select only the employees who work at Common Grounds Coffeeshop
SELECT * 
FROM employees
WHERE coffeeshop_id = 1;

-- Select all the employees who work at Common Grounds and earn more than 50k
SELECT *
FROM employees
WHERE coffeeshop_id = 1 AND salary > 50000;
	
-- Select all the employees who work at Common Grounds or earn more than 50k
SELECT *
FROM employees
WHERE coffeeshop_id = 1 OR salary > 50000;

-- Select all the employees who work at Common Grounds, make more than 50k and are male
SELECT *
FROM employees
WHERE coffeeshop_id = 1 AND salary > 50000 AND gender = 'M';

-- Select all the employees who work at Common Grounds or make more than 50k or are male
SELECT *
FROM employees
WHERE coffeeshop_id = 1 OR salary > 50000 OR gender = 'M';

-- IN, NOT IN, IS NULL, BETWEEN
-- Select all rows from the suppliers table where the supplier is Beans and Barley
SELECT *
FROM suppliers
WHERE supplier_name = 'Beans and Barley';

-- Select all rows from the suppliers table where the supplier is NOT Beans and Barley
SELECT *
FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley';

SELECT *
FROM suppliers
WHERE supplier_name <> 'Beans and Barley';

-- Select all Robusta and Arabica coffee types
SELECT *
FROM suppliers
WHERE coffee_type = 'Robusta' OR coffee_type = 'Arabica';

SELECT *
FROM suppliers
WHERE coffee_type IN ('Robusta', 'Arabica');

-- Select all coffee types that are NOT Robusta or Arabica
SELECT *
FROM suppliers
WHERE coffee_type NOT IN ('Robusta', 'Arabica');

-- Select all employees with missing email addresses
SELECT *
FROM employees
WHERE email IS NULL;

-- Select all employees whose emails are not missing
SELECT *
FROM employees
WHERE NOT email IS NULL;

-- Select all employees who make between 35k and 50k
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE salary BETWEEN 35000 AND 50000;

-- ORDER BY, LIMIT, DISTINCT, renaming columns
-- Order by salary ascending
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary ASC;

-- Order by salary descending
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- Top 10 highest paid employees
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- Return all unique coffee shop IDs
SELECT DISTINCT coffeeshop_id
FROM employees;

-- Return all unique countries
SELECT DISTINCT country
FROM locations;

-- Renaming columns
SELECT
	email, email AS email_address,
	hire_date, hire_date AS date_joined,
	salary, salary AS pay
FROM employees;

-- EXTRACT
SELECT
	hire_date AS date,
	EXTRACT(YEAR FROM hire_date) AS year,
	EXTRACT(MONTH FROM hire_date) AS month,
	EXTRACT(DAY FROM hire_date) AS day
FROM employees;

-- UPPER, LOWER, LENGTH, TRIM
-- Uppercase first and last names
SELECT first_name, UPPER(first_name) AS upper_first_name, last_name, UPPER(last_name) AS upper_last_name
FROM employees;

-- Lowercase first and last names
SELECT first_name, LOWER(first_name) AS lower_first_name, last_name, LOWER(last_name) AS lower_last_name
FROM employees;

-- Return the email and the length of emails
SELECT email, LENGTH(email) AS length_of_email
FROM employees;

-- Trim
SELECT
    LENGTH('     HELLO     ') AS hello_with_spaces,
LENGTH('HELLO') AS hello_no_spaces,
    LENGTH(TRIM('     HELLO     ')) AS hello_trimmed;

-- Concatenation, boolean expressions, wildcards
-- Concatenate first and last name to create full name
SELECT first_name, last_name, first_name || ' ' || last_name AS full_name
FROM employees;

-- Concatenate columns to create a sentence
SELECT first_name || ' ' || last_name || ' earns $' || salary AS full_sentence
FROM employees;

-- If the person makes less than 50k, then true, otherwise false
SELECT first_name || ' ' || last_name AS full_name,
	(salary < 50000) AS less_than_50k
FROM employees;

-- If the person is a female and makes less than 50k, then true, otherwise false
SELECT first_name || ' ' || last_name AS full_name,
	(salary < 50000 AND gender = 'F') AS less_than_50k_and_female
FROM employees;

-- If email has '.com', then true, otherwise false
SELECT email, (email like '%.com%') AS has_dotcom
FROM employees

-- Return only government employees
SELECT first_name || ' ' || last_name AS full_name, email AS gov_email
FROM employees
WHERE email like '%.gov%';

-- Substring, position, coalesce
-- Get the email from the 5th character
SELECT email, SUBSTRING(email FROM 5)
FROM employees;

-- Find the position of '@' in the email
SELECT email, POSITION('@' IN email)
FROM employees;

-- Substring and position to find the email client
SELECT email, SUBSTRING(email FROM POSITION('@' IN email))
FROM employees;

-- Coalesce to fill missing emails with custom values
SELECT email, COALESCE(email, 'No email provided')
FROM employees;

-- MIN, MAX, AVG, SUM, COUNT
-- Select minimum salary
SELECT MIN(salary) AS min_salary
FROM employees;

-- Select maximum salary
SELECT MAX(salary) AS max_salary
FROM employees;

-- Select difference between minimum and maximum salary
SELECT MAX(salary) - MIN(salary) AS difference
FROM employees;

-- Select the average salary
SELECT AVG(salary) AS avg_salary
FROM employees;

-- Sum up the salaries
SELECT SUM(salary) AS total_salary
FROM employees;

-- Count the number of entries
SELECT COUNT(*)
FROM employees;

SELECT COUNT(salary)
FROM employees;

SELECT COUNT(email)
FROM employees;

-- GROUP BY, HAVING
-- Return the number of employees for each coffeeshop
SELECT coffeeshop_id, COUNT(employee_id) AS num_of_employees
FROM employees
GROUP BY coffeeshop_id;

-- Return the total salaries for each coffeeshop
SELECT coffeeshop_id, SUM(salary) AS total_salaries
FROM employees
GROUP BY coffeeshop_id;

-- Return the number of employees, the avg, min, max, and total salaries for each coffeeshop
SELECT 
	COUNT(employee_id) AS num_of_employee,
	ROUND(AVG(salary), 0) AS avg_salary,
	MIN(salary) AS min_salary,
	MAX(salary) AS max_salary,
	SUM(salary) AS total_salaries
FROM employees
GROUP BY coffeeshop_id
ORDER BY num_of_employee DESC;

-- After group by, return only the coffeeshops with more than 200 employees
SELECT coffeeshop_id, COUNT(employee_id) AS num_of_employees
FROM employees
GROUP BY coffeeshop_id
HAVING COUNT(employee_id) > 200
ORDER BY num_of_employees DESC;

-- After group by, return only the coffeeshops with a minimum salary of less than 10k
SELECT coffeeshop_id, SUM(salary) AS total_salary
FROM employees
GROUP BY coffeeshop_id
HAVING MIN(salary) > 10000
ORDER BY total_salary DESC;

-- CASE, CASE with GROUP BY, and CASE for transposing data
-- If pay is less than 50k, then low pay, otherwise high pay
SELECT employee_id, first_name || ' ' || last_name AS full_name,
	CASE 	
		WHEN salary < 50000 THEN 'low pay'
		WHEN salary >= 50000 THEN 'high pay'
		ELSE 'no pay'
	END AS pay_category
FROM employees
ORDER BY  salary DESC;

-- If pay is less than 20k, then low pay; if between 20k-50k inclusive, then medium pay; if over 50k, then high pay
SELECT employee_id, first_name || ' ' || last_name AS full_name,
	CASE 	
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
		ELSE 'no pay'
	END AS pay_category
FROM employees
ORDER BY salary DESC;

-- Return the count of employees in each pay category
SELECT a.pay_category, COUNT(*)
FROM(
	SELECT employee_id, first_name || ' ' || last_name AS full_name,
		CASE 	
			WHEN salary < 20000 THEN 'low pay'
			WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
			WHEN salary > 50000 THEN 'high pay'
			ELSE 'no pay'
		END AS pay_category
	FROM employees
	ORDER BY salary DESC
)a
GROUP BY a.pay_category;

-- Transpose above
SELECT
	SUM(CASE WHEN salary < 20000 THEN 1 ELSE 0 END) AS low_pay,
	SUM(CASE WHEN salary BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS medium_pay,
	SUM(CASE WHEN salary > 50000 THEN 1 ELSE 0 END) AS high_pay
FROM employees;

-- JOIN
-- Inserting values just for JOIN exercises
INSERT INTO locations VALUES (4, 'Paris', 'France');
INSERT INTO shops VALUES (6, 'Happy Brew', NULL);

-- "INNER JOIN" same as just 'JOIN'
SELECT s.coffeeshop_name, l.city, l.country
FROM(
	shops s INNER JOIN locations l ON s.city_id = l.city_id
);

-- LFET JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM(
	shops s LEFT JOIN locations l ON s.city_id = l.city_id
);

-- RIGHT JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM(
	shops s RIGHT JOIN locations l ON s.city_id = l.city_id
);

-- FULL OUTER JOIN
SELECT s.coffeeshop_name, l.city, l.country
FROM(
	shops s FULL OUTER JOIN locations l ON s.city_id = l.city_id
);

-- Delete the values we created just for the JOIN exercises
DELETE FROM locations WHERE city_id = 4;
DELETE FROM shops WHERE coffeeshop_id = 6;

-- UNION (to stack data on top of each other)
-- Return all cities and countries
SELECT city FROM locations
UNION
SELECT country FROM locations;

-- UNION removes duplicates
SELECT country FROM locations
UNION
SELECT country FROM locations;

-- UNION ALL keeps duplicates
SELECT country FROM locations
UNION ALL
SELECT country FROM locations;

-- Return all coffee shop names, cities and countries
SELECT coffeeshop_name FROM shops
UNION
SELECT city FROM locations
UNION
SELECT country FROM locations;

-- Subqueries
-- Basic subqueries with subqueries in the FROM clause
SELECT a.employee_id,
	a.first_name,
	a.last_name,
	a.coffeeshop_id
FROM (
	SELECT *
	FROM employees
	where coffeeshop_id IN (3,4)
) a;

-- Basic subqueries with subqueries in the SELECT clause
SELECT
	first_name, 
	last_name, 
	salary,
	(
		SELECT MAX(salary)
		FROM employees
		LIMIT 1
	) max_sal
FROM employees;

-- Subqueries in the WHERE clause
-- Return all US coffee shops
SELECT *
FROM shops
WHERE city_id IN (
	SELECT city_id
	FROM locations
	WHERE country = 'United States'
);

-- Return all employees who work in US coffee shops
SELECT *
FROM employees
WHERE coffeeshop_id IN (
	SELECT coffeeshop_id
	FROM shops
	WHERE city_id IN (
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);

-- Return all employees who make over 35k and work in US coffee shops
SELECT *
FROM employees
WHERE salary > 35000 AND coffeeshop_id IN (
	SELECT coffeeshop_id
	FROM shops
	WHERE city_id IN (
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);

-- 30 day moving total pay
-- The inner query calculates the total salary of employees that were hired within the '30-day' period before the hire_date of the current employee 
SELECT
	hire_date,
	salary,
	(
		SELECT SUM(salary)
		FROM employees e2
		WHERE e2.hire_date BETWEEN e1.hire_date - 30 AND e1.hire_date
	) AS pay_pattern
FROM employees e1
ORDER BY hire_date;