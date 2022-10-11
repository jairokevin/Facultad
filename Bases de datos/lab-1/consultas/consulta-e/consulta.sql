-- ------------------------------------------------------------------------------------
-- Consulta: Listar los actores que hayan actuado en películas que pertenecen a géneros
-- de drama o comedia, ordenados por orden alfabético.
---------------------------------------------------------------------------------------

select cont.titulo, elen.nombre
from elenco elen, contenido cont, genero_contenido gen, participantes_en part
where gen.contenido_multimedia = cont.id_contenido
	and gen.genero = 'Comedia'
	and gen.genero = 'Drama'
	and part.contenido = elen.id_elenco
	order by cont.titulo, elen.nombre

