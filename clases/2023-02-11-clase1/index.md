Aprendizaje Automático Para Grandes Volúmenes de Datos
======================================================

Sábado 11 de febrero de 2023, clase 1

Asistencia

- [x] 0214177@up.edu.mx Arroyo Vázquez, Jorge Armando (Armando, IIN) 
- [x] ediazm@up.edu.mx  Díaz Medina, Eduardo (Lalo, Ext.)
- [x] 0214020@up.edu.mx Escoto Aceves, María Andrea (Andrea, IID)
- [x] 0248440@up.edu.mx Estrada Hernández, Héctor Raúl (Raúl, Ext. economía y gestión de negocios)
- [x] 0214611@up.edu.mx Macías Álvarez, Judith (Judith, IIN)
- [x] 0205608@up.edu.mx Orozco Alarcón, Javier (Javier, IIN) 
- [x] 0216072@up.edu.mx Perez, Andrea (Andrea, IID)
- [x] 0211501@up.edu.mx Ramirez Gonzalez, Jose Carlos José (Carlos, IIN)
- [x] 0213865@up.edu.mx Valdivia Mendoza, Juan Manuel (JuanMa, Ext. Industrial Ags.)
- [x] 0215080@up.edu.mx Villalpando Chávez, Natalia (Natalia, IID)

Tomar lista

mostrar lista de clases

experimento sistema 1, sistema 2
Sistema 1 o Sistema 2
<https://xurxodev.com/email/0920013c-832b-4fb0-8e24-30049641de00/>
<https://www.youtube.com/watch?v=z-Dg-06nrnc>

hablar de tipos de storage, qué es SQL (usar slidev)

hablar de los métodos de evaluación.

examen final: enviar un PR para crear una vista de una tabla que muestra un join de unas tablas.

primer colab.
<https://colab.research.google.com/drive/1qZF8X-3Kpy5PbCPNXLLvV-RwHqDnuMCm#scrollTo=t9OY6Ax1T4vD>

Ejemplo de un query complejo

```sql
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
```