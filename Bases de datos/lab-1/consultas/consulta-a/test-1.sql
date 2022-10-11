use mysql_g9;

INSERT INTO cliente VALUES('1','John', 'Smith', 'jhon@hola.com','1234','35125855','1965-01-09', 'M');

INSERT INTO cliente VALUES('2','Jennifer', 'Jackson', 'jennifer@hola.com','12345','35123855','1978-04-10', 'F');

INSERT INTO cliente VALUES('3','Matthew', 'King', 'matthew@hola.com','123456','35123755','1978-05-15', 'M');

INSERT INTO cliente VALUES('4','Monica', 'Jones', 'monica@hola.com','1234567','35124715','1985-08-27', 'F');

INSERT INTO cliente VALUES('8','Jennifer', 'Jackson', '1234@hola.com','12345','7252','2000-04-10', 'F');


INSERT INTO empleado VALUES('20','Michael', 'Martin', 'michael@hola.com','2345');
INSERT INTO empleado VALUES('21','John', 'Smith', 'johnsmith@hola.com','1234');
INSERT INTO empleado VALUES('22','John', 'Davies', 'johndavies@hola.com','1784');
INSERT INTO empleado VALUES('23','Thalia', 'Williams', 'me_oyen@escuchan.com','0987756');

INSERT INTO telefono_empleado VALUES('20','0800222');
INSERT INTO telefono_empleado VALUES('20','482475');
INSERT INTO telefono_empleado VALUES('23','35184582');
INSERT INTO telefono_empleado VALUES('21','23344');

INSERT INTO cliente_suscripto VALUES('1','1','2018-04-10');
INSERT INTO cliente_suscripto VALUES('2','2','2015-01-10');
INSERT INTO cliente_suscripto VALUES('3','3','2016-05-20');
INSERT INTO cliente_suscripto VALUES('8','3','2016-05-20');
INSERT INTO cliente_suscripto VALUES('4','1','2018-04-10');

INSERT INTO plan VALUES('1','basico', 150);
INSERT INTO plan VALUES('2','estandar', 200);
INSERT INTO plan VALUES('3','premium',300);
