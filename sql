/**************Creation du base de données*/
CREATE DATABASE Win_Academy
/**************Creation du table User*/
CREATE TABLE utilisateur
(
    id INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    tele VARCHAR(10),
    email VARCHAR(255)    
);
/**************Creation du table enseignant*/
CREATE TABLE enseignant
(
    id INT PRIMARY KEY NOT NULL,
    date_fonction DATE,
    code_prof INT,
     utilisateur_id INT REFERENCES utilisateur (id)
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur (id)   
);
