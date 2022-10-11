-- --------------------------------------------------------------------
-- TEST CASE: calcularMetricasDeCalificacion
-- DESCRIPCION: este procedimiento va a mostrar en pantalla las metricas
-- sobre la pelicula con id = 200
-- --------------------------------------------------------------------

-- IMPUT DATA SET
-- realizo un insert de resenias sobre la pelicula id = 200
-- asi se me actualiza su clasificacion con el trigger 
-- y tengo una variacion en el posentaje de votos en 5 estrellas

INSERT INTO resenia VALUES('210', '2018-09-28','Muy graciosa','5','1','200');


-- llamar al procedimiento

call calcularMetricasDeCalificacion(200);

-- Borrar el procedimiento en caso de error
DROP PROCEDURE IF EXISTS calcularMetricasDeCalificacion;
