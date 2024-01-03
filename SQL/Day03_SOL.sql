----------Day03----------

CREATE TABLE employees(
id char(5) PRIMARY KEY, --UNIQUE, NOT NULL, can be used as foreign key for other tables
name varchar(50) UNIQUE,
salary int NOT NULL,
start_date date
);


INSERT INTO new_employees VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO new_employees VALUES('10003', null, 5000, '2018-04-14'); --Accepted => 
INSERT INTO new_employees VALUES('10004', 'Donatello', 5000, '2018-04-14'); --error
INSERT INTO new_employees VALUES('10005', 'Michelangelo', 5000, '2018-04-14');
INSERT INTO new_employees VALUES('10006', 'Leonardo', null, '2019-04-12'); 
INSERT INTO new_employees VALUES('10007', 'Raphael', '', '2018-04-14');
INSERT INTO new_employees VALUES('', 'April', 2000, '2018-04-14'); 
INSERT INTO new_employees VALUES('', 'Ms.April', 2000, '2018-04-14'); 
INSERT INTO new_employees VALUES('10002', 'Splinter' ,12000, '2018-04-14');
INSERT INTO new_employees VALUES( null, 'Fred' ,12000, '2018-04-14'); 
INSERT INTO new_employees VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO new_employees VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO new_employees VALUES('10010', 'Betty' ,12000, '2018-04-14')
-- to see the table
SELECT * FROM new_employees


CREATE TABLE addresses(
address_id char(5),
dist varchar(30),
street varchar(30),
city varchar(20),
CONSTRAINT add_fk FOREIGN KEY(address_id) REFERENCES new_employees(id) 
);



INSERT INTO addresses VALUES('10003','Ninja Dist', '40.Cad.','IST'); 
INSERT INTO addresses VALUES('10003','Kaya Dist', '50.Cad.','Ankara');
INSERT INTO addresses VALUES('10002','Taş Dist', '30.Cad.','Konya');
INSERT INTO addresses VALUES('10012','Taş Sok', '30.Cad.','Konya'); 
INSERT INTO addresses VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO addresses VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

--to display the table
SELECT *FROM addresses;

---how to get specific column data
SELECT * FROM city


---------How to filter data through SQL Queries------
---------Where Condition-------

-- From new_employees table, display the record where salary < 5000
SELECT *
FROM new_employees
WHERE salary < 5000;

-- From new_employees table, display the record where salary > 5000
SELECT * 
FROM new_employees 
WHERE salary > 5000;

-- From new_employees table, display the record where salary = 5000
SELECT * 
FROM new_employees 
WHERE salary >= 5000;

-- From new_employees table, display the record where name is 'Donatello'
SELECT *
FROM new_employees 
WHERE name = 'Donatello';

-- From addresses table, display the record where address_id is  10003 and city 'Ankara'
SELECT *
FROM addresses
WHERE address_id = '10003' AND city = 'Ankara';

-- From addresses table, display the record where city is 'Konya' or 'Bursa'
SELECT *
FROM addresses
WHERE city = 'Konya' OR  city = 'Bursa';
SELECT * FROM new_employees;
SELECT * FROM addresses; 

-- All above SQL queries are DQL 
CREATE TABLE new_students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    exam_score INT
);



INSERT INTO new_students (first_name, last_name, exam_score)
VALUES
    ('Tom', 'Hanks', 85),
    ('Keira', 'Knightley', 92),
    ('Leonardo', 'DiCaprio', 78),
    ('Julia', 'Roberts', 88),
    ('Denzel', 'Washington', 95),
    ('Benedict', 'Cumberbatch', 87),
    ('Brad', 'Pitt', 91),
    ('Russel', 'Crowe', 89);
    
SELECT * FROM new_students; 

-- DELETE => DML --- 
-- DELETE FROM ... CONDITION ---- 
-- From table new_students, delete the record where first_name is 'Brad'

DELETE 
FROM new_students 
WHERE first_name = 'Brad';

-- Delete all records from new_students table new_students
DELETE FROM new_students; -- Removes all data from within the table ... but the table structure stays

-- From table new_students, delete the record where exam_score 78
DELETE 
FROM new_students
WHERE exam_score = 78;

-- From table new_students, delete the record where id is 13
DELETE
FROM new_students
WHERE id = 4;

-- From table new_students, delete the record where id 9 or last_name is 'Pitt'
DELETE
FROM new_students
WHERE id = 9 OR last_name = 'Pitt';

-- From table new_students, delete the record where id 14 or last_name is 'Pitt'
DELETE
FROM new_students
WHERE id = 14 OR last_name = 'Pitt';

SELECT * FROM new_students;

-- TRUNCATE, DELETE and DROP --- 
-- Delete all records from the table new_students
DELETE FROM new_students; 

TRUNCATE TABLE new_students;
-- TRUNCATE (hard) vs. DELETE (soft)
-- TRUNCATE and DELETE both remove data/records from the table
-- We can REVOKE data if we use DELETE FROM query. But we we remove data using TRUNCATE, we CANNOT revoke the data 
-- TRUNCATE is DDL while DELETE is DML
-- When we want to filter the records through certain conditions, we use DELETE
-- whereas we cannot use conditions with TRUNCATE 
-- Remove the table new_students
DROP TABLE new_students;
-- DROP command drop the table COMPLETELY from the database
