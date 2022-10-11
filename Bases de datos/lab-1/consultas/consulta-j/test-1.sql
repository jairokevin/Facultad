-- --------------------------------------------------------------------
-- TEST CASE: listar actores
-- DESCRIPCION: llenar tablas participan_en con actores, epesodios y
-- pregramas de tv
-- --------------------------------------------------------------------

-- IMPUT DATA SET
INSERT INTO elenco VALUES('Mercedes','Ven', '2000-01-07','206','www.MercedesVen.com','F');
INSERT INTO elenco VALUES('Mari','Huana', '1980-09-21','207','www.MariHuana.com','F');
INSERT INTO elenco VALUES('Marcos','Vega', '1989-11-18','208','www.MarMarV.com','M');
INSERT INTO elenco VALUES('Coca','Cola', '1998-07-23','209','www.CocaCola.com','M');
INSERT INTO elenco VALUES('Marquitos','Vola', '1991-03-24','210','www.MarquitosVola.com','M');
INSERT INTO elenco VALUES('Kna','Vy', '1999-06-28','211','www.knaVy.com','F');
INSERT INTO elenco VALUES('NoMer','Vay', '1999-06-28','212','www.noTrabajoconMercedes.com','F');


INSERT INTO contenido VALUES('205','Me aburro',' que lo que', 'Cual Records', '2018-09-09',20,0);
INSERT INTO contenido VALUES('206','Me aburro 2',' que lo que', 'Cual Records', '2018-09-10',20,0);
INSERT INTO contenido VALUES('207','Ven ven',' buscando que hacer', 'Cual Records', '2018-09-11',30,0);
INSERT INTO contenido VALUES('208','Emperador','Anios atras', 'Kyo Records', '2018-09-12',25,0);
INSERT INTO contenido VALUES('209','Emperatris','Anios atras', 'Kyo Records', '2018-09-13',25,0);
INSERT INTO contenido VALUES('210','Fin','se termina el anio', 'Kyo Records', '2018-09-14',40,0);
INSERT INTO contenido VALUES('211','soloNoMEr','solo MEr', 'Kyo Records', '2018-09-14',40,0);


INSERT INTO participantes_en VALUES('206','protagonista','209');
INSERT INTO participantes_en VALUES('206','secundario','207');
INSERT INTO participantes_en VALUES('206','protagonista','210');
INSERT INTO participantes_en VALUES('207','secundario','209');
INSERT INTO participantes_en VALUES('208','secundario','209');
INSERT INTO participantes_en VALUES('209','secundario','209');
INSERT INTO participantes_en VALUES('210','secundario','209');
INSERT INTO participantes_en VALUES('211','secundario','209');
INSERT INTO participantes_en VALUES('212','protagonista','211');


INSERT INTO episodios VALUES('205');
INSERT INTO episodios VALUES('206');
INSERT INTO episodios VALUES('207');
INSERT INTO episodios VALUES('208');
INSERT INTO episodios VALUES('209');
INSERT INTO episodios VALUES('210');
INSERT INTO episodios VALUES('211');


INSERT INTO programa_tv VALUES('200','Cual moves','No lo vas a ver');
INSERT INTO programa_tv VALUES('201','Cual moves','Mirame');
INSERT INTO programa_tv VALUES('202','Cual moves','Idas');
INSERT INTO programa_tv VALUES('203','Cual moves','Perdida');

INSERT INTO episodio_es_de VALUES('205','202','2018-09-13',1);
INSERT INTO episodio_es_de VALUES('206','202','2018-10-13',1);
INSERT INTO episodio_es_de VALUES('207','202','2018-09-12',1);
INSERT INTO episodio_es_de VALUES('208','202','2018-09-12',1);
INSERT INTO episodio_es_de VALUES('209','200','2018-09-12',1);
INSERT INTO episodio_es_de VALUES('210','201','2018-09-12',1);
INSERT INTO episodio_es_de VALUES('211','203','2018-09-12',4);

-- NoMer no debe aparecer en la consulta ya que no trabaja con ningun otro actor 
-- y la consulta es con Mercedes ven que es una actriz de varios episodios

