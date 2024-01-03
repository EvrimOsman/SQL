----------Day 06-----------
-------Subqueries Across the Tables---------

CREATE TABLE company_employees (
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);


INSERT INTO company_employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO company_employees VALUES(328734001, 'Neena Omar', 'Ohio', 6000, 'GOOGLE');
INSERT INTO company_employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO company_employees VALUES(345678901, 'Ali Can', 'Texas', 3000, 'IBM');
INSERT INTO company_employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO company_employees VALUES(458977012, 'Veli Han', 'Arizona', 4000, 'GOOGLE');
INSERT INTO company_employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO company_employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO company_employees VALUES(123456710, 'Aygul Aydem', 'Pennsylvania', 2500, 'IBM');
INSERT INTO company_employees VALUES(678901245, 'Yusuf Arturk', 'Washington', 9000, 'APPLE');

SELECT * FROM company_employees;


CREATE TABLE companies (
  company_id CHAR(9),
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);


SELECT * FROM companies;


-- Find company name and employees where company has more than 15000 employees

SELECT name, company
FROM company_employees
WHERE company = 'GOOGLE';

-- Above code returns the employees names from the same table.
-- This query doesn't fulfill this condition => where company has more than 15000 employees 
-- That's why we have to get the data from across the other table using SUBQUERY and IN operator

SELECT name, company
FROM company_employees
WHERE company IN (SELECT company FROM companies WHERE number_of_employees > 15000)


-- Find the company names and company ids where state is 'Texas'
SELECT company_id, company
FROM companies
WHERE state = 'Texas'; -- This will show error because state field doesn't exist in companies

-- Using SUBQUERY Across the table, we will find state field
SELECT company_id, company
FROM companies
WHERE company IN (SELECT company FROM company_employees WHERE state = 'Texas');


-- Find employee names and their states whose company id is greater that 102

SELECT name, state
FROM company_employees
WHERE company IN
		(SELECT company
		FROM companies
		WHERE company_id > '102'
		);



-- find the company name, number of employees and average salary for every company

SELECT company, number_of_employees, 
(SELECT AVG(salary)
FROM company_employees 
WHERE company_employees.company = companies.company) AS avg_salary
FROM companies


SELECT * FROM company_employees;

-- find the name of the componies, company ids, min, and max salaries per company


SELECT 
company, 
company_id, 
(SELECT MIN(salary) 
FROM company_employees
WHERE companies.company = company_employees.company) AS min_salary,
(SELECT MAX(salary) 
FROM company_employees
WHERE companies.company = company_employees.company) AS max_salary
FROM companies;

------------------------------------------------------------------------------------------------

CREATE TABLE people (
ssn INT,
name VARCHAR(30),
address VARCHAR(50)
);


INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Olivia Brooks', 'Arizona');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');

INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, address) VALUES(459012678, 'Ohio');

INSERT INTO people(ssn, name) VALUES('447890123', 'California');
INSERT INTO people(ssn, name) VALUES('440123789', 'Washington');
INSERT INTO people(ssn, name) VALUES('901234478', 'Texas');
INSERT INTO people(name, address) VALUES('Emily Simpson', 'Oklahama');

-------IS NULL CONDITION---------

--Update record where SSN is 345678901 to 348901567
UPDATE people
SET ssn = 348901567
WHERE ssn = 345678901;


--Update all null names to 'No Name'

UPDATE people
SET name = 'No Name'
WHERE name IS NULL;


--Update all null address to 'No Address'
UPDATE people 
SET address = 'No Address'
WHERE address IS NULL;

-- Delete records where ssn is null

DELETE 
FROM people
WHERE ssn IS NULL;

--------------IS NOT NULL----------

DELETE 
FROM people
WHERE address IS NOT NULL;  -- removes all data from the table as at this point, no field has any NULL value 


SELECT * FROM people;

DELETE FROM people; -- deletes all data from the table BUT it's revokable
TRUNCATE TABLE people;  -- deletes all data from the table BUT it's NOT revokable
DROP TABLE people; -- deletes all data AS WELL AS structure of the table from the Database


-----------LIKE Operator with WILDCARDS-------- 


-- LIKE Operator is used with WILDCARDS
-- WILDCARDS are useful expressions that we use in search operations in SQL
-- They're used for STRING data type
-- There are 2 main characters used as WILDCARDS
-- 1. % => percentage sign => represents zero or more characters
-- 2. _ => underscore sign => reprsents 1 single character

CREATE TABLE email_list (
    email_id INT PRIMARY KEY,
    email_address VARCHAR(255)
);


INSERT INTO email_list (email_id , email_address)
VALUES
    (1, 'alice@gmail.com'),
    (2, 'bob@example.com'),
    (3, 'charlie@hotmail.com'),
    (4, 'dave@gmail.com'),
    (5, 'eve@yahoo.com'),
    (6, 'frank@gmail.com'),
    (7, 'grace@example.com'),
	(8, 'john@outlook.com'),
    (9, 'emily@gmail.com'),
	(10, 'ava@yahoo.com');

SELECT * FROM email_list;

-- Return all records that end with '@gmail.com'

SELECT *
FROM email_list
WHERE email_address LIKE '%@gmail.com';

-- Return all records that has 'john' in the beginning

SELECT *
FROM email_list
WHERE email_address LIKE 'john%'; 


-- Return all records that has 'john' anywhere

SELECT *
FROM email_list
WHERE email_address LIKE '%john%'; 


-- Return all records that has 'e' anywhere

SELECT *
FROM email_list
WHERE email_address LIKE '%e%'


-- If we want to look for a character at a specific place, we use '_' underscore WILDCARD

-- Return all records that has 'm' at second place

SELECT *
FROM email_list
WHERE email_address LIKE '_m%';

-- Return all records that has 'k' at 5th place

SELECT *
FROM email_list
WHERE email_address LIKE '____k%';


-- Return all records that has 'g' at the beginning and 'm' in the end

SELECT *
FROM email_list
WHERE email_address LIKE 'g%m';

-- Return all records that has 'x' and 'b' ANYWHERE and in ANY order 

SELECT *
FROM email_list
WHERE email_address LIKE '%x%b%' OR email_address LIKE '%b%x%' 

-- Return all records that has 'r' at 4th positions and 'h' at 9th position

SELECT *
FROM email_list
WHERE email_address LIKE '___r____h%';

-- Return all records that has 'o' as second last character

SELECT *
FROM email_list
WHERE email_address LIKE '%o_';






SELECT * FROM email_list;