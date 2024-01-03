 CREATE TABLE students (
  id int,
  name varchar(50),
  city varchar(50),
  grade int,
  department varchar(20)
);

INSERT INTO students VALUES(100, 'Ahmet Umit', 'İstanbul', 546, 'Comp.Eng');
INSERT INTO students VALUES(101, 'R.Nuri Tekin', 'Antalya', 486, 'Management');
INSERT INTO students VALUES(102, 'S.Faik Faruk', 'Bursa', 554, 'Comp.Eng.');
INSERT INTO students VALUES(103, 'Yasar Kemal', 'İstanbul', 501, 'Mathematics');
INSERT INTO students VALUES(104, 'Halide E. Adivar', 'İzmir', 473, 'Psychology');
INSERT INTO students VALUES(105, 'Nazan Bekir', 'İzmir', 432, 'Literature');
INSERT INTO students VALUES(106, 'Peyami Safa', 'Antalya', 535, 'Comp.Eng.');
INSERT INTO students VALUES(107, 'Sabahattin Ali', 'İstanbul', 492, 'Mathematics');

SELECT * FROM students;
SELECT * FROM departments;

CREATE TABLE departments (
  dept_id int,
  department varchar(20),
  pass_grade int,
  campus varchar(20)
);

INSERT INTO departments VALUES(5001, 'Comp.Eng.', 521,'North');
INSERT INTO departments VALUES(5002, 'Mathematics', 455,'South');
INSERT INTO departments VALUES(5003, 'Psychology', 440,'Hisar');
INSERT INTO departments VALUES(5004, 'Management', 465,'Hisar');
INSERT INTO departments VALUES(5005, 'Literature', 420,'North');


