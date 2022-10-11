-- -----------------------------------------------------------------------
-- Consulta: Dada una película X, calcular para cada estrella el porcentaje
-- de calificaciones recibidas en sus reviews.
--------------------------------------------------------------------------

Select n.titulo, n.clasificacion, n.porcentaje
from (Select c.titulo as titulo , r.calificacion "clasificacion", ((select count(r2.calificacion) 
                                   from resenia r2 
                                   where r2.calificacion = r.calificacion 
                                     and r2.contenido=r.contenido ) * 100) /
                                 (select count(r3.calificacion) 
                                    from resenia r3 
                                    where r3.contenido=r.contenido) as porcentaje
from resenia r, contenido c , pelicula p
where r.contenido = c.id_contenido
 and c.id_contenido = p.pelicula_id) n
group by  n.titulo, n.clasificacion, n.porcentaje
order by n.clasificacion asc;
