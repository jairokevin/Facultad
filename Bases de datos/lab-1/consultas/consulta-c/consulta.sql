-- ----------------------------------------------------------------------------------
-- Consulta: Listar los episodios correspondientes a un programa de televisión X y un
-- número de temporada N. Listar ordenados por fecha de lanzamiento.
-------------------------------------------------------------------------------------

Select c.titulo, ptv.titulo, ep.numero_temporada, c.fecha_de_lanzamiento
from programa_tv ptv, episodio_es_de ep, episodios e, contenido c
where ptv.id_programa = ep.programa_tv
	 and e.episodios_id = ep.episodio
	 and c.id_contenido = e.episodios_id
	 and ptv.titulo = 'VesTv'
order by c.fecha_de_lanzamiento asc


