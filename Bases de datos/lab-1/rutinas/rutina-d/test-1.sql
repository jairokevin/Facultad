-- --------------------------------------------------------------------
-- TEST CASE: peliculas recientemente Vistas
-- DESCRIPCION: este procedimiento almacenado va a mostrar en pantalla 
-- las reproducciones que hizo un determinado usuario sobre una pelicula
-- --------------------------------------------------------------------

-- IMPUT DATA SET
-- Inserto un nuevo cliente para ver su reproducciones 
INSERT INTO cliente VALUES('250','Nai', 'RonNai', 'Nai@hola','1234','0800456','1995-11-10', 'F');

-- Relaciones de este nuevo cliente
-- El cliente es premium
INSERT INTO cliente_suscripto VALUES('250','3','2018-05-20');

-- El contenido que va a reprodicir y este va a ser una pelicula
INSERT INTO contenido VALUES('250','Te vi','me estas viendo','Kyo Records','2018-09-21', 60,0);
INSERT INTO contenido VALUES('251','Ni te vi','NO me estas viendo','Kyo Records','2018-09-21', 60,0);
INSERT INTO pelicula  VALUES('250');
INSERT INTO pelicula  VALUES('251');

-- Las reproducciones
INSERT INTO reproducciones VALUES(200,'2018-09-21', '250', '250');
INSERT INTO reproducciones VALUES(201,'2018-09-21', '250', '250');
INSERT INTO reproducciones VALUES(202,'2018-09-22', '250', '250');
INSERT INTO reproducciones VALUES(203,'2018-09-27', '250', '250');

INSERT INTO reproducciones VALUES(208,'2018-10-02', '1', '250');
INSERT INTO reproducciones VALUES(209,'2018-09-30', '1', '250');
INSERT INTO reproducciones VALUES(210,'2018-09-27', '2', '250');
INSERT INTO reproducciones VALUES(211,'2018-09-22', '8', '250');

INSERT INTO reproducciones VALUES(212,'2018-09-01', '8', '251');

-- Generos de esa pelicula 
INSERT INTO genero_contenido VALUES('comedia', '250');
INSERT INTO genero_contenido VALUES('romance', '250');


-- Generos de peliculas ya cargadas 
INSERT INTO genero_contenido VALUES('comedia', '200');
INSERT INTO genero_contenido VALUES('comedia', '201');
INSERT INTO genero_contenido VALUES('romance', '208');
INSERT INTO genero_contenido VALUES('terror', '202');

-- llamar al procedimiento

call recientementeVistas(250, 202);

-- Borrar el procedimiento en caso de error
DROP PROCEDURE IF EXISTS recientementeVistas;
