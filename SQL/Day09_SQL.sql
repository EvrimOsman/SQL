------------------- Day09 --------------


CREATE TABLE random (
	
	id VARCHAR (10),
	letters VARCHAR (15)
); 

INSERT INTO random VALUES ('3'), ('5'), ('12'), ('16'), ('20');

SELECT * FROM random;

ALTER TABLE random
ALTER COLUMN id TYPE REAL;  -- error => won't cast it automatically


ALTER TABLE random
ALTER COLUMN id TYPE REAL USING id::real;  -- This will work and change the data type after checking the internal data 
-- and making sure that it is all numeric values



------------------------------------


CREATE TABLE random2 (
	
	id VARCHAR (10),
	letters VARCHAR (15)
); 

INSERT INTO random2 VALUES ('3'), ('5d'), ('A'), ('A5'), ('m');

SELECT * FROM random2;

ALTER TABLE random2
ALTER COLUMN id TYPE REAL;  -- error => won't cast it automatically


ALTER TABLE random2
ALTER COLUMN id TYPE REAL USING id::real;  -- error => it won't cast because id column has numbers as well letters 


-------------------------------------------

-- How to modify ( add / change CONSTRAINTS, SIZE) of the filed/column
-- This modification can BE TRICKY  --- Be careful about the existing data / values (if there are any)



CREATE TABLE it_employees (  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  company VARCHAR(20),
  number_of_employees numeric(5)
	
);


INSERT INTO it_employees VALUES(123456789, 'John Walker', 'Florida', 'IBM', 34500);
INSERT INTO it_employees VALUES(456789012, 'Veli Han', 'Arizona', 'GOOGLE', 90000);
INSERT INTO it_employees VALUES(234567890, 'Brad Pitt', 'Florida', 'APPLE', 45500);
INSERT INTO it_employees VALUES(345678901, 'Eddie Murphy', 'Texas', 'IBM', 23700);
INSERT INTO it_employees VALUES(567890123, 'Yusuf Arturk', 'Washington', 'APPLE', 45500);
INSERT INTO it_employees VALUES(589670123, 'Tuba Omar', 'Texas', 'MICROSOFT', 60000);
INSERT INTO it_employees VALUES(476589012, 'Brad Pitt', 'Texas', 'GOOGLE', 90000);
INSERT INTO it_employees VALUES(623456710, 'Mark Stone', 'Pennsylvania', 'IBM', 23700);
INSERT INTO it_employees VALUES(123456710, 'Ali Can', 'Pennsylvania', 'IBM', 25700);


SELECT * FROM it_employees; 

-- Add a column name_of_ceo with data type VARCHAR 

ALTER TABLE it_employees
ADD COLUMN name_of_ceo VARCHAR (20);

-- Add CONSTARINT 'NOT NULL'

ALTER TABLE it_employees
ALTER COLUMN name_of_ceo SET NOT NULL;  -- error => this table has 9 records with null values for name_of_ceo column
-- so it can not take this constraint 

-- Either add values one by one in to name_of_ceo column and then apply NOT NULL CONSTRAINT 
UPDATE it_employees
SET name_of_ceo = ''
WHERE company = 'GOOGLE';


-- OR DROP THE TABLE
DROP TABLE it_employees;

-- Create the table again but DO NOT add values as yet

CREATE TABLE it_employees (  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  company VARCHAR(20),
  number_of_employees numeric(5)
	
);

-- NOW Add a column name_of_ceo with data type VARCHAR 

ALTER TABLE it_employees
ADD COLUMN name_of_ceo VARCHAR (20);

-- NOW Add CONSTARINT 'NOT NULL'

ALTER TABLE it_employees
ALTER COLUMN name_of_ceo SET NOT NULL; 

-- Now add the values 

INSERT INTO it_employees VALUES(123456789, 'John Walker', 'Florida', 'IBM', 34500, 'Arvind Krishna');
INSERT INTO it_employees VALUES(456789012, 'Veli Han', 'Arizona', 'GOOGLE', 90000, 'Sundar Pichai');
INSERT INTO it_employees VALUES(234567890, 'Brad Pitt', 'Florida', 'APPLE', 45500, 'Tim Cook');
INSERT INTO it_employees VALUES(345678901, 'Eddie Murphy', 'Texas', 'IBM', 23700, 'Arvind Krishna');
INSERT INTO it_employees VALUES(567890123, 'Yusuf Arturk', 'Washington', 'APPLE', 45500, 'Tim Cook');
INSERT INTO it_employees VALUES(589670123, 'Tuba Omar', 'Texas', 'MICROSOFT', 60000, 'Satya Nadella');
INSERT INTO it_employees VALUES(476589012, 'Brad Pitt', 'Texas', 'GOOGLE', 90000, 'Sundar Pichai');
INSERT INTO it_employees VALUES(623456710, 'Mark Stone', 'Pennsylvania', 'IBM', 23700, 'Arvind Krishna');
INSERT INTO it_employees VALUES(123456710, 'Ali Can', 'Pennsylvania', 'IBM', 25700, 'Arvind Krishna');



-- Add column employee_salary to the table

ALTER TABLE it_employees
ADD COLUMN employee_salary NUMERIC;

-- Add CONSTRAINT 
ALTER TABLE it_employees
ALTER COLUMN employee_salary SET NOT NULL;  -- error

-- Add CONSTRAINT NOT NULL to number_of_employees 

ALTER TABLE it_employees
ALTER COLUMN number_of_employees SET NOT NULL;  -- shows no error because no cell is empty in this column 


-- Add a new record for the company 'ORACLE'
INSERT INTO it_employees (company) VALUES ('ORACLE');  -- error => because number_of_employees column can not be left null now 


INSERT INTO it_employees (company, number_of_employees ) VALUES ('ORACLE', 35000); -- error => because name_of_ceo column can not be left null now 


INSERT INTO it_employees (company, number_of_employees, name_of_ceo ) VALUES ('ORACLE', 35000, 'Safra Catz'); -- ADDED :)


-- ADD UNIQUE CONSTRAINT to id column 
ALTER TABLE it_employees
ADD CONSTRAINT id_unique  UNIQUE (id);  -- it won't show error because UNIQUE key can accept one null value 

-- Add id value where company is 'ORACLE'

UPDATE it_employees 
SET id = '123456789'
WHERE company = 'ORACLE';  -- ERROR => now id columnn can not accept duplicate value as UNIQUE CONSTRAINT has been added.


UPDATE it_employees 
SET id = '451236789'
WHERE company = 'ORACLE';

-- Add a new record respecting all updated constraints that we have added to the table 

INSERT INTO it_employees (id, company, number_of_employees, name_of_ceo ) VALUES ('987654321', 'SAMSUNG', 40000, 'Kyung Kye Hyun'); -- ADDED :)

SELECT * FROM it_employees; 


---------------------DATA TYPE / SIZE---------------
-- Size means number of charcaters allowed inside the fields 

SELECT * FROM employees1; 

--Add a new column employee_address to the table
ALTER TABLE employees1
ADD COLUMN employee_address CHAR (5);

-- add a new employee
INSERT INTO employees1 VALUES (20, 'Omar', 'Amhet', 'New york, NY, US');  -- ERROR:  value too long for type character(5)

-- We need to increase the size of the column

ALTER TABLE employees1
ALTER COLUMN employee_address TYPE VARCHAR (30); 


INSERT INTO employees1 VALUES (20, 'Omar', 'Amhet', '32 New york, NY, US'); 

ALTER TABLE employees1
ALTER COLUMN employee_address TYPE CHAR (15); -- error => value longer than 15 charcaters already exists, so we can't reduce the size of this field to 15

-- NOTE: Whenever we modify any field on the table, the size should be greater than the existing size 


--------------------------JOINS----------------------------- 

-- 1. INNER JOIN -- it returns the common data between the two tables 
-- 2. LEFT JOIN -- it retruns ALL data from the LEFT table / first table (the table that is mentioned first in the query)
-- 3. RIGHT JOIN -- it retruns ALL data from the right table / second table (the table that is mentioned second in the query)
-- 4. FULL JOIN --  it retruns ALL data from both tables
-- 5. SELF JOIN --  works with SINGLE table; joins with itself, and returns data accroding to the given condition

-- NOTE: JOINS are used to combine / filter the data between the TABLES when the given condition is met 
-- Difference between UNION/UNION ALL and JOINS 
-- JOINS combine / filter the data between the TABLES; UNION/UNION ALL combine / filter the result of 2 or more queries 

CREATE TABLE my_companies(
  company_id CHAR(3),
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;

CREATE TABLE orders(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);

INSERT INTO orders VALUES(101, 11, '17-Apr-2023');
INSERT INTO orders VALUES(102, 22, '25-Nov-2023');
INSERT INTO orders VALUES(103, 33, '19-Jan-2023');
INSERT INTO orders VALUES(104, 44, '20-Aug-2023');
INSERT INTO orders VALUES(105, 55, '21-Oct-2023');


SELECT * FROM orders;

-- SELECT company name, order id, and order date for common companies
-- INNER JOIN -- it returns the common data between the two tables 

SELECT company_name, order_id, order_date
FROM my_companies INNER JOIN orders
ON my_companies.company_id = orders.company_id;

-- Return ALL data from LEFT table
-- LEFT JOIN will guaranttee that all data from first table is returned
SELECT company_name, order_id, order_date
FROM my_companies LEFT JOIN orders
ON my_companies.company_id = orders.company_id;


-- Return ALL data from RIGHT table
-- RIGHT JOIN will guaranttee that all data from second table is returned
SELECT company_name, order_id, order_date
FROM my_companies RIGHT JOIN orders
ON my_companies.company_id = orders.company_id;



-- Return FULL data from both tables 
-- FULL JOIN returns ALL data from both tables
SELECT company_name, order_id, order_date
FROM my_companies FULL JOIN orders
ON my_companies.company_id = orders.company_id;



--using ALIAS for table names 
SELECT company_name, order_id, order_date
FROM my_companies mc FULL JOIN orders o
ON mc.company_id = o.company_id;


SELECT * FROM orders;
SELECT * FROM my_companies;




-- SELF JOIN -- 

CREATE TABLE jobs(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(40),
  manager_id CHAR(2)
);

INSERT INTO jobs VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO jobs VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO jobs VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO jobs VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM jobs;

-- Find the name of the manager of each worker

SELECT j1.name AS employee_name , j2.name AS manager_name 
FROM jobs j1 SELF JOIN jobs j2
ON j1.id = j2.manager_id;  -- ERROR => PSTGRE SQL doesn't accept SELF JOIN keyword -- ORacle SQL accepts SELF JOIN keyword


-- For POSTGRE SQL 

SELECT j1.name AS employee_name , j2.name AS manager_name 
FROM jobs j1 INNER JOIN jobs j2
ON j1.id = j2.manager_id; 


SELECT * FROM jobs;

-- For POSTGRE SQL 

SELECT j2.name AS employee_name , j1.name AS manager_name 
FROM jobs j1 INNER JOIN jobs j2
ON j1.id = j2.manager_id; 

-- OR
SELECT j1.name AS employee_name , j2.name AS manager_name 
FROM jobs j1 INNER JOIN jobs j2
ON j1.manager_id = j2.id; 


-----------FUNCTIONS---------------
-- Functions are created to perform some tasks faster and easier
-- Functions are created to perform CRUD operations 
-- 2 types of functions
-- Fubctions that return data (we have to declare retrun data type => like in JAVA String, int )
-- Functions that don't return data (we have to declare void like in JAVA ) => these functions are called PROCEDURE
-- Mostly used by Developers (Advanced SQL)


----------------Function with void (Procedure)

CREATE OR REPLACE FUNCTION concatenated_chars (input_string VARCHAR)
RETURNS VARCHAR AS
$$ -- method body ( like {} in JAVA  )
DECLARE
	first_char CHAR;
	last_char CHAR;
BEGIN
    first_char := substr(input_string, 1,1);
	last_char := substr(input_string, LENGTH(input_string));
RETURN
-- Conacatenated result
 first_char || last_char;
END
$$ language plpgsql;  --  plpgsql pl=> procedural , pgsql => POSTGRESQL

SELECT concatenated_chars('Ali');

---------------------------Addition Function-------------------------
CREATE OR REPLACE FUNCTION addF(x NUMERIC, y NUMERIC)   -- addF => addFunction
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN x+y;
END
$$

-- How to call the function 
Select addF(4, 6) AS addition;

Select * from addF(4, 6) AS addition; --- both syntax work

-------------LOOP-------------------------------

CREATE OR REPLACE FUNCTION sum_numbers_using_loop(start_num integer)
RETURNS integer AS
$$
DECLARE
   sum_result integer := 0;
BEGIN
   WHILE start_num <= 100 LOOP
       sum_result := sum_result + start_num;
       start_num := start_num + 1;
   END LOOP;
   RETURN sum_result;
END;
$$
LANGUAGE plpgsql;

SELECT sum_numbers_using_loop(50);