-- --------------------------------------------------------------------------------
-- Consulta: Listar los datos de las películas donde el actor ‘X’ fue protagonista.
-----------------------------------------------------------------------------------

Select c.titulo, concat(e.nombre, ' ' , e.apellido) as protagonizada_por
from  contenido c, pelicula p, participantes_en pen, elenco e
where c.id_contenido = p.pelicula_id
	and e.id_elenco = pen.id_elenco
	and c.id_contenido = pen.contenido
	and pen.rol = "Protagonista"
	and e.sexo = "F";
