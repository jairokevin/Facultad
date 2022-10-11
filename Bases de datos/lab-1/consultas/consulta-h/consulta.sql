-- -----------------------------------------------------------------------
-- Consulta:Listar las películas mejor calificadas en los últimos 6 meses.
-- Usar la “calificación promedio”.
--------------------------------------------------------------------------

select c4.titulo, r4.fecha, r4.calificacion
from resenia r4, contenido c4 , pelicula p4,
    (Select n.titulo, (sum(n.valor) /sum(n.votos)) as promedio
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
    group by  n.titulo) n2
where r4.contenido = c4.id_contenido
  and c4.id_contenido = p4.pelicula_id
  and r4.fecha >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
  and r4.calificacion >= n2.promedio;
