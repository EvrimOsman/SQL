------------DAY 05------------
--------INTERVIEW QUESTION---------
-- Select all data of the worker whose salary is THIRD HIGHEST
-- 2nd HIGHEST
SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary <  (SELECT MAX(worker_salary) FROM workers); -- 2nd Highest salary

-- To get the worker who is earning 2nd highest SALARY
-- 1st way:
-- SQL Subquery

SELECT *
FROM workers
WHERE worker_salary = (SELECT MAX(worker_salary)
                       FROM workers
                       WHERE worker_salary <  (SELECT MAX(worker_salary) FROM workers));

-- 3rd HIGHEST salary
SELECT Max(worker_salary)
FROM workers
WHERE worker_salary < (SELECT MAX(worker_salary)
                       FROM workers
                       WHERE worker_salary <  (SELECT MAX(worker_salary) FROM workers));  -- returns 3rd Highest salary

-- To get the worker who is earning 3rd highest SALARY
-- 1st way:
-- SQL Subquery

SELECT *
FROM workers
WHERE worker_salary = (SELECT Max(worker_salary)
                       FROM workers
                       WHERE worker_salary < (SELECT MAX(worker_salary)
                                              FROM workers
                                              WHERE worker_salary <  (SELECT MAX(worker_salary) FROM workers)));

-- Select all data of the worker whose salary is THIRD LOWEST
-- 1st MIN
SELECT MIN(worker_salary) FROM workers
-- 2nd MIN
SELECT MIN(worker_salary)
FROM workers
WHERE worker_salary > (SELECT MIN(worker_salary) FROM workers)
-- 3rd MIN
SELECT MIN(worker_salary)
FROM workers
WHERE worker_salary > (SELECT MIN(worker_salary)
                       FROM workers
                       WHERE worker_salary > (SELECT MIN(worker_salary) FROM workers));
-- To get the worker who is earning 3rd LOWEST SALARY
-- 1st way
-- SQL Subquery
SELECT *
FROM workers
WHERE worker_salary = (SELECT MIN(worker_salary)
                       FROM workers
                       WHERE worker_salary > (SELECT MIN(worker_salary)
                                              FROM workers
                                              WHERE worker_salary > (SELECT MIN(worker_salary) FROM workers)));
----------ORDER BY CLAUSE------------
-- To get the worker who is earning 2nd highest SALARY
-- 2nd way:
-- By using ORDER BY CLAUSE
SELECT *
FROM workers
ORDER BY worker_salary DESC   -- By default, ORDER BY sorts the fields in ASCENDING ORDER
OFFSET 1 ROW
    FETCH NEXT 1 ROW ONLY
-- To get the worker who is earning 3rd HIGHEST SALARY
-- 2nd way:
SELECT *
FROM workers
ORDER BY worker_salary DESC   -- By default, ORDER BY sorts the fields in ASCENDING ORDER
OFFSET 2 ROW
    FETCH NEXT 1 ROW ONLY
-- To get the worker who is earning 3rd LOWEST SALARY
-- 2nd way
-- By using ORDER BY Clause
SELECT *
FROM workers
ORDER BY worker_salary  -- By default, ORDER BY sorts the fields in ASCENDING ORDER
OFFSET 2 ROW
    FETCH NEXT 1 ROW ONLY;  -- FETCH NEXT ...  ROW limits the records that you want to see
/*
--------- NOTES ---------
Subquery is a UNIVERSAL Language => understood by all databases
ORDER BY - OFFSET is NOT universal => most commonly used in MYSQL, POSTGRE, ORACLE
ORDER BY -- by default works in ASCENDING ORDER for numeric data types,
if we want to change to descending order, we need to add DESC keyword.
If the data types is String,, by default it follows NATURAL ORDER (alphabetical)
*/
SELECT * FROM workers;
------------OPERATORS-------------
CREATE TABLE customers_products (
                                    product_id INT,
                                    customer_name VARCHAR(20),
                                    product_name VARCHAR(20)
);
INSERT INTO customers_products VALUES (10, 'Mark Twain', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark Wilson', 'Mango');
INSERT INTO customers_products VALUES (20, 'John Clark', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy Williams', 'Plum');
INSERT INTO customers_products VALUES (20, 'Mark Donne', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adam Smith', 'Orange');
INSERT INTO customers_products VALUES (40, 'John Evans ', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Anna Goldman', 'Apple');
INSERT INTO customers_products VALUES (50, 'Helen Green', 'Grapes');
INSERT INTO customers_products VALUES (10, 'Laura Owen', 'Pineapple');
SELECT * FROM customers_products;
------ IN and NOT IN Operators ---------
-- Find the records that has the product_name as Orange, Apple, Plum
-- 1st way: NOT RECOMMENDED -- because of the repetition
SELECT *
FROM customers_products
WHERE product_name = 'Orange' OR product_name = 'Apple' OR product_name = 'Plum';
-- 2nd way: RECOMMENDED
SELECT *
FROM customers_products
WHERE product_name IN('Orange', 'Apple', 'Plum');
-- Find the record that does NOT have the product_name as Orange, Apple, Plum
SELECT *
FROM customers_products
WHERE product_name NOT IN('Orange', 'Apple', 'Plum');
------ BETWEEN and NOT BETWEEN Operators --------
-- BETWEEN => inclusive which means the given boundaries will be included
-- NOT BETWEEN => exclusive which means the given boundaries will NOT be included
-- Find the product_name that have product_id greater than or equal to 20  and less than and equal to 30
-- 1st way:
SELECT product_name
FROM customers_products
WHERE product_id >= 20 AND product_id <= 30;
--2nd way:
SELECT product_name
FROM customers_products
WHERE product_id BETWEEN 20 AND 30;
-- Find the product_name that have product_id less than 30 and greater than 40
-- 1st way:
SELECT product_name
FROM customers_products
WHERE product_id < 30 OR product_id > 40;
--2nd way:
SELECT product_name
FROM customers_products
WHERE product_id NOT BETWEEN 30 AND 40;
SELECT * FROM customers_products;
DROP TABLE customers_products;
------------- EXIST Operator---------
CREATE TABLE customers_likes(
                                product_id CHAR(10),
                                customer_name VARCHAR(30),
                                liked_product VARCHAR(30)
);
INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Anna', 'Apple');
SELECT * FROM customers_likes;
-- Update all customer_name fields to 'No name' where customer_name is 'Hary' (invalid name)
UPDATE customers_likes
SET customer_name = 'No name'
WHERE customer_name = 'Hary'; -- nothing changed because 'Hary' doesn't exist in our database
-- EXISTS Operator works with a subquery and it updates the whole field if the subquery returns true
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name = 'Hary') -- INVALID NAME
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name = 'Lary') -- VALID NAME
-- Update all customer_name fields to 'No name' where liked_product is 'Orange' and 'Apple'
-- Using IN operator
UPDATE customers_likes
SET customer_name = 'No name'
WHERE liked_product IN ( 'Orange', 'Apple');
-- Using EXISTS operator
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product IN('Orange', 'Apple') );
/*
------What's the difference?-------
If you want to update SPECIFIC data/record, DO NOT use EXISTS operator because it changes / updates ALL
of the data inside that field.
If you want to update SPECIFIC data/record, use IN operator because it changes / updates ONLY
specific data inside that field.
*/
-- Delete records if there is 'Orange' in liked_product using IN OPERATOR
DELETE FROM customers_likes
WHERE liked_product IN ('Orange');
-- Delete records if there is 'Avocado' in liked_product using EXISTS OPERATOR
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Avocado');
SELECT * FROM customers_likes;
DROP TABLE customers_likes;
