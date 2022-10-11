DELIMITER //
CREATE PROCEDURE calcularMetricasDeCalificacion(in peli int)
BEGIN
  declare vcantcrit, vpromedio float default 0;
  declare vpor1, vpor2, vpor3, vpor4, vpor5 float default 0;
  declare vestrella1, vestrella2, vestrella3, vestrella4, vestrella5 int default 0;
  declare vestrellatotal int default 0;

  select count(id_resenia)
  into vestrella1
  from resenia
  where contenido = peli and calificacion = 1;

  select count(id_resenia)
  into vestrella2
  from resenia
  where contenido = peli and calificacion = 2;

  select count(id_resenia)
  into vestrella3
  from resenia
  where contenido = peli and calificacion = 3;

  select count(id_resenia)
  into vestrella4
  from resenia
  where contenido = peli and calificacion = 4;

  select count(id_resenia)
  into vestrella5
  from resenia
  where contenido = peli and calificacion = 5;

  set vestrellatotal = vestrella1 + vestrella2 + vestrella3 + vestrella4 + vestrella5;

-- Porsentaje de cada estrella
  set vpor1 = vestrella1 *100 / vestrellatotal;
  set vpor2 = vestrella2 *100 / vestrellatotal;
  set vpor3 = vestrella3 *100 / vestrellatotal;
  set vpor4 = vestrella4 *100 / vestrellatotal;
  set vpor5 = vestrella5 *100 / vestrellatotal;

-- Obtengo el promedio y la cantidad de criticas
  select count(r.id_resenia), c.calificacion
  into vcantcrit, vpromedio
  from resenia r, contenido c
  where r.contenido = c.id_contenido
    and r.contenido = peli;

  select concat(vpor1,'%')  as Estrella_1, concat(vpor2,'%')  as Estrella_2,
         concat(vpor3,'%')  as Estrella_3, concat(vpor4,'%')  as Estrella_4,
         concat(vpor5,'%')  as Estrella_5;

  select vcantcrit  as Criticas, vpromedio  as promedio;


END; //
DELIMITER ;


-- declare vcriticas, vpromedio float;
--  declare vestrella1, vestrella2, vestrella3, vestrella4, vestrella5 int default 0;

--  declare metricas cursor 
--          for (select count(id_resenia) "cantidad", calificacion "estrella"
--               from resenia
---               where contenido = peli
--               group by calificacion);

--  open metricas;
