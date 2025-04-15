--CREAR TIPO OBJETO tVENDEDOR
-- -- Este tipo de objeto almacena información sobre un vendedor, incluyendo su nombre completo y un campo de tipo objeto tNOMBRE para el nombre completo.
 CREATE OR REPLACE TYPE tVENDEDOR AS OBJECT (
  NIF VARCHAR2(9),
  NOMBRECOMPLETO tNOMBRE,
  DIRECCION VARCHAR2(100),
  TELEFONO VARCHAR2(15),
  ANTIGUEDAD DATE,
  TIPO_DE_CONTRATO VARCHAR2(50),
  MEMBER FUNCTION getMeses RETURN NUMBER
);
/

-- -- IMPLEMENTAR LOS METODOS DEL TIPO OBJETO tVENDEDOR
-- -- Este bloque es el cuerpo del tipo objeto tVENDEDOR, donde se implementan los métodos definidos en la especificación.

 CREATE OR REPLACE TYPE BODY tVENDEDOR AS
  MEMBER FUNCTION getMeses RETURN NUMBER IS
  BEGIN
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, ANTIGUEDAD));
  END getMeses;
END;
/

-- -- CREAR LA TABLA VENDEDOR
-- -- Esta tabla almacena información sobre los vendedores, incluyendo un campo de tipo objeto tVENDEDOR para el vendedor completo.
 CREATE TABLE VENDEDOR OF tVENDEDOR (
        NIF PRIMARY KEY
       
 );

--
-- -- INSERTAR DATOS EN LA TABLA VENDEDOR
-- -- Aquí se insertan algunos registros de ejemplo en la tabla VENDEDOR, utilizando el tipo objeto tVENDEDOR para el campo vendedor completo.
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('123456A', tNOMBRE('Santi', 'Pérez', 'Gómez'), 'Calle Republica 14', '680803512', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Indefinido'));
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('234567B', tNOMBRE('Micaela', 'López', 'García'), 'Avenida Suecia Viva 46', '692502113', TO_DATE('2019-05-15', 'YYYY-MM-DD'), 'Temporal'));
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('345678C', tNOMBRE('Alfonso', 'Gómez', 'Martínez'), 'Calle de la Solana 79', '683502334', TO_DATE('2018-03-10', 'YYYY-MM-DD'), 'Indefinido'));
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('456789D', tNOMBRE('ines', 'Fernández', 'Sánchez'), 'Calle Lliria 11', '783502115', TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'Indefinido'));
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('567890E', tNOMBRE('Lucia', 'Martínez', 'Torres'), 'Calle Luna 2', '683599116', TO_DATE('2017-11-30', 'YYYY-MM-DD'), 'Temporal'));
 INSERT INTO VENDEDOR VALUES (tVENDEDOR('678901F', tNOMBRE('Ramon', 'García', 'Hernández'), 'Calle Mare 303', '655502117', TO_DATE('2022-02-28', 'YYYY-MM-DD'), 'Indefinido'));
--
-- -- VERIFICAR QUE SE HAN INSERTADO LOS DATOS EN LA TABLA VENDEDOR
-- -- Aquí se seleccionan todos los registros de la tabla VENDEDOR para verificar que se han insertado correctamente.
 SELECT * FROM VENDEDOR;
--
-- -- CONSULTAS
-- -- Aquí se realizan algunas consultas para obtener información sobre los clientes y vendedores.
-- -- Se seleccionan los nombres completos de los clientes y vendedores, junto con su dirección y teléfono.
 SELECT v.nif,v.nombrecompleto.getApellidosNombre() AS nombre,
 v.getMeses() AS meses_trabajados
 FROM VENDEDOR v;
