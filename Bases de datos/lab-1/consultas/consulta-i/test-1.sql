-- --------------------------------------------------------------------
-- TEST CASE: se agrega personal del elenco asociado a las pelicula ya 
-- existentes 
-- DESCRIPCION: 
-- --------------------------------------------------------------------

-- IMPUT DATA SET
INSERT INTO elenco VALUES('Sonia','Cartonn', '1987-09-28','200','www.SoniaCartonn.com','F');

INSERT INTO elenco VALUES('Marta','Cartonn', '1987-01-28','201','www.May.com','F');
INSERT INTO elenco VALUES('Elisa','Molo', '2001-04-13','202','www.Ely.com','F');
INSERT INTO elenco VALUES('Marco','Facho', '1998-09-28','203','www.marchi.com','M');
INSERT INTO elenco VALUES('Tom','Soria', '1960-09-28','204','www.Ton.com','M');
INSERT INTO elenco VALUES('Sonia','Vega', '1989-05-28','205','www.SonV.com','F');

INSERT INTO participantes_en VALUES('200','director','200');
INSERT INTO participantes_en VALUES('201','director','202');
INSERT INTO participantes_en VALUES('202','director','201');
INSERT INTO participantes_en VALUES('203','director','200');
INSERT INTO participantes_en VALUES('204','director','204');
INSERT INTO participantes_en VALUES('205','director','203');
