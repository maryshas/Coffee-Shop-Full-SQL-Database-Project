# Coffee Shop Full SQL Database Project
Using PostgreSQL, I designed and created a relational database with four core tables: employees, suppliers, locations, and shops. I populated the database with realistic sample data and then developed a series of SQL queries to uncover business insights. 

These queries applied a wide range of SQL techniques, including filtering (WHERE), joins, aggregation (GROUP BY, HAVING), sorting (ORDER BY), string manipulation (SUBSTRING, POSITION), conditional logic (CASE), and set operations (UNION).

A few example of SQL queries from this project:
1. Employee Distribution by Shop
   Query: Count the number of employees working in each coffee shop.
   Insight: Shows which shops are over- or under-staffed.

   SELECT s.shop_name, COUNT(e.employee_id) AS employee_count
   FROM shops s
   JOIN employees e ON s.coffeeshop_id = e.coffeeshop_id
   GROUP BY s.shop_name;

2. Top Suppliers by Bean Type
   Query: List all suppliers and the types of coffee beans they provide.
   Insight: Helps identify supplier diversity and sourcing options.

   SELECT supplier_name, bean_type, COUNT(*) AS shops_supplied
   FROM suppliers
   GROUP BY supplier_name, bean_type
   ORDER BY shops_supplied DESC;

3. Employees by City
   Query: Find out how many employees are located in each city.
   Insight: Useful for regional workforce planning.

   SELECT l.city, COUNT(e.employee_id) AS employees_in_city
   FROM locations l
   JOIN shops s ON l.city_id = s.city_id
   JOIN employees e ON s.coffeeshop_id = e.coffeeshop_id
   GROUP BY l.city;

4. Average Employee Salary by Shop
   Query: Calculate the average salary of employees per coffee shop.
   Insight: Highlights salary differences across locations.

   SELECT s.shop_name, AVG(e.salary) AS avg_salary
   FROM shops s
   JOIN employees e ON s.coffeeshop_id = e.coffeeshop_id
   GROUP BY s.shop_name;

5. Recently Hired Employees
   Query: Get a list of employees hired after 2020.
   Insight: Identifies new hires and recent workforce growth.

   SELECT first_name, last_name, hire_date, shop_name
   FROM employees e
   JOIN shops s ON e.coffeeshop_id = s.coffeeshop_id
   WHERE hire_date >= '2020-01-01'
   ORDER BY hire_date DESC;
