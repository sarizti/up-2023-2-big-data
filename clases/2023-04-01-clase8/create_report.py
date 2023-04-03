import sqlite3
import pandas as pd

connection = sqlite3.connect('db.sqlite3')
cursor = connection.cursor()


def query_to_df(query):
    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [d[0] for d in cursor.description]
    return pd.DataFrame(rows, columns=columns)


df = query_to_df("""
    SELECT
        students.name || ' ' || students.last_name AS "Estudiante",
        enrollments.grade AS "Calificación",
        courses.semester AS "Semestre",
        CASE teachers.degree
            WHEN 'doctorate' THEN 'Dr.'
            WHEN 'masters' THEN 'Mtro.'
            ELSE 'Lic.'
        END || ' ' || teachers.name || ' ' || teachers.last_name
            AS "Professor",
        classes.name || ' (' || classes.school || ')' AS "Clase"
    FROM enrollments
    INNER JOIN students ON enrollments.student_id = students.id
    INNER JOIN courses ON enrollments.course_id = courses.id
    INNER JOIN teachers ON courses.teacher_id = teachers.id
    INNER JOIN classes ON courses.class_id = classes.id;
    """)


df.to_csv('report.csv')
