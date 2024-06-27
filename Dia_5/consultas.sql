-- Consultas
-- #######################################

-- alquiler de vehiculos

SELECT * FROM Alquileres;


-- FUNCIONES

-- Si un cliente entrega el vehículo pasada la fecha de entrega contratada, se cobrarán los días
-- adicionales con un incremento del 8%.


delimiter //

CREATE FUNCTION calcular_valor_pagado(fecha_llegada DATE, fecha_esp_llegada DATE, valor_cotizado DECIMAL(10,2), valor_dia DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE dias_retraso INT;
    DECLARE valor_extra DECIMAL(10,2);

    IF fecha_llegada > fecha_esp_llegada THEN
        SET dias_retraso = DATEDIFF(fecha_llegada, fecha_esp_llegada);
        SET valor_extra = dias_retraso * valor_dia * 1.08;
        RETURN valor_cotizado + valor_extra;
    ELSE
        RETURN valor_cotizado;
    END IF;
END //

delimiter ;
-- test

SELECT calcular_valor_pagado('2024-06-30', '2024-06-25', 500.00, 50.00) AS valor_pagado;

-- Desarrollado por Kenia Yulieth Hernández Díaz / ID.1.098.386.069