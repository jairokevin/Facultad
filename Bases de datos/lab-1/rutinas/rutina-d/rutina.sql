DELIMITER //
CREATE PROCEDURE recientementeVistas(in usuario varchar(10),
                                     in producto int)
BEGIN
  declare ves_de_programa boolean default false;

  select exists(select 1
                 from episodios es_ep
                 where es_ep.episodios_id = producto)
  into ves_de_programa;

  select c.titulo, c.descripcion, c.productora, c.fecha_de_lanzamiento, c.duracion,
         c.calificacion
  from contenido c, genero_contenido g, (select g2.genero
                                         from genero_contenido g2
                                         where g2.contenido_multimedia = producto) genpro,
       reproducciones r
  where c.id_contenido = g.contenido_multimedia
    and genpro.genero = g.genero
    and r.contenido_rep = c.id_contenido
    and c.id_contenido <> producto
    and r.cliente <> usuario
    and r.fecha_reproduccion >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK);

END; //
DELIMITER ;
