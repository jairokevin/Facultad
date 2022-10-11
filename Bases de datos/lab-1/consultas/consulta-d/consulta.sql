-- ----------------------------------------------------------------------------------
-- Consulta: Listar los reviews hechos por un cliente X dentro de un rango de fechas.
-------------------------------------------------------------------------------------

select res.fecha, res.descripcion, res.calificacion

from cliente cl, resenia res
where cl.nombre_usuario = res.cliente
	and res.fecha between '2018-04-15' and '2018-10-25'
	and cl.nombre_usuario = '1';

