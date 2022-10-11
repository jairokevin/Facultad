DELIMITER //

CREATE TRIGGER actualizar_fecha_de_suscripcion
BEFORE UPDATE
   ON cliente_suscripto FOR EACH ROW

BEGIN

   -- variable declarations

   -- trigger code
 SET NEW.fecha_sus = SYSDATE() ; 

END; //

DELIMITER ;
