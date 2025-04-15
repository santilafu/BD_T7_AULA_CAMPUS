-- CREAR UN TIPO COLECCION (VARRAY) LLAMADO tDEPORTES PARA UN MAXIMO DE 15 DEPORTES
-- -- Este tipo de colección almacena una lista de deportes, con un tamaño máximo de 15 elementos.
CREATE OR REPLACE TYPE tDEPORTES AS VARRAY(15) OF VARCHAR2(50);

-- AÑADIMOS EL CAMPO DE DEPORTES A LA TABLA CLIENTE
ALTER TABLE CLIENTE ADD (deportes tDEPORTES);

-- -- AÑADIMOS LOS DEPORTES A CADA CLIENTE
-- -- Aquí se actualizan los registros de la tabla CLIENTE para agregar una lista de deportes a cada cliente.
UPDATE CLIENTE SET deportes = tDEPORTES('Fútbol', 'Baloncesto', 'Tenis') WHERE id_cliente = 1;
UPDATE CLIENTE SET deportes = tDEPORTES('Natación', 'Ciclismo') WHERE id_cliente = 2;
UPDATE CLIENTE SET deportes = tDEPORTES('Fútbol', 'Tenis') WHERE id_cliente = 3;
UPDATE CLIENTE SET deportes = tDEPORTES('Baloncesto', 'Natación') WHERE id_cliente = 4;
UPDATE CLIENTE SET deportes = tDEPORTES('Ciclismo', 'Fútbol') WHERE id_cliente = 5;
UPDATE CLIENTE SET deportes = tDEPORTES('Tenis', 'Baloncesto') WHERE id_cliente = 6;

--
-- -- VERIFICAR QUE SE HAN INSERTADO LOS DEPORTES EN LA TABLA CLIENTE
SELECT 
  nif,
  c.nombrecompleto.getNombreApellidos() AS nombre,
  deportes
FROM CLIENTE c;
