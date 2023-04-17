/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
  IDs, names, y GPAs de estudiantes con GPA > 3.6
**************************************************************/

/*
Comentario
*/
-- comentario en linea

SELECT sID, sName, GPA
FROM student
WHERE GPA> 3.6;

/*** Same query without GPA ***/
SELECT sID, sName
FROM student
WHERE GPA> 3.6;


/**************************************************************
  Nombres de los estudiantes y majors a los que han aplicado
**************************************************************/

select sName, major
from Student, Apply
where Student.sID = Apply.sID;

select distinct sName, major
from Student
INNER JOIN Apply
on Student.sID = Apply.sID;

/*** La misma query con distinct ***/


/**************************************************************
  Names y GPAs de estudiantes con sizeHS < 1000 aplicando
  CS en Stanford, y la decisión de aplicación
**************************************************************/
select distinct sName, GPA, decision
from Student s
INNER JOIN Apply a
on s.sID = a.sID
where sizeHS < 1000
and major = "CS"
and cName = "Stanford";

/**************************************************************
  Todos los campus grandes (+20k enrollment) con aplicantes a CS
**************************************************************/
SELECT distinct c.cName
FROM college c
INNER JOIN apply a
ON c.cName = a.cName
WHERE enrollment >20000
AND major ="CS";

/*** Solucionamos el error ***/

/*** Añade Distinct al nombre ***/


/**************************************************************
  Información de Aplicaciones (combinamos los 3)
**************************************************************/
SELECT *
FROM apply A
INNER JOIN student S
ON A.sID=S.sID
INNER JOIN college C
on C.cName=A.cName; 

/*** Ordenamos por GPA decreciente ***/
SELECT *
FROM apply A
INNER JOIN student S
ON A.sID=S.sID
INNER JOIN college C
on C.cName=A.cName
ORDER BY S.GPA DESC; 


/***Ahora también por enrollment ascendiente ***/
SELECT *
FROM apply A
INNER JOIN student S
ON A.sID=S.sID

INNER JOIN college C
on C.cName=A.cName
ORDER BY S.GPA DESC, C.enrollment;
/**************************************************************
  Aplicantes a grados "bio"
**************************************************************/
SELECT S.sName
FROM student S
INNER JOIN apply A
ON S.sID=A.sID
WHERE A.major like "%bio%";


/* Introducimos LIKE a nuestra sintaxis*/


/*** Lo mismo pero con Select * ***/
SELECT *
FROM student S
INNER JOIN apply A
ON S.sID=A.sID
WHERE A.major like "%bio%";


/**************************************************************
  Crea un GPA escalado basado en sizeHS (GPA*(sizeHS/1000.0))
**************************************************************/
SELECT *, GPA*(sizeHS / 1000.0) AS ScaledGPA
FROM student;
/*** Rename result attribute ***/
