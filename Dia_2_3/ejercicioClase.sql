-- ###################################
-- ######### DIA 2 - MySQL 2 #########
-- ###################################

CREATE DATABASE mysql2_dia2;
USE mysql2_dia2;

CREATE TABLE productos(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    PRIMARY KEY(id)
);
-- TRUNCATE TABLE productos;
INSERT INTO productos VALUES
(1, "Pepito", 23.20),
(2, "MousePad", 100000.21),
(3, "Espionap", 2500.25),
(4, "BOB-ESPONJA", 1500.25),
(5, "Cary", 2354000.23),
(6, "OvuloAPP", 108780.23),
(7, "PapayaAPP", 2000.00),
(8, "Menosprecio", 3000.00),
(9, "PerfumeMascotas", 2200.00),
(10, "Perfume La Cumbre", 35000.25),
(11, "Nevera MBO", 3008.12),
(12, "Crema Suave", 2045.00),
(13, "juego de mesa La Cabellería", 9800.00),
(14, "Cargador iPhone", 98000.00);

-- Para crear una funcion la cual retorne el
-- nombre del producto con el precio mas iva (%19)
-- Donde si vale más de 1000 se aplica un descuento del 20%
delimiter //
create function TotalConIVA(precio decimal(10,2),iva decimal(5,3))
returns decimal(10,2) deterministic
begin
    if precio > 1000 then
        return (precio+(precio*iva))-((precio+(precio*iva))*0.2);
    else
        return precio+(precio*iva);
    end if;
end//
delimiter ;

-- Utilizar la función TotalConIVA
select TotalConIva(25000,0.19);
-- Eliminar funcion
-- DROP FUNCTION TotalConIva;

-- Extrapolar función con datos de la base de datos

SELECT TotalConIva(precio,0.19) FROM productos;

-- Función para obtener el precio de un producto 
-- dado su nombre

delimiter //
CREATE FUNCTION obtener_precio_producto(nombre_producto VARCHAR(100))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
	DECLARE precio_producto DECIMAL(10,2);
    SELECT precio INTO precio_producto FROM productos
    WHERE nombre = nombre_producto;
    RETURN precio_producto;
END//
delimiter ;

-- Usar función
SELECT obtener_precio_producto('Pepito') as Precio;


-- Función para obtener el precio de un producto (con su iva y promoción)
-- dado su nombre
delimiter //
Create function obtener_precio_producto_prom(nombre_producto varchar(100))
returns decimal (10,2)
deterministic
begin
    declare precio_producto decimal(10,2);
    select TotalConIva(precio,0.19) into precio_producto from productos 
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;
select obtener_precio_producto_prom('Pepito') as Precio;

-- Función par calcular el precio promedio de todos los productos
delimiter //
CREATE FUNCTION precio_promedio_productos()
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL (10,2);
    SELECT AVG(precio) INTO promedio FROM productos;
    RETURN promedio;
END//
delimiter ;

SELECT precio_promedio_productos();

-- Procedimiento para insertar un nuevo producto
delimiter //
CREATE PROCEDURE insertar_producto(in nombre_producto VARCHAR(100)
, IN precio_producto decimal(10,2))
BEGIN
	INSERT INTO productos (nombre,precio)
    VALUES (nombre_producto,precio_producto);
END//
delimiter ;

call insertar_producto('Gorra', 50000.00);

-- Procedimiento para eliminar un producto dado su nombre

delimiter //
CREATE PROCEDURE eliminar_producto (IN nombre_producto VARCHAR(100))
BEGIN
	DELETE FROM productos WHERE nombre=nombre_producto;
END//
delimiter ;

CALL eliminar_producto('Gorra');
