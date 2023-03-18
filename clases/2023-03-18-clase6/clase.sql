CREATE TABLE students(
    id INT PRIMARY KEY -- e.g. 0105123
);

ALTER TABLE students ADD name VARCHAR(100);
ALTER TABLE students ADD last_name VARCHAR(100);
ALTER TABLE students ADD date_of_birth DATE;
ALTER TABLE students ADD favorite_number INT CHECK(favorite_number >= 0);
ALTER TABLE students ADD country_of_origin CHAR(3) CHECK(country_of_origin IN ('MEX', 'USA', 'CAN', 'BOL'));
ALTER TABLE students ADD active INT CHECK(active IN (TRUE, FALSE)) DEFAULT TRUE;
ALTER TABLE students ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;
