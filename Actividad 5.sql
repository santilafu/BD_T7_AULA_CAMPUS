-- -- CREAR UN TIPO OBJETO tDETALLE
-- -- -- Este tipo de objeto almacena información sobre un detalle de una venta, incluyendo el ID detalle, el producto, la cantidad y el precio unitario.
 CREATE OR REPLACE TYPE tDETALLE AS OBJECT (
     id_DETALLE NUMBER,
     producto VARCHAR2(50),
     cantidad NUMBER,
     precio_unitario NUMBER,
     MEMBER FUNCTION getPrecioTotal RETURN NUMBER
 );
 /
-- -- IMPLEMENTAR LOS METODOS DEL TIPO OBJETO tDETALLE
-- -- Este bloque es el cuerpo del tipo objeto tDETALLE, donde se implementan los métodos definidos en la especificación.
 CREATE OR REPLACE TYPE BODY tDETALLE AS
     MEMBER FUNCTION getPrecioTotal RETURN NUMBER IS
     BEGIN
         RETURN cantidad * precio_unitario;
     END getPrecioTotal;
 END;
 /
-- -- CREAR LA TABLA DETALLE
-- -- Esta tabla almacena información sobre los detalles de las ventas, incluyendo un campo de tipo objeto tDETALLE para el detalle completo.
 CREATE TABLE DETALLE OF tDETALLE (
     CONSTRAINT pk_detalle PRIMARY KEY (id_detalle)
 );

--
-- -- INSERTAR DATOS EN LA TABLA DETALLE
-- -- Aquí se insertan algunos registros de ejemplo en la tabla DETALLE, utilizando el tipo objeto tDETALLE para el campo detalle completo.
 INSERT INTO DETALLE VALUES (tDETALLE(1, 'Producto A', 2, 10.0));
 INSERT INTO DETALLE VALUES (tDETALLE(2, 'Producto B', 1, 20.0));
 INSERT INTO DETALLE VALUES (tDETALLE(3, 'Producto C', 5, 5.0));
 INSERT INTO DETALLE VALUES (tDETALLE(4, 'Producto D', 3, 15.0));
 INSERT INTO DETALLE VALUES (tDETALLE(5, 'Producto E', 4, 8.0));
 INSERT INTO DETALLE VALUES (tDETALLE(6, 'Producto F', 2, 12.0));

--
-- -- CONSULTAS
-- -- Aquí se realizan algunas consultas para obtener información sobre los detalles de las ventas.
-- -- Se seleccionan los productos, cantidades y precios totales de los detalles.
 SELECT d.producto, d.cantidad, d.getPrecioTotal() AS precio_total
 FROM DETALLE d;
-- --
-- -- ACTUALIZACION DE DATOS 
-- -- Aquí se actualizan algunos registros de la tabla DETALLE para modificar la cantidad y el precio unitario de un detalle específico.
 UPDATE DETALLE SET cantidad = 3, precio_unitario = 18.0 WHERE id_detalle = 2;
 UPDATE DETALLE SET cantidad = 4, precio_unitario = 6.0 WHERE id_detalle = 3;
 UPDATE DETALLE SET cantidad = 1, precio_unitario = 20.0 WHERE id_detalle = 4;

-- --
-- -- VERIFICAR QUE SE HAN ACTUALIZADO LOS DATOS EN LA TABLA DETALLE
-- -- Aquí se seleccionan todos los registros de la tabla DETALLE para verificar que se han actualizado correctamente.
 SELECT * FROM DETALLE;
