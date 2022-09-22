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
CREATE TABLE teachers(
                         user_id INT PRIMARY KEY,
                         start_work_date DATE,
                         subject_id INT NOT NULL ,
                         department_id INT NOT NULL,
                         FOREIGN KEY (user_id) REFERENCES users(id),
                         FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

CREATE TABLE departments(
                            id INT AUTO_INCREMENT primary key ,
                            `name` VARCHAR(50),
                            responsible_id INT,
                            school_id INT,
                            FOREIGN KEY (school_id) REFERENCES schools(id),
                            FOREIGN KEY (responsible_id) REFERENCES teachers(user_id)
);
# add foreign key outside table creation script because of recursive relationship
ALTER TABLE teachers ADD FOREIGN KEY (department_id) REFERENCES departments(id);

CREATE TABLE roles(
                      id INT AUTO_INCREMENT primary key ,
                      title varchar(30)
);
CREATE TABLE role_user(
                          user_id INT  ,
                          role_id INT,
                          FOREIGN KEY (user_id) REFERENCES users(id),
                          FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE classes(
                        id INT AUTO_INCREMENT PRIMARY KEY ,
                        `name` VARCHAR(50) NOT NULL,
                        department_id INT NOT NULL,
                        FOREIGN KEY (department_id) REFERENCES departments(id)
);
CREATE TABLE students(user_id INT AUTO_INCREMENT PRIMARY KEY ,
                      start_date DATE,
                      class_id INT,
                      FOREIGN KEY (class_id) REFERENCES classes(id)
);
CREATE TABLE class_student(
                              class_id INT,
                              student_id INT,
                              FOREIGN KEY (class_id) REFERENCES classes(id),
                              FOREIGN KEY (student_id) REFERENCES students(user_id)

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

#insert adresses
#TODO:: insert some adresses for the inserted schools
#insert departments

#inserting classes

#inserting some users
#insert roles
INSERT INTO roles(roles.title) VALUES ('admin');
INSERT INTO roles(roles.title) VALUES ('student');
INSERT INTO roles(roles.title) VALUES ('teacher');
#admin user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('omar','kazoum','omarkazoum96@gmail.com','','0610204662');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (1,1);
INSERT INTO students(students.user_id,students.start_date,students.class_id) VALUES (1,NOW(),1)
#student user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('hamza','lqraa','hamzalaqraa@gmail.com','','01212121212');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (2,2);
#teacher user
INSERT INTO users(users.first_name,users.last_name,users.email,users.password_hash,users.phone_nbr)
VALUES ('ibrahim','esseddyq','ibrahimessedyq@gmail.com','','01212121212');
INSERT INTO role_user(role_user.user_id,role_user.role_id) VALUES (3,3);

/**********************
 *     CRUD STUDENTS  *
 **********************/
SELECT * FROM students;

