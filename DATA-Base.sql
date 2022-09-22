/**************Creation du base de données*/
CREATE DATABASE Win_Academy;
/**************Creation du table User*/
CREATE TABLE users
(
    id_user INT PRIMARY KEY NOT NULL,
    fristName VARCHAR(100),
    LastName VARCHAR(100),
    phone VARCHAR(10),
    email VARCHAR(255),
    password VARCHAR(255)  
);
/**************Creation du table enseignant*/
CREATE TABLE teachers
(
   `user_id` INT PRIMARY KEY NOT NULL,
    startWorkDate DATE,
    code_prof INT,
    FOREIGN KEY (user_id) REFERENCES users (id_user)   
);
/**************Creation du table etudiants*/
CREATE TABLE students
(
    `user_id` INT PRIMARY KEY NOT NULL,
    starDate DATE,
    FOREIGN KEY (user_id) REFERENCES users (id_user)   
);
/****************Creation du table Admin */
CREATE TABLE admines
(
    id_admin INT PRIMARY KEY NOT NULL  REFERENCES users (id_user),
    FOREIGN KEY (id_admin) REFERENCES utilisateur (id_user)   
);

/****************Creation du table userRole */
CREATE TABLE userRole
(
    user_id INT PRIMARY KEY NOT NULL  REFERENCES users (id_user),
    FOREIGN KEY (id_user) REFERENCES utilisateur (id_user)   
);
/***********Creation table Departements********/

CREATE TABLE Departements
(
    id_departements INT PRIMARY KEY NOT NULL,
    NameOfDepartements VARCHAR(255),
    ResponsableId INT,
    SchoolId INT
);
/***********Creation table Subject********/
CREATE TABLE Subject
(
    id_subject INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
     name VARCHAR(255)
);
/***********Creation table Room********/
CREATE TABLE Room
(
     id_roomt INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
     name VARCHAR(255),
     capacity  VARCHAR(40)
);
/***********Creation table Class********/
CREATE TABLE Class
(
     id_class INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
     name VARCHAR(255),
     departement_id INT,
    FOREIGN KEY (departement_id) REFERENCES departement (id_departements)
);
/***********Creation table Note controle********/
CREATE TABLE ExamGrade
(
     id_exam INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
     examGrade VARCHAR(20),
     studentId INT,
     subjectId INT,
     examDate DATE,
    FOREIGN KEY (studentId) REFERENCES students (user_id),
    FOREIGN KEY (subjectId) REFERENCES subject (id_subject)
);
INSERT INTO `users`(`id_user`, ` firstName`, `LastName`, `phone`, `email`, `password`) VALUES ('1','hamza','laqraa','0630202850','hamza@hotmail.com','1234');
INSERT INTO `students` (`id_student`, `starDate`, `user_id`) VALUES ('1', '2021-09-05', '3');
ALTER TABLE `userrole` ADD FOREIGN KEY (`role_id`) REFERENCES `role`(`id_role`) ;
ALTER TABLE `userrole` ADD FOREIGN KEY (`user_id`) REFERENCES `users`(`id_user`) ;

-- autant que responsable : calculer la moyen de departement
SELECT AVG(examgrade) departement_grade FROM examgrade eg INNER JOIN subject s ON s.id_subject = eg.subjectId INNER JOIN 
teachers t ON s.id_subject = t.subject_id INNER JOIN departements d ON d.id_departements = t.departement_id WHERE d.id_departements = 1;
-- consulter les notes d'etudiant a partir de son id
SELECT examGrade FROM examgrade eg INNER JOIN subject s ON s.id_subject = eg.subjectId WHERE eg.studentId= 3;
-- calculer le moyen general d'un etudiant
SELECT AVG(examGrade) grade FROM examgrade eg WHERE eg.studentId = 3;
/** Selectioner tous les prof et les responsable de departement**/
SELECT users.*,teachers.startWorkDate,teachers.code_prof,role.title as role_title FROM users INNER JOIN userrole ON users.id_user = userrole.user_id
 INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN teachers ON teachers.user_id=users.id_user;
/** Selectioner tous les prof et les responsable de departement avec leur departement correspond**/
 SELECT users.*,teachers.startWorkDate,teachers.code_prof,role.title as role_title,departements.NameOfDepartements FROM users INNER JOIN 
 userrole ON users.id_user = userrole.user_id INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN teachers ON teachers.user_id=users.id_user 
 INNER JOIN departements ON teachers.departement_id = departements.id_departements WHERE role.id_role= 1;
/****Select le nom du responsable et leur departement*****/
SELECT users.*,teachers.startWorkDate,teachers.code_prof,role.title as role_title,departements.NameOfDepartements FROM users 
INNER JOIN userrole ON users.id_user = userrole.user_id INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN teachers ON teachers.user_id=users.id_user 
INNER JOIN departements ON teachers.departement_id = departements.id_departements WHERE role.id_role=4;
/** Selectioner les depertement dans une college*/
SELECT school.*,departements.NameOfDepartements FROM school INNER JOIN departements ON school.id_school=departements.school_id;
=>SELECT departements. *,school.* FROM departements INNER JOIN school ON departements.school_id=school.id_school;
/** triage de college avec leur code postale d'addresse*/
SELECT school.name,school.SiteUrl,adress.codePostale FROM school INNER JOIN adress ON school.id_school=adress.schoolId ORDER BY codePostale;
/** Sellectioner les college avec leur ville*/
SELECT school.name,school.SiteUrl,adress.codePostale,city.nameCity FROM school INNER JOIN adress ON school.id_school=adress.schoolId 
INNER JOIN city ON city.idCity=adress.cityId ORDER BY nameCity;
/** Sellectioner profe avec leur matire*/
SELECT users.*,teachers.startWorkDate,teachers.code_prof,role.title as role_title,subject.name FROM users INNER JOIN userrole ON users.id_user = userrole.user_id 
INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN teachers ON teachers.user_id=users.id_user INNER JOIN 
subject ON subject.id_subject = teachers.subject_id;
/** Sellectioner profe avec leur matire et leur cours de salle avec la capacite des etudians*/
SELECT users.*,teachers.startWorkDate,teachers.code_prof,role.title as role_title,subject.name,room.name,room.capacity FROM users 
INNER JOIN userrole ON users.id_user = userrole.user_id INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN teachers ON teachers.user_id=users.id_user 
INNER JOIN subject ON subject.id_subject = teachers.subject_id INNER JOIN room ON room.id_room = subject.id_subject WHERE role.id_role=1;
/******** Selectioner tous les etudiants dans la meme classe *********/
SELECT users.*,students.starDate,role.title as role_title,class.nameClass FROM users INNER JOIN userrole ON users.id_user = userrole.user_id 
INNER JOIN role ON role.id_role = userrole.role_id INNER JOIN students ON students.user_id=users.id_user INNER JOIN 
class ON class.id_class = students.class_id WHERE class.id_class = 1;
/*****Selectionner les etudiant avec leur prof de matiere****/
SELECT users.*,class.*,users_teacher.firstName teacher_first_name, users_teacher.LastName teacher_last_name FROM users INNER JOIN 
students ON students.user_id=users.id_user INNER JOIN class ON students.class_id=class.id_class INNER JOIN class_teacher ON class_teacher.class_id=class.id_class 
INNER JOIN users users_teacher ON users_teacher.id_user=class_teacher.teacher_id WHERE class_teacher.teacher_id=2;
