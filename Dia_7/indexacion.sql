-- ###################################
-- ######### DIA 7 - MySQL 2 #########
-- ###################################

-- 1. Escribe una consulta que permita agrupar los clientes de todos los empleados
-- cuyo puesto sea responsable de ventas. Se requiere que la consulta muestre:
-- Nombre del cliente, teléfono, la ciudad, nombre y primer apellido del responsable
-- de ventas y su email.

SELECT 
    c.nombre_cliente, 
    c.telefono, 
    c.ciudad, 
    e.nombre AS nombre_responsable, 
    e.apellido1 AS apellido_responsable, 
    e.email
FROM cliente c
JOIN 
    empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE 
    e.puesto = 'responsable de ventas';

-- 2- Se necesita obtener los registros de los pedidos entre el 15 de marzo del 2009 y
-- el 15 de julio del 2009, para todos los clientes que sean de la ciudad de
-- Sotogrande. Se requiere mostrar el código del pedido, la fecha del pedido, fecha
-- de entrega, estado, los comentarios y el condigo del cliente que realizo dicho
-- pedido.

SELECT 
    p.codigo_pedido, 
    p.fecha_pedido, 
    p.fecha_esparada, 
    p.estado, 
    p.comentarios, 
    p.codigo_cliente
FROM pedido p
JOIN 
cliente c on p.codigo_cliente = c.codigo_cliente
WHERE 
    c.ciudad = 'Sotogrande' AND p.fecha_pedido BETWEEN '2009-03-15' AND '2009-07-15';

-- 3- Se desea obtener los productos cuya gama pertenezca a las frutas y que el
-- proveedor sea Frutas Talaveras S.A, se desea mostrar el código, nombre,
-- descripción, cantidad en stock, y su precio con 10% de descuento, de igual forma
-- se pide la cantidad en los distintos pedidos que se han hecho.

SELECT 
    p.codigo_producto, 
    p.nombre, 
    p.descripcion, 
    p.cantidad_en_stock, 
    p.precio_venta * 0.9 AS precio_con_descuento, 
    dp.cantidad
FROM producto p
JOIN 
    detalle_pedido dp on p.codigo_producto = dp.codigo_producto
WHERE 
    p.gama = 'frutas' AND p.proveedor = 'Frutas Talaveras S.A';


-- INDEXACIÓN

CREATE INDEX name_garden ON empleado (nombre, apellido1);
CREATE INDEX 

-- Desarrollado por Kenia Yulieth Hernández Díaz / ID.1.098.386.069