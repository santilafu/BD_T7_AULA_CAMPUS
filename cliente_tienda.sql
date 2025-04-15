 -- CREAR EL TIPO OBJETO tNOMBRE
 CREATE OR REPLACE TYPE tNOMBRE AS OBJECT (
    nombre VARCHAR2(50),
    apellido1 VARCHAR2(50),
    apellido2 VARCHAR2(50),
    MEMBER FUNCTION getApellidosNombre RETURN VARCHAR2,
    MEMBER FUNCTION getNombreApellidos RETURN VARCHAR2
    );
/
-- IMPLEMENTAR LOS METODOS DEL TIPO OBJETO tNOMBRE
-- Este bloque es el cuerpo del tipo objeto tNOMBRE, donde se implementan los métodos definidos en la especificación.
CREATE OR REPLACE TYPE BODY tNOMBRE AS
    MEMBER FUNCTION getApellidosNombre RETURN VARCHAR2 IS
    BEGIN
        RETURN apellido1 || ' ' || apellido2 || ', ' || nombre;
    END getApellidosNombre;
    
    MEMBER FUNCTION getNombreApellidos RETURN VARCHAR2 IS
    BEGIN
        RETURN nombre || ' ' || apellido1 || ' ' || apellido2;
    END getNombreApellidos;
END;
/
--CREAR 
-- CREAR LA TABLA CLIENTE
-- Esta tabla almacena información sobre los clientes, incluyendo un campo de tipo objeto tNOMBRE para el nombre completo.
CREATE TABLE CLIENTE (
    id_cliente NUMBER(10) NOT NULL,
    nombrecompleto tNOMBRE,
    direccion VARCHAR2(100),
    telefono VARCHAR2(15)
);

-- ACTUALIZAMOS LA TABLA CLIENTE PARA INTRODUCIR NIF
-- Aquí se actualiza la tabla CLIENTE para agregar un nuevo campo llamado nif, que es un VARCHAR2 de 9 caracteres.
ALTER TABLE CLIENTE ADD (nif VARCHAR2(9));



-- INSERTAR DATOS EN LA TABLA CLIENTE
-- Aquí se insertan algunos registros de ejemplo en la tabla CLIENTE, utilizando el tipo objeto tNOMBRE para el campo nombrecompleto.
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (1, tNOMBRE('Juan', 'Pérez', 'Gómez'), 'Calle Falsa 123', '683502112');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (2, tNOMBRE('María', 'López', 'García'), 'Avenida Siempre Viva 456', '683502113');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (3, tNOMBRE('Pedro', 'Gómez', 'Martínez'), 'Calle de la Paz 789', '683502114');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (4, tNOMBRE('Ana', 'Fernández', 'Sánchez'), 'Calle del Sol 101', '683502115');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (5, tNOMBRE('Luis', 'Martínez', 'Torres'), 'Calle Luna 202', '683502116');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (6, tNOMBRE('Laura', 'García', 'Hernández'), 'Calle Estrella 303', '683502117');

--ACTUALIZAMOS EL CAMPO NIF YA QUE NO EXISTE EN EL INSERT
-- Aquí se actualizan los registros de la tabla CLIENTE para agregar un NIF a cada cliente.

UPDATE CLIENTE SET nif ='123456A' WHERE id_cliente = 1;
UPDATE CLIENTE SET nif ='234567B' WHERE id_cliente = 2;
UPDATE CLIENTE SET nif ='345678C' WHERE id_cliente = 3;
UPDATE CLIENTE SET nif ='456789D' WHERE id_cliente = 4;
UPDATE CLIENTE SET nif ='567890E' WHERE id_cliente = 5;
UPDATE CLIENTE SET nif ='678901F' WHERE id_cliente = 6;

-- VERIFICAR QUE SE HAN INSERTADO LOS DATOS EN LA TABLA CLIENTE
-- Aquí se seleccionan todos los registros de la tabla CLIENTE para verificar que se han insertado correctamente.
SELECT * FROM CLIENTE;

-- ACTUALIZAMOS EL CAMPO nombrecompleto PARA LOS 6 CLIENTES Y CAMBIAMOS EL ID-CLIENTE A NIF
-- Aquí se actualizan los registros de la tabla CLIENTE para cambiar el campo nombrecompleto a un nuevo formato.
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('Juan', 'Pérez', 'Gómez') WHERE id_cliente = 1;
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('María', 'López', 'García') WHERE id_cliente = 2;
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('Pedro', 'Gómez', 'Martínez') WHERE id_cliente = 3;
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('Ana', 'Fernández', 'Sánchez') WHERE id_cliente = 4;
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('Luis', 'Martínez', 'Torres') WHERE id_cliente = 5;
UPDATE CLIENTE SET nombrecompleto = tNOMBRE('Laura', 'García', 'Hernández') WHERE id_cliente = 6;

-- VERIFICAR QUE SE HAN INSERTADO LOS DATOS EN LA TABLA CLIENTE
SELECT * FROM CLIENTE;

-- PROBAR LOS MÉTODOS DEL TIPO OBJETO tNOMBRE
-- Aquí se muestran ejemplos de cómo llamar a los métodos del tipo objeto tNOMBRE para obtener el nombre completo en diferentes formatos.
-- VER NOMBRE EN FORMATO "Apellido1 Apellido2, Nombre"
SELECT c.nombrecompleto.getApellidosNombre() AS NOMBRECOMPLETO
FROM CLIENTE c
WHERE c.id_cliente = 1;
SELECT c.nombrecompleto.getNombreApellidos() AS NOMBRECOMPLETO 
FROM CLIENTE c 
WHERE c.id_cliente = 1;
-- ver todos los clientes con todos los datos
SELECT c.id_cliente, c.nombrecompleto.getApellidosNombre() AS "APELLIDOS Y NOMBRE", c.direccion,c.telefono,
 c.nombrecompleto.getNombreApellidos() as "NOMBRE Y APELLIDOS"
FROM CLIENTE c;
-- ver todos los clientes con todos los datos y el nif
SELECT c.id_cliente, c.direccion,c.telefono,
 c.nombrecompleto.getNombreApellidos() as "NOMBRE Y APELLIDOS",c.nif FROM CLIENTE c;