-- -----------------------------------------------------------------------
-- Consulta: Dada una película X, calcular su “calificación promedio”. Para 
-- calcular la calificación promedio en términos de 5 estrellas usar la media
-- ponderada como se describe en
--------------------------------------------------------------------------

--Ver formula
--Select n.titulo, (sum(n.valor) /sum(estrellas)) as promedio
--from (Select c.titulo "titulo" ,r.calificacion "estrellas", 
--            (select count(r2.calificacion) * r.calificacion 
--               from resenia r2 
--               where r2.calificacion = r.calificacion 
--                and r2.contenido = r.contenido) as valor
--      from resenia r, contenido c , pelicula p
--      where r.contenido = c.id_contenido
--        and c.id_contenido = p.pelicula_id) n
--group by  n.titulo;


Select n.titulo, (sum(n.valor) /sum(n.votos)) as promedio
from (Select c.titulo "titulo" ,r.calificacion "estrellas", 
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
        and c.id_contenido = p.pelicula_id) n
group by  n.titulo;
