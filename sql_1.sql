-- --  create database
DROP  DATABASE IF EXISTS win_academy_database ;
CREATE DATABASE win_academy_database;
--USE win_academy_database;
-- create tables
CREATE TABLE cities(
                       id SERIAL PRIMARY KEY,
                       "name" VARCHAR(50) NOT NULL
);
CREATE TABLE schools(
                        id SERIAL PRIMARY KEY,
                        "name" VARCHAR(20) DEFAULT NULL,
                        site_url TEXT DEFAULT NULL);


CREATE TABLE adresses(
                         id SERIAL PRIMARY KEY,
                         postale_code VARCHAR(20) DEFAULT NULL,
                         city_id INT,
                         school_id INT,
                         FOREIGN KEY (city_id) REFERENCES cities(id),
                         FOREIGN KEY (school_id) REFERENCES Schools(id)
);
CREATE TABLE users(id SERIAL PRIMARY KEY,
                   first_name VARCHAR(20) NOT NULL,
                   last_name VARCHAR(20) NOT NULL,
                   phone_nbr VARCHAR(12),
                   email VARCHAR(30),
                   password_hash TEXT
);
CREATE TABLE rooms(id SERIAL PRIMARY KEY ,
                   "name" VARCHAR(20),
                   capacity INT DEFAULT NULL
);

CREATE TABLE subjects(
                         id SERIAL PRIMARY KEY ,
                         "name" VARCHAR(50),
                         room_id INT,
                         FOREIGN KEY (room_id) REFERENCES rooms(id)
);
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers(
                         start_work_date DATE,
                         subject_id INT NOT NULL ,
                         department_id INT NOT NULL,
                         FOREIGN KEY (subject_id) REFERENCES subjects(id)
) INHERITS (users);

DROP TABLE IF EXISTS departments ;
CREATE TABLE departments(
                            id SERIAL primary key ,
                            "name" VARCHAR(50),
                            school_id INT,
                            FOREIGN KEY (school_id) REFERENCES schools(id)
);
--  add foreign key outside table creation script because of recursive relationship
CREATE TABLE roles(
                      id SERIAL primary key ,
                      title varchar(30)
);
DROP TABLE role_user;
CREATE TABLE role_user(
                          user_id INT  ,
                          role_id INT,
                          FOREIGN KEY (user_id) REFERENCES users(id),
                          FOREIGN KEY (role_id) REFERENCES roles(id),
                          PRIMARY KEY (user_id,role_id)
);
DROP TABLE IF EXISTS classes;
CREATE TABLE classes(
                        id SERIAL PRIMARY KEY ,
                        "name" VARCHAR(50) NOT NULL,
                        department_id INT NOT NULL,
                        FOREIGN KEY (department_id) REFERENCES departments(id)
);
DROP TABLE students;
CREATE TABLE students(
                      start_date DATE,
                      class_id INT,
                      FOREIGN KEY (class_id) REFERENCES classes(id)
) INHERITS (users);
CREATE TABLE class_subject(
  class_id INT,
  subject_id INT,
  FOREIGN KEY (class_id) REFERENCES classes(id),
  FOREIGN KEY (subject_id) REFERENCES subjects(id),
  PRIMARY KEY (subject_id,class_id)
);
CREATE TABLE class_teacher(
    class_id INT,
    teacher_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (teacher_id) REFERENCES users(id)
);
CREATE TABLE exam_grades(
                            id SERIAL PRIMARY KEY,
                            exam_grade FLOAT DEFAULT NULL,
                            student_id INT NOT NULL ,
                            subject_id INT NOT NULL ,
                            FOREIGN KEY (subject_id) REFERENCES subjects(id)
                            --FOREIGN KEY (student_id) REFERENCES students(user_id)
);
DROP TABLE IF EXISTS admins;
CREATE TABLE admins(
) INHERITS (users);
-- fill in dummy data
INSERT INTO cities(name) values ('Youssoufia');
INSERT INTO cities(name) values ('agadir');
INSERT INTO cities(name) values ('marrakech');
-- insert schools
INSERT INTO schools(name,site_url) VALUES('Youcode','www.youcode.ma');
INSERT INTO schools(name,site_url) VALUES('1337','www.1337.ma');
SELECT  * FROM schools;
-- insert adresses
-- TODO:: insert some adresses for the inserted schools
-- insert departments
INSERT INTO departments(name,school_id)
VALUES ('IT department',2);
SELECT * FROM departments;
-- inserting classes
INSERT INTO classes(department_id,name)
VALUES (1,'java/angular');
INSERT INTO classes(department_id,name)
VALUES (1,'fullStack/js');
SELECT * FROM classes;
-- inserting rooms
INSERT INTO rooms(name,capacity) VALUES('namek',30);
INSERT INTO rooms(name,capacity) VALUES('404',10);
INSERT INTO rooms(name,capacity) VALUES('PHP',20);
select * from rooms;
-- inserting some subjects
INSERT INTO subjects(name,room_id)
VALUES ('java',1);
INSERT INTO subjects(name,room_id)
VALUES ('js',2);
INSERT INTO subjects(name,room_id)
VALUES ('php',3);

-- inserting some users
-- insert roles
INSERT INTO roles(title) VALUES ('admin');
INSERT INTO roles(title) VALUES ('student');
INSERT INTO roles(title) VALUES ('teacher');
INSERT INTO roles(title) VALUES ('head_of_department');
SELECT * from roles;
-- reset users sequence
alter sequence users_id_seq RESTART WITH 1;
delete  from users;
-- admin user
INSERT INTO admins(first_name,last_name,email,password_hash,phone_nbr)
VALUES ('omar','kazoum','omarkazoum96@gmail.com','','0610204662');
INSERT INTO role_user(user_id,role_id) VALUES (1,1);
select * from admins;
select * from role_user;
-- student user
alter sequence users_id_seq RESTART WITH 2;
INSERT INTO students(first_name,last_name,email,password_hash,phone_nbr,start_date,class_id)
VALUES ('hamza','lqraa','hamzalaqraa@gmail.com','','01212121212',now(),1);
INSERT INTO role_user(user_id,role_id) VALUES (2,2);

INSERT INTO students(first_name,last_name,email,password_hash,phone_nbr,start_date,class_id)
VALUES ('ibrahim','essideq','ibrahim1@gmail.com','','01212121212',now(),1);

INSERT INTO role_user(user_id,role_id) VALUES (3,2);
select *
from students;
delete from students;
-- teacher user
INSERT INTO teachers(first_name,last_name,password_hash,email,phone_nbr,subject_id,department_id,start_work_date)
VALUES ('ilyass','ilyass','','ilyass@gmail.com','01212121212',2,1,'2022-09-19');
INSERT INTO role_user(user_id,role_id) VALUES (4,3);

INSERT INTO teachers(first_name,last_name,password_hash,email,phone_nbr,subject_id,department_id,start_work_date)
VALUES ('bouchra','merzaq','','bouchra1@gmail.com','01212121212',1,1,'2022-09-19');
INSERT INTO role_user(user_id,role_id) VALUES (5,3);

select * from teachers;
-- making the teacher responsible for the department
INSERT INTO role_user(user_id, role_id) VALUES (5,4);
-- get all
SELECT * FROM students;
-- get by id
SELECT * FROM students WHERE id=2;
-- add
INSERT INTO users(first_name,last_name,email,password_hash,phone_nbr)
VALUES ('hamza','lqraa','hamzalaqraa@gmail.com','','01212121212');
INSERT INTO role_user(user_id,role_id) VALUES (2,2);
SELECT * FROM role_user;
-- delete
DELETE FROM students WHERE id=1;
-- update
UPDATE students SET start_date='2032-09-11', class_id=1 WHERE id=2;
select * from students;
UPDATE students SET first_name= 'hamza',last_name='lqraa',email='hamzalaqraa@gmail.com',password_hash='',phone_nbr='01212121212' WHERE id=2;
-- get average by subject
SELECT s.name  AS subject_name,AVG(exam_grades.exam_grade) AS average FROM exam_grades INNER JOIN subjects s on exam_grades.subject_id = s.id GROUP BY s.id;
-- get average by department
SELECT d.name AS department_name,AVG(exam_grades.exam_grade) AS average
        FROM exam_grades
        INNER JOIN students s on exam_grades.student_id =s.id
        INNER JOIN classes ON classes.id= s.class_id
        INNER JOIN departments d ON classes.department_id = d.id GROUP BY d.id;
-- get average by student
SELECT CONCAT(students.first_name,' ',students.last_name) AS full_name,avgs.average  FROM (SELECT
                     eg.student_id as student_id,
        AVG(eg.exam_grade) AS average
        FROM exam_grades eg
        GROUP BY eg.student_id)  avgs INNER JOIN students ON students.id=avgs.student_id;
-- get all not graded subjects for a student
SELECT s.id,first_name,last_name,subjects.*
        FROM students s
            INNER JOIN exam_grades ON exam_grades.student_id=s.id
            INNER JOIN subjects ON subjects.id=exam_grades.subject_id
            WHERE exam_grades.exam_grade=NULL;
-- fiche signalétique student
SELECT phone_nbr,email,first_name,last_name FROM students ;
-- fiche signalétique teacher
SELECT t.id,t.last_name,t.first_name,t.email,t.start_work_date,s.name,r.name FROM teachers t  INNER JOIN subjects s on t.subject_id = s.id INNER JOIN rooms r on r.id = s.room_id WHERE t.id=5;
-- TODO::get each department with it's responsible
SELECT t.*,t.*,s.name as subject_name FROM teachers t
    INNER JOIN role_user ru ON ru.user_id=t.id
    INNER JOIN subjects s ON t.subject_id = s.id
    INNER JOIN departments on t.department_id = departments.id
    WHERE ru.role_id=4;

-- TODO:: En tant qu'Administrateur je peux se t'authentifier
SELECT admins.* FROM admins
    INNER JOIN role_user on admins.id = role_user.user_id
    INNER JOIN roles ON roles.id=role_user.role_id WHERE roles.title='admin' AND admins.email='omarkazoum96@gmail.com';
-- En tant qu'Administrateur je peux ajouter un enseignant
INSERT INTO teachers(first_name,last_name,email,password_hash,
                     phone_nbr,subject_id,department_id,start_work_date)
VALUES ('ahmad','abderrafie','ahmed@gmail.com','',
        '01212121212',3,1,'2022-09-19');
INSERT INTO role_user(user_id,role_id) VALUES (3,3);
-- En tant qu'Administrateur je peux ajouter un département.
INSERT INTO departments(name,school_id)
        VALUES('comics department',1);


