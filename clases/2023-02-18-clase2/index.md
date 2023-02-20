Aprendizaje Automático Para Grandes Volúmenes de Datos
======================================================

Sábado 18 de febrero de 2023, clase 2

Asistencia

- [ ] 0214177@up.edu.mx Arroyo Vázquez, Jorge Armando (Armando, IIN) 
- [x] ediazm@up.edu.mx  Díaz Medina, Eduardo (Lalo, Ext.)
- [x] 0214020@up.edu.mx Escoto Aceves, María Andrea (Andrea, IID)
- [ ] 0248440@up.edu.mx Estrada Hernández, Héctor Raúl (Raúl, Ext. economía y gestión de negocios)
- [x] 0214611@up.edu.mx Macías Álvarez, Judith (Judith, IIN)
- [x] 0205608@up.edu.mx Orozco Alarcón, Javier (Javier, IIN) 
- [x] 0216072@up.edu.mx Perez, Andrea (Andrea, IID)
- [x] 0211501@up.edu.mx Ramirez Gonzalez, Jose Carlos (José Carlos, IIN)
- [x] 0213865@up.edu.mx Valdivia Mendoza, Juan Manuel (JuanMa, Ext. Industrial Ags.)
- [x] 0215080@up.edu.mx Villalpando Chávez, Natalia (Natalia, IID)

Clase
-----

### Recap

Todos tienen pycharm? Todos tienen su cuenta de github?

### Tipos de DB

Mostrar CSV, JSON, SQL, Excel

Mostrar MySql, SQLite, SQLServer, Oracle, PostgreSQL

### Práctico

Descargar este link
<https://drive.google.com/file/d/1d7O3-wOTt9tRtBUL4ZMZeEt2ZBMMGsJq/view?usp=sharing>

Mostrar un csv de los del semestre pasado

Mostrar cómo podemos agregarlo a una tabla de DB

Crear tabla principal

Mostrar select

Mostrar complicación de hacer un update a la tabla

Mostrar cómo sería si tuviéramos que actualizar el nombre de un jugador en múltiples
reportes

Mostrar el create table de múltiples tablas

### Ventajas y Desventajas

Explorar, qué propósito cumple SQL?

Qué ventajas y desventajas tiene sobre csv?

Cómo exploramos un set de tablas de SQL?

Cómo combinamos SQL con python?

Cómo se parece sql con pandas?

### Tarea

Clonar el repo de tareas y hacer un documento markdown con tu nombre y bloques de código
explicando qué es cada verbo de SQL, usar ChatGPT para esto.

---

Esto vimos en clase de comandos

```sql
CREATE TABLE students(
  id INT, -- e.g. 0105123
  name VARCHAR(100),
  last_name VARCHAR(100),
  date_of_birth DATE, -- e.g. 1989-07-27
  favorite_number INT, -- e.g. -1.5
  country_of_origin CHAR(3), -- e.g. MEX, USA, CAN
  active TINYINT
);

SELECT * FROM students;

INSERT INTO students (id, name, last_name, date_of_birth, favorite_number, country_of_origin, active)
VALUES (0105123, 'Santiago', 'Arizti', '1989-07-27', -1.5, 'MEX', 1),
       (0105123, 'Andrea', 'Perez', '1995-01-01', 8, 'USA', 1);

SELECT date_of_birth, name FROM students ORDER BY date_of_birth DESC;

SELECT group_concat(name) FROM students;

SELECT min(date_of_birth), name FROM students;
```