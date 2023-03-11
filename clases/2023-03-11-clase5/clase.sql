CREATE TABLE students(
    id INT PRIMARY KEY, -- e.g. 0105123
    name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE, -- e.g. 1989-07-27
    favorite_number INT, -- e.g. -1.5
    country_of_origin CHAR(3), -- e.g. MEX, USA, CAN
    active INT CHECK(active IN (TRUE, FALSE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
-- DROP TABLE students;

INSERT INTO students (id, name, last_name, date_of_birth, favorite_number, country_of_origin, active)
VALUES (0105123, 'Santiago', 'Arizti', '1989-07-27', -1.5, 'MEX', 1),
       (0214020, 'andrea', 'escoto', '2000-03-10', 42,'MEX', 1),
       (0216072,'Andrea','Perez','1999-11-18',8,'USA',1),
       (0248440,'Raul','Estrada','1997-05-24',24,'MEX',1),
       (0215080,'Natalia','Villalpando','2000-08-01',7,'MEX',1),
       (0167763,'Eduardo','Díaz','1995-11-28',20,'MEX',1),
       (0213865,'Juan Manuel','Valdivia','2000-06-04',6,'BOL',1),
       (0214611, 'judith', 'macias' ,'1999-05-17', 15,'mex',1),
       (0205608,'Javier','Orozco','1999-06-09',44,'MEX',1),
       (0214177, 'Armando', 'Arroyo', '2000-12-28', 1122,'MEX', 1);

CREATE TABLE classes (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    school VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO classes (id, name, school)
VALUES (1001, 'Big Data', 'ECID'),
       (1002, 'Auditoría de Proyectos', 'EIGP');

CREATE TABLE teachers(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE, -- e.g. 1989-07-27
    degree TEXT CHECK(degree IN ('bachelors', 'masters', 'doctorate')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO teachers (id, name, last_name, date_of_birth, degree)
VALUES (105123, 'Santiago', 'Arizti', '1989-07-27', 'masters'),
       (101010, 'Elon', 'Musk', '1971-06-28', 'doctorate');

CREATE TABLE courses (
    id INT PRIMARY KEY,
    class_id INT,
    teacher_id INT,
    semester CHAR(6), -- e.g. 2023-2
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO courses (id, class_id, teacher_id, semester)
VALUES (123, 1001, 105123, '2023-2'),
       (456, 1002, 101010, '2022-1');

CREATE TABLE enrollments (
    id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    grade INT CHECK(grade between 0 and 100), -- e.g. 95
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO enrollments (id, course_id, student_id, grade)
VALUES (172121, 123, 0214020, 93),
       (172122, 123, 0216072, 82),
       (172123, 123, 0248440, 94),
       (172124, 123, 0215080, 93),
       (172125, 123, 0167763, 97),
       (172126, 123, 0213865, 93),
       (172127, 123, 0214611, 73),
       (172128, 123, 0205608, 93),
       (172129, 123, 0214177, 98);

CREATE TABLE attendance (
    id INT PRIMARY KEY,
    enrollment_id INT,
    class_nr INT, -- e.g. 1, 2, 3
    attended TEXT CHECK(attended IN ('yes', 'late', 'no')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
INSERT INTO attendance (id, enrollment_id, class_nr, attended)
VALUES
(9101, 172121, 1, 'yes'),
(9102, 172122, 1, 'yes'),
(9103, 172123, 1, 'yes'),
(9104, 172124, 1, 'yes'),
(9105, 172125, 1, 'yes'),
(9106, 172126, 1, 'yes'),
(9107, 172127, 1, 'yes'),
(9108, 172128, 1, 'yes'),
(9109, 172129, 1, 'yes'),
(9111, 172121, 2, 'yes'),
(9112, 172122, 2, 'yes'),
(9113, 172123, 2, 'late'),
(9114, 172124, 2, 'yes'),
(9115, 172125, 2, 'yes'),
(9116, 172126, 2, 'yes'),
(9117, 172127, 2, 'yes'),
(9118, 172128, 2, 'no'),
(9119, 172129, 2, 'yes'),
(9121, 172121, 3, 'yes'),
(9122, 172122, 3, 'yes'),
(9123, 172123, 3, 'yes'),
(9124, 172124, 3, 'yes'),
(9125, 172125, 3, 'no'),
(9126, 172126, 3, 'yes'),
(9127, 172127, 3, 'yes'),
(9128, 172128, 3, 'yes'),
(9129, 172129, 3, 'yes');
