## create database
DROP  DATABASE IF EXISTS win_academy_database ;
CREATE DATABASE win_academy_database;
USE win_academy_database;
#create tables
CREATE TABLE cities(
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       `name` VARCHAR(50) NOT NULL
);
CREATE TABLE schools(
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        `name` VARCHAR(20) DEFAULT NULL,
                        site_url TEXT DEFAULT NULL);


CREATE TABLE adresses(
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         postale_code VARCHAR(20) DEFAULT NULL,
                         city_id INT,
                         school_id INT,
                         FOREIGN KEY (city_id) REFERENCES cities(id),
                         FOREIGN KEY (school_id) REFERENCES Schools(id)
);
CREATE TABLE users(id INT AUTO_INCREMENT PRIMARY KEY,
                   first_name VARCHAR(20) NOT NULL,
                   last_name VARCHAR(20) NOT NULL,
                   phone_nbr VARCHAR(12),
                   email VARCHAR(30),
                   password_hash TEXT
);
CREATE TABLE rooms(id INT AUTO_INCREMENT PRIMARY KEY ,
                   `name` VARCHAR(20),
                   capacity INT DEFAULT NULL
);

CREATE TABLE subjects(
                         id INT AUTO_INCREMENT PRIMARY KEY ,
                         `name` VARCHAR(50),
                         room_id INT,
                         FOREIGN KEY (room_id) REFERENCES rooms(id)
);
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers(
                         user_id INT PRIMARY KEY,
                         start_work_date DATE,
                         subject_id INT NOT NULL ,
                         department_id INT NOT NULL,
                         FOREIGN KEY (user_id) REFERENCES users(id),
                         FOREIGN KEY (subject_id) REFERENCES subjects(id)
);
DROP TABLE IF EXISTS departments ;
DESCRIBE departments;
CREATE TABLE departments(
                            id INT AUTO_INCREMENT primary key ,
                            `name` VARCHAR(50),
                            school_id INT,
                            FOREIGN KEY (school_id) REFERENCES schools(id)
);
# add foreign key outside table creation script because of recursive relationship
CREATE TABLE roles(
                      id INT AUTO_INCREMENT primary key ,
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
                        id INT AUTO_INCREMENT PRIMARY KEY ,
                        `name` VARCHAR(50) NOT NULL,
                        department_id INT NOT NULL,
                        FOREIGN KEY (department_id) REFERENCES departments(id)
);
DROP TABLE students;
CREATE TABLE students(user_id INT AUTO_INCREMENT PRIMARY KEY ,
                      start_date DATE,
                      class_id INT,
                      FOREIGN KEY (class_id) REFERENCES classes(id)
);
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
    FOREIGN KEY (teacher_id) REFERENCES teachers(user_id)
);
CREATE TABLE exam_grades(
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            exam_grade FLOAT DEFAULT NULL,
                            student_id INT NOT NULL ,
                            subject_id INT NOT NULL ,
                            FOREIGN KEY (subject_id) REFERENCES subjects(id),
                            FOREIGN KEY (student_id) REFERENCES students(user_id)
);

CREATE TABLE admins(
                       user_id INT AUTO_INCREMENT PRIMARY KEY ,
                       FOREIGN KEY (user_id) REFERENCES users(id)
);
#fill in dummy data
INSERT INTO cities(cities.name) values ('Youssoufia');
INSERT INTO cities(cities.name) values ('agadir');
INSERT INTO cities(cities.name) values ('marrakech');
#insert schools
INSERT INTO schools(schools.name,schools.site_url) VALUES('Youcode','www.youcode.ma');
INSERT INTO schools(schools.name,schools.site_url) VALUES('1337','www.1337.ma');
SELECT  * FROM schools;
#insert adresses
#TODO:: insert some adresses for the inserted schools
#insert departments
INSERT INTO departments(departments.name,departments.school_id)
VALUES ('IT department',2);
SELECT * FROM departments;
#inserting classes
INSERT INTO classes(classes.department_id,classes.name)
VALUES (1,'java/angular');
INSERT INTO classes(classes.department_id,classes.name)
VALUES (1,'fullStack/js');
SELECT * FROM classes;
#inserting rooms
INSERT INTO rooms(rooms.name,rooms.capacity) VALUES('namek',30);
INSERT INTO rooms(rooms.name,rooms.capacity) VALUES('404',10);

#inserting some subjects
INSERT INTO subjects(subjects.name,subjects.room_id)
VALUES ('java',1);
INSERT INTO subjects(subjects.name,subjects.room_id)
VALUES ('js',2);

#inserting some users
#insert roles
INSERT INTO roles(roles.title) VALUES ('admin');
INSERT INTO roles(roles.title) VALUES ('student');
INSERT INTO roles(roles.title) VALUES ('teacher');
INSERT INTO roles(roles.title) VALUES ('head_of_department');
SELECT * from roles;
#admin user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('omar','kazoum','omarkazoum96@gmail.com','','0610204662');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (1,1);
INSERT INTO students(students.user_id,students.start_date,students.class_id) VALUES (1,NOW(),1);
#student user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('hamza','lqraa','hamzalaqraa@gmail.com','','01212121212');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (2,2);
#teacher user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('ibrahim','esseddyq','ibrahimessedyq@gmail.com','','01212121212');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (3,3);
INSERT INTO teachers(teachers.user_id,teachers.subject_id,teachers.department_id,teachers.start_work_date)
VALUES (3,1,1,'2022-09-19');
#making the teacher responsible for the department
INSERT INTO role_user(user_id, role_id) VALUES (3,4);
#get all
SELECT * FROM students;
#get by id
SELECT * FROM students WHERE students.user_id=1;
#add
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('hamza','lqraa','hamzalaqraa@gmail.com','','01212121212');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (2,2);
SELECT * FROM role_user;
#delete
DELETE FROM students WHERE students.user_id=1;
DELETE FROM users WHERE users.id=1;
#update
UPDATE students SET students.start_date='2032-09-11', students.class_id=1 WHERE students.user_id=3;
UPDATE users SET users.first_name= 'hamza',users.last_name='lqraa',users.email='hamzalaqraa@gmail.com',users.password_hash='',users.phone_nbr='01212121212' WHERE users.id=2;
#get average by subject
SELECT s.name  AS subject_name,AVG(exam_grades.exam_grade) AS average FROM exam_grades INNER JOIN subjects s on exam_grades.subject_id = s.id GROUP BY s.id;
#get average by department
SELECT departments.name AS department_name,AVG(exam_grades.exam_grade) AS average
    FROM exam_grades INNER JOIN students on exam_grades.student_id = students.user_id INNER JOIN classes ON classes.id=students.class_id = classes.id INNER JOIN departments ON classes.department_id=departments.id GROUP BY departments.id;
#get average by student
SELECT CONCAT(users.first_name,' ',users.last_name) AS student_full_name,AVG(exam_grades.exam_grade) AS average FROM exam_grades INNER JOIN students on exam_grades.student_id = students.user_id INNER JOIN users ON users.id=students.user_id = users.id GROUP BY students.user_id;
#get all not graded subjects for a student
SELECT users.id,users.first_name,users.last_name,subjects.*
        FROM students INNER JOIN users ON users.id=students.user_id
            INNER JOIN exam_grades ON exam_grades.student_id=students.user_id
            INNER JOIN subjects ON subjects.id=exam_grades.subject_id
            WHERE exam_grades.exam_grade=NULL;
#fiche technique student
SELECT users.phone_nbr,users.email,users.first_name,users.last_name FROM users INNER JOIN students on users.id = students.user_id;
#fiche technique teacher
SELECT * FROM users INNER JOIN teachers on users.id = teachers.user_id;
#TODO::get each department with it's responsible
SELECT users.*,teachers.*,departments.* FROM users INNER JOIN role_user ON role_user.user_id=users.id INNER JOIN roles r ON r.id=role_user.role_id INNER JOIN teachers ON teachers.user_id=users.id = teachers.user_id INNER JOIN departments on teachers.department_id = departments.id WHERE r.id=4;

#TODO:: En tant qu'Administrateur je peux se t'authentifier
SELECT * FROM users
    INNER JOIN role_user on users.id = role_user.user_id
    INNER JOIN roles ON roles.id=role_user.role_id WHERE roles.title='admin' AND users.email='omarkazoum96@gmail.com';
#TODO:: add the other requests
