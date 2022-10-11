-- --------------------------------------------------------------------
-- TEST CASE: recientementeVistas
-- DESCRIPCION: este procedimiento almacenado va a mostrar en pantalla 
-- las reproducciones que hizo un determinado usuario sobre una episodio
-- --------------------------------------------------------------------

-- IMPUT DATA SET
-- Inserto un nuevo cliente para ver su reproducciones (El mismo del test-1)
INSERT INTO cliente VALUES('250','Nai', 'RonNai', 'Nai@hola','1234','0800456','1995-11-10', 'F');

-- Relaciones de este nuevo cliente
-- El cliente es premium
INSERT INTO cliente_suscripto VALUES('250','3','2018-05-20');

-- El contenido que va a reprodicir y este va a ser un episodio
INSERT INTO contenido VALUES('260','Te vi','me estas viendo','Kyo Records','2018-09-21', 20,0);
INSERT INTO episodios VALUES('260');
INSERT INTO programa_tv VALUES('260','Htv','VesTv');

INSERT INTO episodio_es_de VALUES('260','260','2018-09-21',1);

-- Las reproducciones
INSERT INTO reproducciones VALUES(204,'2018-09-21', '250', '260');
INSERT INTO reproducciones VALUES(205,'2018-09-21', '250', '260');
INSERT INTO reproducciones VALUES(206,'2018-09-22', '250', '260');
INSERT INTO reproducciones VALUES(207,'2018-09-27', '250', '260');


-- llamar al procedimiento

call recientementeVistas(250, 260);

-- Borrar el procedimiento en caso de error
DROP PROCEDURE IF EXISTS recientementeVistas;
