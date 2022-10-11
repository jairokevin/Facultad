-- --------------------------------------------------------------------
-- TEST CASE: actualizar_calificacion_promedio
-- DESCRIPCION: actualizando calificacion promedio de una pelicula 
-- --------------------------------------------------------------------

-- IMPUT DATA SET

INSERT INTO contenido VALUES('230','Estrellas','Para actualizar estrellas', 'Cual Records', '2018-09-09',20,0);
INSERT INTO pelicula VALUES('230');

-- Se agrega una reseña 
-- Supongo que un cliente con nombre de cliente 200 realiza una reseña
-- sobre un contenido de id 230 y califica con 3 estrellas
-- Espero que la calificacion sea 3 

INSERT INTO resenia VALUES('220', '2018-08-28','Comun','3','200','230' );
