-- --------------------------------------------------------------------
-- TEST CASE: actualizar_fecha_de_suscripcion
-- DESCRIPCION: el cliente 200 tiene plan premium y lo actualizo a plan
-- basico
-- --------------------------------------------------------------------

-- IMPUT DATA SET

INSERT INTO cliente_suscripto VALUES('200','3','2016-05-20');


-- actualizo para disparar al trigger

update cliente_suscripto set plan = 1 where cliente = 200;
