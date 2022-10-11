DELIMITER //

CREATE TRIGGER actualizar_calificacion_promedio
AFTER INSERT
   ON resenia FOR EACH ROW

BEGIN

  declare vpromedio float;
  SET vpromedio = (Select (sum(n.valor) /sum(n.votos))
                   from (Select r.calificacion "estrellas", 
                           (select count(r2.calificacion) * r.calificacion 
                              from resenia r2 
                              where r2.calificacion = r.calificacion 
                                and r2.contenido = r.contenido) as valor,
                            (select count(r3.calificacion) 
                               from resenia r3
                              where r3.calificacion = r.calificacion 
                                and r3.contenido = r.contenido) as votos
                        from resenia r, contenido c , pelicula p
                        where r.contenido = c.id_contenido
                          and c.id_contenido = p.pelicula_id
                          and p.pelicula_id = pelicula_id) n);

  update contenido con set con.calificacion = vpromedio where con.id_contenido = new.contenido;


END; //

DELIMITER ;
