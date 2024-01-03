----------Day 04-------------

CREATE TABLE primary_students(
    student_id CHAR(5) PRIMARY KEY,
    student_name VARCHAR,
    email_address VARCHAR NOT NULL,
    student_age NUMERIC(2) CHECK(student_age>5),
    phone_number CHAR(10) UNIQUE
);


INSERT INTO primary_students VALUES('1111','Ryan Brooks', 'rb@gmail.com', 11, '1234567890');
INSERT INTO primary_students VALUES('1112','Emma Williams', 'ew@gmail.com', 12, '2345678901');
INSERT INTO primary_students VALUES('1114','Alic  Baker', 'ab@gmail.com', 10, '2346578901');

--INSERT INTO primary_students VALUES('113','Tom Hanks', null , 123, '1234567890'); -- we'll get 3 errors => email can't be null, age limit is 2 digits, phone no should be unique 

INSERT INTO primary_students VALUES('113','Tom Hanks', 'th@yahoo.com' , 12, '0123456789');

-- How to add specific values in to specific columns

INSERT INTO primary_students (student_id, email_address, phone_number) 
VALUES ('1115', 'abc@outlokk.com', '3456789012') , ('1116', 'xyz@gmail.com', '4567890123');

-- To see the table 
SELECT * FROM primary_students;


-- How to upodate existing data in a table

-- Update student's id t0 1113 where it is '113' 
UPDATE primary_students
SET student_id = '1113'  -- NEW VALUE
WHERE student_id = '113'; -- Existing value 


-- Change 'Tom Hanks to 'Mark Smith'
UPDATE primary_students
SET student_name = 'Mark Smith'
WHERE student_name = 'Tom Hanks';

-- Change email_address 'xyz@gmail.com' to null
UPDATE primary_students
SET email_address = null
WHERE email_address = 'xyz@gmail.com'; -- error => not-null constraint


-- Change email_address 'xyz@gmail.com' to 'pq@gmail.com'

UPDATE primary_students
SET email_address = 'pq@gmail.com'
WHERE email_address = 'xyz@gmail.com';

-- Update all students' age to the maximum age

/*
UPDATE primary_students
SET student_age = 12; -- hard coding
*/
UPDATE primary_students
SET student_age = (SELECT MAX(student_age) FROM primary_students); -- dynamic way 

SELECT * FROM primary_students;

--AGGREGATE FUNCTIONS -----
-- In PostgreSQL, we have FIVE aggregate functions => MAX, MIN, AVG, COUNT, SUM

CREATE TABLE parents(
parent_id CHAR(5) PRIMARY KEY,
parent_name TEXT,
student_id CHAR(5),
parent_address TEXT,
parent_dob DATE
);

INSERT INTO parents VALUES('2111', 'Adam Brooks', '1111', 'Miami, FL', '1994-10-23');
INSERT INTO parents VALUES('2112', 'Angie Williams', '1112', 'New York, USA', '1987-2-13');
INSERT INTO parents VALUES('2113', 'Andrew Duffy', '1113', 'Berlin, Germany', '1975-12-05');
INSERT INTO parents VALUES('2114', 'John Baker', '1114', 'London, UK', '1975-10-3');

-- Change all date of births to the maximum date of birth
UPDATE parents
SET parent_dob = '1975-10-3'; -- hard coded
-- dynamic way
UPDATE parents
SET parent_dob = (SELECT MIN(parent_dob) FROM parents);

SELECT * FROM parents;

CREATE TABLE workers(
  worker_id SMALLINT,       
  worker_name VARCHAR(50),
  worker_salary NUMERIC,
  CONSTRAINT worker_id_pk PRIMARY KEY(worker_id) 
);

INSERT INTO workers VALUES(101, 'Ali Can', 10000);
INSERT INTO workers VALUES(102, 'Veli Han', 4000);
INSERT INTO workers VALUES(103, 'Aisha Can', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 12000);
INSERT INTO workers VALUES(105, 'Musa Ahmet', 9000);
SELECT * FROM workers;

---------ALIAS-----------
--We use AS(alias) to give a temporary name to the field which shows us the result
--SELECT maximum salary
SELECT MAX(worker_salary) AS Maximum_salary FROM workers;


--SELECT MANIMUM SALARY
SELECT  MIN(worker_salary) FROM workers;

--Find out the avarege worker salary using ALIAS
SELECT AVG(worker_salary)AS avarege_salary FROM workers;

--Find the total number of workers using ALIAS
SELECT COUNT (worker_id) AS Total_num_workers FROM workers;

--Find the total salary
SELECT SUM(worker_salary) AS total_salary FROM workers;

--Increase Veli's salary to 20% less than the highest salary
--SELECT MAX(worker_salary) FROM workers --Max salary (12000)
--SELECT MAX(worker_salary) * 0.8 FROM workers--20% of the highest salary (9600)

UPDATE workers
SET worker_salary = new value
WHERE worker_id = 102; 

UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary) * 0.8 FROM workers) --Dynamic coding
WHERE worker_id = 102; 

-- Decrease Ali's salary to 30% more than lowest salary (means 130% of min so we multiply by 1.3)
 --30% more than the lowest salary

UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary) *1.3 FROM workers)
WHERE worker_id = 101; 

--Increase the salaries by 1000 if the salaries are less than average salary
--SELECT AVG(worker_salary) FROM workers => returens average salary


UPDATE workers
SET worker_salary = worker_salary + 1000 
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers);


--Make the salaries equal to avarage salaries if salaries are less than average salary
UPDATE workers
SET worker_salary = (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary <(SELECT AVG(worker_salary) FROM workers);

----- INTERVIEW QUESTIONS -----
-- How to select record whose salary is the HIGHEST
SELECT *
FROM workers
WHERE worker_salary = (SELECT MAX (worker_salary) AS maximum_salary FROM workers);

-- How to select record whose salary is the LOWEST
SELECT *
FROM workers
WHERE worker_salary = (SELECT MIN (worker_salary) AS minimum_salary FROM workers);


-- How to get the second HIGHEST salary
SELECT MAX(worker_salary) AS second_highest_salary
FROM workers
WHERE worker_salary < (SELECT MAX (worker_salary) FROM workers);

-- How to get the second LOWEST salary
SELECT MIN (worker_salary) AS second_lowest_salary
FROM workers
WHERE worker_salary > (SELECT MIN (worker_salary) FROM workers);

-- How to get the third HIGHEST salary
SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary < ( SELECT MAX(worker_salary) AS second_highest_salary
                        FROM workers
                        WHERE worker_salary < (SELECT MAX (worker_salary) FROM workers));

-- How to get the third LOWEST salary
SELECT MIN (worker_salary)
FROM workers
WHERE worker_salary > (SELECT MIN (worker_salary)
                       FROM workers
                       WHERE worker_salary > (SELECT MIN (worker_salary) FROM workers));

SELECT * FROM workers;

