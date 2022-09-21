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
)
