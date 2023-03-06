
CREATE TABLE students(
  id INT PRIMARY KEY, -- e.g. 0105123
  name VARCHAR(100),
  last_name VARCHAR(100),
  date_of_birth DATE, -- e.g. 1989-07-27
  favorite_number INT, -- e.g. -1.5
  country_of_origin CHAR(3), -- e.g. MEX, USA, CAN
  active TINYINT
);

-- DROP TABLE students;
DELETE FROM students WHERE name = 'Andrea';


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

-- update set inactive in student
-- UPDATE students SET active=0 WHERE name = 'Eduardo' AND last_name = 'Díaz';
UPDATE students SET active=0 WHERE id = 0167763;

-- normal select, all columns, all records
SELECT * FROM students;

-- all records, some columns
SELECT id, name FROM students;

-- some records, all columns
SELECT * FROM students LIMIT 3 OFFSET 0;

SELECT * FROM students WHERE upper(name) = 'ANDREA';
SELECT * FROM students WHERE date(date_of_birth) >= date('2000-01-01');

SELECT
    strftime('%Y/%d/%m', date_of_birth) as "formatted birth date",
    * -- all the columns
FROM students
WHERE strftime('%Y', date_of_birth) > 2000;

-- report of all students, with nice column names, but only students that are enrolled (active)
SELECT
    id as "Student ID",
    name as "First Name",
    last_name as "Last Name",
    date_of_birth as "Date of Birth",
    favorite_number as "Favorite Number",
    country_of_origin as "Country of Origin"
FROM students
WHERE active = 1;

-- calculated columns with an alias
SELECT name, upper(name) as "uppercase name", lower(name) as "lowercase name" FROM students;

-- show students sorted by date of birth, youngest first (descending)
SELECT * FROM students ORDER BY date_of_birth DESC;

-- sort by many columns
SELECT * FROM students ORDER BY upper(name), upper(last_name);

-- report by birth day
SELECT
    strftime('%Y', date_of_birth) as dob,
    count(id) as cnt, -- aggregation of records in the group by result
    group_concat(name, ', ') as names
FROM students
GROUP BY dob
ORDER BY cnt DESC;

SELECT min(date_of_birth), name FROM students;
