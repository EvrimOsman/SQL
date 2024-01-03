--------------------------------DAY----------------------------------------------
----------------------------GROUP BY-----------------------------------


CREATE TABLE new_workers (
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20),
  number_of_employees numeric(5)
	
);

INSERT INTO new_workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM', 34500);
INSERT INTO new_workers VALUES(456789012, 'Veli Han', 'Arizona', 4000, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE', 45500);
INSERT INTO new_workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM', 23700);
INSERT INTO new_workers VALUES(567890123, 'Yusuf Arturk', 'Washington', 8000, 'APPLE', 45500);
INSERT INTO new_workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT', 60000);
INSERT INTO new_workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE', 90000);
INSERT INTO new_workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM', 23700);
INSERT INTO new_workers VALUES(123456710, 'Ali Can', 'Pennsylvania', 5000, 'IBM', 23700);


-- Find total salary per employee

SELECT name, SUM(salary) FROM new_workers GROUP BY name;

-- Find number of employees per state and order them in Descending order

SELECT state, SUM(number_of_employees) AS total_employees
FROM new_workers
GROUP BY state 
ORDER BY total_employees DESC;

-- Find total number of employees per company who earn more than 3000

SELECT company, SUM(number_of_employees) AS total_employees_per_company
FROM new_workers
WHERE salary > 3000  -- WHERE condition can NOT be used after GROUP BY 
GROUP BY company; 


-- Find max and min, salary for each company

SELECT company, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM new_workers
GROUP BY company;

-- Find the total salary for each employee (named) with a total salary value above 4000

SELECT name, SUM(salary)
FROM new_workers
WHERE salary>4000 -- WHERE condition filters the employee on the basis of single salary 
GROUP BY name;

-- BUt we want to filter our data AFTER calculating total salary .. so that's why we will use HAVING CLAUSE 

SELECT name, SUM(salary)
FROM new_workers
GROUP BY name
HAVING SUM(salary) > 4000;


-- HAVING CLAUSE is used to filter the result of AGGREGATE values, it allows to filter GROUPED data, 
-- making it more specific which group should be added. 

-- Find the total number of employees for each state that has more than 10,000 SELECT state, SUM(number_of_employees)
SELECT state, SUM(number_of_employees) AS total_employees
FROM new_workers
GROUP BY state
HAVING SUM(number_of_employees) > 10000

-- Both WHERE condition and HAVING clause are used to filter the data
-- DIFFERENCE: WHERE filters the data before grouping, HAVING Clause filters that data after GROUPING
-- HAVING clause works with AGGREGATE FUNCTIONS ONLY

-- Find the minimum salary values that are above 2000 for each company 

SELECT company, MIN(salary) AS min_salary
FROM new_workers
GROUP BY company
HAVING MIN(salary) > 2000

-- Find the maximum salary values that are above 7000 for each company 

SELECT company, MAX(salary) AS max_salary
FROM new_workers
GROUP BY company
HAVING MAX(salary) > 7000


SELECT * FROM new_workers;

---------------UNION, UNION ALL, INTERSECT, EXCEPT--------------------


CREATE TABLE alice_books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100)
);


INSERT INTO alice_books (book_id, book_title)
VALUES
    (1, 'The Great Gatsby'),
    (2, 'To Kill a Mockingbird'),
    (3, 'Pride and Prejudice'),
    (4, 'Jane Eyre'),
    (5, 'Animal Farm');



SELECT * FROM alice_books;


CREATE TABLE bob_books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(100)
);

INSERT INTO bob_books (book_id, book_title)
VALUES
    (2, 'To Kill a Mockingbird'),
    (4, '1984'),
    (5, 'The Catcher in the Rye'),
    (8, 'Animal Farm');

SELECT * FROM bob_books;


-- Find the list of books tha Alice has read
SELECT book_title
FROM alice_books


-- Find the list of books tha Bob has read

SELECT book_title
FROM bob_books

-- Create a list of all books read by Alice and Bob (without duplicates)

SELECT book_title
FROM alice_books

UNION

SELECT book_title
FROM bob_books;

-- Create a list of workers from new_workers  and workers tables

SELECT name AS workers_names
FROM new_workers

UNION 

SELECT worker_name
FROM workers

UNION 

SELECT name
FROM employees


----- UNION OPERATOR ------
-- 1. It is used to combine or unite the RESULT of 2 or more queries
-- 2. It returns UNIQUE records only (repeated values are returned only once)
-- 3. Data type of the columns should be SAME; number of  columns should be SAME; order of the columns should be SAME
-- 4. The names of the columns can be differrent as long as the data type is SAME
-- 5. The columns can come from different tables

-- Create a list of all books read by Alice and Bob (WITH duplicates)

SELECT book_title
FROM alice_books

UNION ALL

SELECT book_title
FROM bob_books;


----- INTERSECT OPERATOR ------
-- 1. It is used to combine or unite the RESULT of 2 or more queries
-- 2. It returns COMMON output of the 2 queries 
-- 3. It returns UNIQUE values
-- 4. Data type of the columns should be SAME; number of  columns should be SAME; order of the columns should be SAME
-- 5. The names of the columns can be differrent as long as the data type is SAME
-- 6. The columns can come from different tables


-- Create a list of all the books read by Alice and Bob both (common books or common values)

SELECT book_title
FROM alice_books

INTERSECT

SELECT book_title
FROM bob_books;

-- for more than 2 queries
SELECT name AS workers_names
FROM new_workers

INTERSECT

SELECT worker_name
FROM workers

INTERSECT 

SELECT name
FROM employees


----- EXCEPT (MINUS) OPERATOR ------
-- 1. It is used to combine or unite the RESULT of 2 or more queries
-- 2. It extracts the result of the first query from the other one
-- 3. It returns UNIQUE values

-- Create a list of all the books read by Alice ONLY

SELECT book_title
FROM alice_books

EXCEPT

SELECT book_title
FROM bob_books;


-- for more than 2 queries
SELECT name AS workers_names
FROM new_workers

EXCEPT 

SELECT worker_name
FROM workers

EXCEPT

SELECT name
FROM employees




-- for more than 2 queries  (CHANGE THE POSITION OF QUERIES)
SELECT worker_name
FROM workers

EXCEPT 

SELECT name
FROM new_workers

EXCEPT

SELECT name
FROM employees


SELECT * FROM alice_books;

SELECT * FROM bob_books;

SELECT * FROM new_workers;

SELECT * FROM new_workers;


----------------------------------

CREATE TABLE employees_a (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50)
);
INSERT INTO employees_a (employee_id, employee_name, department)
VALUES
    (1, 'John Smith', 'HR'),
    (2, 'Alice Johnson', 'IT'),
    (3, 'Bob Williams', 'Finance'),
    (4, 'Eva Davis', 'Marketing');
	
	
SELECT * FROM employees_a ;


CREATE TABLE employees_b (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50)
);


INSERT INTO employees_b (employee_id, employee_name, department)
VALUES
    (2, 'Alice Johnson', 'IT'),
    (3, 'Bob Williams', 'Finance'),
    (5, 'Charlie Brown', 'Sales'),
    (6, 'Grace Miller', 'HR');

SELECT * FROM employees_b;

-- Find the distinct list of all employees from both the tables
SELECT employee_name
FROM employees_a
UNION
SELECT employee_name
FROM employees_b

-- Find all rows from both tables (including duplicates) from 'IT' department
SELECT *
FROM employees_a
WHERE department='IT'

UNION ALL

SELECT *
FROM employees_b
WHERE department='IT'

-- Identify the employees who are in both tables and work in 'IT' department
SELECT *
FROM employees_a
WHERE department='IT'

INTERSECT

SELECT *
FROM employees_b
WHERE department='IT'

-- Identify the employees from employees_a table who are not in employees_b table

SELECT *
FROM employees_a
EXCEPT
SELECT *
FROM employees_b

-- To retrieve UNIQUE data
SELECT DISTINCT name FROM new_workers;


------------ STRING METHODS in SQL------------
-- Retrieve names and length of name from new_workers table
SELECT name, LENGTH (name) AS length_of_name
FROM new_workers;
-- Display names in Upper cases and states in lower case
SELECT UPPER(name) AS name_of_worker , LOWER(state) AS name_of_state
FROM new_workers;
-- Display only first letter of company as capital
SELECT INITCAP(company)
FROM new_workers;
-- Display state and first 2 characters of the its name
SELECT state, SUBSTRING(state,2)
FROM new_workers;

--To remove spaces from the String, use TRIM
SELECT TRIM (state)
FROM new_workers;

SELECT * FROM new_workers;


-----------------------------------ALTER---------------------------------
-- ALTER TABLE -- the key command to change the structure of the table (DDL)
-- ADD COLUMN  => to add columns to existing table
-- DROP Cloumn => to drop columns from th eexisting table
-- RENAME COLUMN => to change the name of the cloumn in existing table
-- RENAME ... TO  => to change the name of existing table

-- Add a new column 'age' with INT data type to new_workers table
ALTER TABLE new_workers
ADD COLUMN age INT; 
-- Add new boolean column as 'remote' to new_workers table with default value as TRUE
ALTER TABLE new_workers
ADD COLUMN remote BOOLEAN DEFAULT TRUE;
-- Delete a cloumn from new_workers table
ALTER TABLE new_workers
DROP COLUMN age;
-- Change the data type of 'salary' column to REAL
ALTER TABLE new_workers
ALTER COLUMN salary TYPE REAL;
-- Change the column name from 'salary' to 'income'
ALTER TABLE new_workers
RENAME COLUMN salary TO income;
-- Change 'income' column data type to VARCHAR 
ALTER TABLE new_workers
ALTER COLUMN income TYPE VARCHAR (30);
-- Change 'income' column data type back to REAL  
ALTER TABLE new_workers
ALTER COLUMN income TYPE REAL USING income::real;  -- USING income::real will check if there are numeric values ONLY in that column, 
-- it will change the data type of that column 
-- Change the name of the table 
ALTER TABLE new_workers
RENAME TO remote_workers;
SELECT * FROM new_workers;  -- This doesn't work anymore because the table is renamed
SELECT * FROM remote_workers;


