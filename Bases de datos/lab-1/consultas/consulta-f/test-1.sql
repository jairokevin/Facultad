-- --------------------------------------------------------------------
-- TEST CASE: Consultar porsentaje calificaciones
-- DESCRIPCION: Porsentaje de estrellas de la pelicula "Las cualsitas"
-- --------------------------------------------------------------------

-- IMPUT DATA SET
INSERT INTO contenido VALUES('200','Las cualsitas','Hay perros que mantan', 'Cual Records', '2018-09-09',45,0);
INSERT INTO contenido VALUES('201','Hola mundo','nada', 'Cual Records', '2018-12-09',40,0);
INSERT INTO contenido VALUES('202','lluvia','hoy llueve', 'Kyo Records', '2018-04-20',60,0);
INSERT INTO contenido VALUES('203','Los enanos','NA', 'Kyo Records', '2017-09-09',90,0);

INSERT INTO pelicula VALUES('200');
INSERT INTO pelicula VALUES('201');
INSERT INTO pelicula VALUES('202');
INSERT INTO pelicula VALUES('203');

INSERT INTO resenia VALUES('200', '2018-09-28','Muy graciosa','5','1','200' );
INSERT INTO resenia VALUES('201', '2018-09-28','Estandar','3','2','200' );
INSERT INTO resenia VALUES('202', '2018-09-01','Pedorra','1','4','200' );
INSERT INTO resenia VALUES('203', '2018-09-28','Muy buena','4','8','200' );
INSERT INTO resenia VALUES('204', '2018-08-28','Comun','3','3','200' );

