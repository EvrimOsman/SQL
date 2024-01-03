----------------DAY 07---------------
SELECT * FROM company_employees;
-- Find employees whose state has second character  as 'e' and fourth charcater as 'n'
SELECT * 
FROM company_employees
WHERE state LIKE '_e_n%';
-- Find employees whose state has 'i' as a third character from the end
SELECT * 
FROM company_employees
WHERE state LIKE '%i__';
-- Find employees whose state has 'e' as a second character and at least has 6 characters
SELECT * 
FROM company_employees
WHERE state LIKE '_e____%';
-- Find employees whose state has 'i' after ANYWHERE of the second character
SELECT * 
FROM company_employees
WHERE state LIKE '__%i%';
SELECT * FROM company_employees;
---------------------------------------------------------------
CREATE TABLE words ( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);
INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'learn', 5);
INSERT INTO words VALUES (1010, 'techpro', 7);
SELECT * FROM words;
-- Find all words that don't end with 't' or 'f'
SELECT * 
FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';
-- Find words that don't have 'a' or 'e' as a second character 
SELECT * 
FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';
-- Find words whose first character is 'h' and second character can be 'o', 'a', 'e' and the last charcater should be 't'
-- 1st way using WILDCARDS
SELECT * 
FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'he%t';
-- 2nd way using REGEX => Regular Expressions
SELECT * 
FROM words
WHERE REGEXP_LIKE (word, 'h[oae](.*)t');   -- original syntax
/*    
------------NOTES ABOUT REGEXP_LIKE CONDITION------------
-- LIKE condition is used for search operations, similarly REGEX is also for search operations
-- LIKE condition has to match the entire data, whereas REGEX are used to search for anywhere in the data 
-- LIKE condition succeeds only if it's pattern matches the entire String; whereas REGEX succeeds if the pattern
matches any where in the String 
-- If we use REGEXP_LIKE, then we must write the column name inside (), otherwise the syntax won't work.
REGEXP_LIKE can be replaced with this sign => ~
-- If we use ~, then we write the name of the column as usual after WHERE condition and REGEX go inside the ''
-- [oae] => any of the given characters
-- [a-e] => all of the given characters from 'a' to 'e' like we used this => [a-zA-Z] in JAVA
-- ^ sign => to declare first character. (when used outside of the []) 
-- ^ sign => to exclude the given characters (when used insdie the [])
-- $ sign => to declare the given character should be last character
-- (.*) is the same as % sign in WILDCARDS
-- (.*) sign => one or more than one characters; also can be used without () like .*
-- (.) sign => single charcater like '_' underscore sign in WILDCARDS; also can be used without () like .
*/
-- By replacing REGEXP_LIKE  with ~ sign 
SELECT * 
FROM words
WHERE word ~ 'h[oae](.*)t'; 
-- Find words whose first character is 'h' and second character can be any character from 'a' to 'f' and 
-- the last charcater should be 't'
-- 1st way: using REGEXP_LIKE Condition
SELECT *
FROM words
WHERE REGEXP_LIKE (word, ('h[a-f](.*)t'));
-- 2nd way: using ~ sign
SELECT *
FROM words
WHERE word ~ 'h[a-f](.*)t'; 
-- Find words whose first charcater can be 'a', 's', 't' or 'y'
SELECT *
FROM words
WHERE word ~ '^[asty](.*)';
-- Find words whose first charcater can NOT be 'a', 's', 't' or 'y'
SELECT *
FROM words
WHERE word ~ '^[^asty](.*)';
-- Find words whose last charcaters are 'm', 'a', or 'o'
SELECT *
FROM words
WHERE word ~ '(.*)[mao]$'
-- Find words which starts with 't' and ends with 'o'
SELECT *
FROM words
WHERE word ~ 't(.*)o'; -- ^ sign is optional here because we are looking for only one charcater to be first character
-- Find words which start with 't' or 's' and ends with 'o'
SELECT *
FROM words
WHERE word ~ '^[ts](.*)o'; -- we must use ^ sign here because we are looking for more than one charcaters to be first character possibly
-- Find words which start from any chracter from 'a' to 't' and 4th character is 'h'
SELECT * 
FROM words
WHERE word ~ '^[a-t](.)(.)h(.*)';
-- OR
SELECT * 
FROM words
WHERE word ~ '^[a-t]..h.*';
SELECT * FROM words;
-----------------------------------
SELECT * FROM company_employees;
-- Find names which don't start with 'B' and doesn't end with 'y' from company_employees table
SELECT *
FROM company_employees
WHERE name ~ '^[^B](.*)[^y]$';
-- Find names which don't start with 'B', 'J', 'A' and doesn't end with 'r' or 't'
SELECT *
FROM company_employees
WHERE name ~ '^[^BJA](.*)[^rt]$';
----------CONCATENATION IN SQL-----------
-- To display multiple columns as single column; joining the data together
-- we use ||''|| sign 
CREATE TABLE employees1 (  
  employee_id numeric(9), 
  employee_first_name VARCHAR(20),
  employee_last_name VARCHAR(20)
); 
INSERT INTO employees1 VALUES(14, 'Chris', 'Tae');
INSERT INTO employees1 VALUES(11, 'John', 'Walker');
INSERT INTO employees1 VALUES(12, 'Amy', 'Star');
INSERT INTO employees1 VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees1 VALUES(15, 'Chris', 'Way');
SELECT * FROM employees1;
-- merge the first name and last name columns
SELECT employee_first_name ||' '|| employee_last_name AS full_name
FROM employees1;
-- merge the first name and last name and id columns
SELECT employee_first_name || ' ' || employee_last_name || ' ' || employee_id AS employee_info
FROM employees1;
------------------------------------------------
------------GROUP BY CLUASE--------------
-- It is used for grouping the related data in one field
-- It's mostly used with AGGREGATE FUNCTIONS
-- WHERE condition (to filter the data) can NOT be used after GROUP BY clause
CREATE TABLE shopping_list (
    item_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    item_name VARCHAR(50),
    price DECIMAL(8, 2)
);
INSERT INTO shopping_list (category, item_name, price)
VALUES
    ('Fruits', 'Apple', 1.50),
    ('Vegetables', 'Tomato', 1.00),
    ('Dairy', 'Milk', 2.25),
    ('Bakery', 'Muffin', 1.50),
    ('Meat', 'Chicken', 5.50),
    ('Vegetables', 'Carrot', 0.75),
    ('Meat', 'Pork', 6.80),
    ('Dairy', 'Cheese', 3.75),
    ('Fruits', 'Banana', 0.99),
    ('Bakery', 'Croissant', 2.00),
    ('Bakery', 'Baguette', 2.20),
    ('Meat', 'Salmon', 9.99),
    ('Fruits', 'Grapes', 2.50),
    ('Vegetables', 'Broccoli', 1.25),
    ('Dairy', 'Butter', 2.50),
    ('Dairy', 'Yogurt', 1.99),
    ('Vegetables', 'Spinach', 1.80),
    ('Fruits', 'Orange', 1.25),
    ('Bakery', 'Bread', 1.80),
    ('Meat', 'Beef', 7.20);
SELECT * FROM shopping_list;
-- Find how much is the total cost of each category
SELECT category, SUM(price) AS total_cost
FROM shopping_list
GROUP BY category;
-- Find average price of each category
SELECT category, ROUND (AVG (price), 3) AS average_price_per_category
FROM shopping_list
GROUP BY category;
-- Find max and min price and total number of items per category
SELECT category, 
MAX(price) AS max_price, 
MIN(price) AS min_price, 
COUNT(item_name) AS total_num_item
FROM shopping_list
GROUP BY category;
SELECT * FROM shopping_list;
-----------------------------------------
-- Find total salary for each employee from company_employees table
SELECT company, SUM(salary) AS total_salary
FROM company_employees
GROUP BY company;
-- Find number of employees per state in descending order (of employee id)
SELECT state, COUNT(id)
FROM company_employees
GROUP BY state
ORDER BY COUNT(id) DESC;
SELECT * FROM company_employees;
