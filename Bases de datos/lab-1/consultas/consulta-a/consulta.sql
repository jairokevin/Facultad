-- ----------------------------------------------------------------------------
-- Consulta: Listar los datos de los clientes suscritos al plan PREMIUM con una
-- determinada fecha de suscripción.
-------------------------------------------------------------------------------
-- Suposición la fecha de suscripción es: 2016-05-20.

Select id, nombre, plan, fecha
from cliente_suscripto
where plan = Premium
	and fecha = '2016-05-20';
