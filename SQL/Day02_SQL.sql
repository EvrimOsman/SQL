---------- Day 02 ----------
-- Create a table
CREATE TABLE students ( -- DDL -> is used to CREATE structure on DB
    id CHAR (4), 
    name VARCHAR (20), 
    age INT, 
    register_date DATE 
);
-- How to read the data from the table
SELECT * FROM students; -- DQL -> is used to read the data 
DROP TABLE students;
-- How to add values/data into the table 

INSERT INTO students VALUES ('1', 'Tom Hanks', 35, '2023-11-14');
INSERT INTO students VALUES ('2', 'Emma Watson', 25, now());
INSERT INTO students VALUES ('3', 'Henry Cavil', 23, now());

-- How to add values/data into specific columns

INSERT INTO students (name, age)VALUES ('John Doe', 30);
INSERT INTO students (id, name) VALUES (5, 'Margot Robbie');

-- How to read data from specific column

SELECT name, age FROM students;

SELECT * FROM students;

-- How to add CONSTRAINTS

CREATE TABLE employees (
    id SERIAL, 
    name VARCHAR (20) 
    age INT CHECK (age>=18 AND age<60), 
    email VARCHAR (40) UNIQUE,
    salary REAL
);
-- INSERT INTO employees VALUES ( ,'',  , '', ); -- normal syntax that we use to add values into the table.. follow the order of the columns
-- we will use the 2nd way of adding values => choose specific columns so we can avoid id columns because it's data type is SERIAL 

INSERT INTO employees (name, age, email, salary) VALUES ('Emma Watson', 23, 'ew@gmail.com', 50000);
INSERT INTO employees (age, email, salary) VALUES (24, 'ab@hotmail.com', 30000); -- error =>name field cann't be NULL
INSERT INTO employees (name, salary, age, email) VALUES ('Johnny Depp', 65000, 75, 'jd@yahoo.com'); -- error => CHECK constraint won't allow age 75
INSERT INTO employees (name, salary, age, email) VALUES ('Angelina Jolie', 80000, 55, 'ab@hotmail.com');
INSERT INTO employees (name, salary, age, email) VALUES ('Keira Keira Knightly', 90000, 35, 'ab@hotmail.com'); -- error => email column has UNIQUE Constraint, it can't take duplicate values
INSERT INTO employees (name, salary, age, email) VALUES ('Keira Keira Knightly', 90000, 35, 'kk@hotmail.com');

SELECT * FROM employees;

-- Add PRIMARY KEY Constraint
--1st way of adding PRIMARY KEY Constraint

CREATE TABLE books(
book_id SERIAL PRIMARY KEY,
	book_name VARCHAR (30) NOT NULL,
	page_num INT
);
DROP TABLE books;
--2nd way of adding PRIMARY KEY Constraint

CREATE TABLE books1(
book_id SERIAL, 
	book_name VARCHAR (30) NOT NULL,
	page_num INT,
	CONSTRAINT id_pk PRIMARY KEY (book_id)
	);
	-- How to create COMPOSITE PRIMARY KEY
	CREATE TABLE books2(
    book_id SERIAL, 
	book_name VARCHAR (30) NOT NULL,
	page_num INT,
	CONSTRAINT composite_pk PRIMARY KEY (book_id, book_name)
		);
	
	SELECT * FROM books2;
	
-- How to add FOREIGN KEY

CREATE TABLE authors(
	authour_id SERIAL,
	authour_name VARCHAR (20) NOT NULL,
	books_published INT,
	CONSTRAINT fk_books FOREIGN KEY (authour_id) REFERENCES books (book_id)
	
);









