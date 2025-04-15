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
-- CREAR LA TABLA CLIENTE
-- Esta tabla almacena información sobre los clientes, incluyendo un campo de tipo objeto tNOMBRE para el nombre completo.
CREATE TABLE CLIENTE (
    id_cliente NUMBER(10) NOT NULL,
    nombrecompleto tNOMBRE,
    direccion VARCHAR2(100),
    telefono VARCHAR2(15)
);

-- INSERTAR DATOS EN LA TABLA CLIENTE
-- Aquí se insertan algunos registros de ejemplo en la tabla CLIENTE, utilizando el tipo objeto tNOMBRE para el campo nombrecompleto.
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (1, tNOMBRE('Juan', 'Pérez', 'Gómez'), 'Calle Falsa 123', '683502112');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (2, tNOMBRE('María', 'López', 'García'), 'Avenida Siempre Viva 456', '683502113');
INSERT INTO CLIENTE (id_cliente, nombrecompleto, direccion, telefono) VALUES (3, tNOMBRE('Pedro', 'Gómez', 'Martínez'), 'Calle de la Paz 789', '683502114');

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