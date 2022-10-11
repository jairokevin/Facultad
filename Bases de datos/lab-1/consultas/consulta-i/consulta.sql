-- --------------------------------------------------------------------------
-- CONSULTA: Listar las películas dirigidas por dos o más directores femeninos.
-- ---------------------------------------------------------------------------

select c.titulo, concat(e.nombre, ' ' , e.apellido) as dirigida_por
from  contenido c, pelicula p, participantes_en pen, elenco e
where c.id_contenido = p.pelicula_id
  and e.id_elenco = pen.id_elenco
  and c.id_contenido = pen.contenido
  and pen.rol = "director"
  and e.sexo = "F"
  and 1 < (select count(*)
              from participantes_en pen2
              where c.id_contenido = pen2.contenido)
;
