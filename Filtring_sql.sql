-- calculer le moyen des notes par matiere
SELECT AVG(exam_grade) grade FROM exam_grades eg INNER JOIN subjects s 
ON s.id = eg.subject_id WHERE s.name = ?
-- calculer le moyen general d'un etudiant
SELECT AVG(exam_grade) grade FROM exam_grades eg WHERE eg.student_id = 1 ;
-- consulter les notes d'etudiant a partir de son id
SELECT exam_grade FROM exam_grades eg INNER JOIN subjects s 
ON s.id = eg.subject_id WHERE eg.student_id = 1;
-- autant que enseignant : consulter les etudiants
SELECT first_name,last_name FROM users u 
INNER JOIN students s 
ON u.id = s.user_id 
INNER JOIN classes cl 
ON cl.id = s.class_id
INNER JOIN class_subject cs 
ON cl.id = cs.class_id
INNER JOIN subjects sj 
ON cs.subject_id = sj.id 
INNER JOIN teachers t 
ON sj.id = t.subject_id 
INNER JOIN role_user ur 
ON u.id = ur.user_id 
INNER JOIN roles r 
ON ur.role_id = r.id 
WHERE t.user_id = 3 and r.title = "student" and cl.id =1;
-- autant que responsable : calculer la moyen de departement
SELECT AVG(exam_grade) departement_grade FROM exam_grades eg  INNER JOIN subjects s ON s.id = eg.subject_id 
INNER JOIN teachers t ON s.id = t.subject_id INNER JOIN departements d ON d.id = t.departement_id WHERE d.id = 1;
