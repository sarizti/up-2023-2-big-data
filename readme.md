UP 2023-2 Big Data
==================

Aprendizaje Automático Para Grandes Volúmenes de Datos
======================================================

A.K.A
: Big Data

Semestre
: 2023-2

Fechas
: 2023-02 - 2023-06

Sesiones
--------

1. **2023-02-11**: introducción. presentar la clase. criterios de evaluación, setup de ambiente de trabajo.
2. **2023-02-18**: tipos de bases de datos, paradigmas (nosql, etc)
3. **2023-02-25**: tipos de sql (mysql, sql server, sqlite)
4. **2023-03-04** (nota: del 1 al 5 de marzo tengo que ir a la copa fortaleza)
5. **2023-03-11**: select statements
6. **2023-03-18**: insert, update
7. **2023-03-25**: select, insert, update, delete.
8. **2023-04-01**: repaso de los temas hasta el momento, hablar de CRUD. (nota: siguen 2 semanas de vacaciones aquí por semana santa)
9. **2023-04-22**: hacer un CRUD html 1. php y javascript.
10. **2023-04-29**: hacer un CRUD html 2. (continuación)
11. **2023-05-06**: ETL (tal vez esto va antes del CRUD)
12. **2023-05-13**: Hadoop, MapReduce, Spark
13. **2023-05-20**: Grandes bases de datos Big Query, Hive?
14. **2023-05-27**: Motores de búsqueda, ElasticSearch, Apache Solr, Indexado de archivos
15. **2023-06-03**: práctica para trabajo en equipo.
16. **2023-06-10**: exámen final, presentación de proyecto, etc.

Notas
-----

Mi primera materia como titular en la UP, voy a dar al grupo 2B, el grupo 2A tendrá otro profesor.


select emcategoriemerge.index1 AS femcategoriemerge,
       replace(substr(emcategoriemerge.title, LOCATE('/', emcategoriemerge.title) + 1), '/', ' > ') AS `path`, emmanufacturer.index1 AS femmanufacturer,
       emmanufacturer.title AS manufacturer,
       sum(cpprovider_order_article.cpplacement_amount_num) AS amount,
       round(sum(oxorderarticles.oxnetprice / oxorderarticles.oxamount * cpprovider_order_article.cpplacement_amount_num), 2) AS volume
from `oxorder`
    inner join `emcustomers` on `oxorder`.`femcustomers` = `emcustomers`.`index1`
    inner join `oxorderarticles` on `oxorder`.`oxid` = `oxorderarticles`.`oxorderid` and NOT  oxorderarticles.oxstorno
    inner join `cpprovider_order_article2oxorderarticles` on `cpprovider_order_article2oxorderarticles`.`f_oxorderarticles` = `oxorderarticles`.`index1`
    inner join `cpprovider_order_article` on `cpprovider_order_article2oxorderarticles`.`f_cpprovider_order_article` = `cpprovider_order_article`.`cpid` and cpprovider_order_article.cpactive and cpprovider_order_article.cpplacement_amount_num <> 0
    inner join `cpprovider_order` on `cpprovider_order`.`cpid` = `cpprovider_order_article`.`f_cpprovider_order` and cpprovider_order.cpactive
    inner join `emprovider` on `emprovider`.`index1` = `cpprovider_order`.`f_emprovider`
    inner join `emcoycoarticle` on `emcoycoarticle`.`index1` = `oxorderarticles`.`femcoycoarticle`
    left join `emmanufacturer` on `emmanufacturer`.`index1` = `emcoycoarticle`.`coycofemmanufacturer`
    inner join `emcategoriemerge` on `emcategoriemerge`.`index1` = `emcoycoarticle`.`femcategoriemerge`
    inner join (SELECT emcategoriemergeshops.femcategoriemerge, emcategoriemergeshops.femcategories
          FROM `emcategoriemergeshops`
          GROUP BY femcategoriemerge) t2 on `emcategoriemerge`.`index1` = `t2`.`femcategoriemerge`
    inner join `emcategories` on `emcategories`.`index1` = `t2`.`femcategories`
where oxorder.cpprovider_order_finished <> 0 and `oxorder`.`cpprovider_order_finished` between '2022-02-09 00:00:00' and '2023-02-09 23:59:59' and NOT oxorder.oxstorno
group by `emmanufacturer`.`index1`
order by `volume` desc

poner de tarea hacer un blog post

poner de tarea usar chatgpt

mostrar experimento de sistema 1 y sistema 2


