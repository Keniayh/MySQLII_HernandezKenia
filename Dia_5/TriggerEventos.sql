-- TRIGGERS

-- Trigger para Restringir Actualización de Vehículos Alquilados

DELIMITER //

CREATE TRIGGER restringir_actualizacion_vehiculos
BEFORE UPDATE ON Vehiculos
FOR EACH ROW
BEGIN
    DECLARE vehiculo_alquilado INT;

    SELECT COUNT(*) INTO vehiculo_alquilado
    FROM Alquileres
    WHERE id_vehiculo = OLD.id;

    IF vehiculo_alquilado > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede actualizar el vehículo. Está actualmente alquilado.';
    END IF;
END //

DELIMITER ;

-- Registrar Alquileres en el historial

-- Crear la tabla HistorialAlquileres
CREATE TABLE HistorialAlquileres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT,
    id_cliente INT,
    id_vehiculo INT,
    fecha_alquiler DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_alquiler) REFERENCES Alquileres(id),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id)
);

-- Trigger para registrar alquileres en el historial
DELIMITER //

CREATE TRIGGER registrar_alquiler_historial
AFTER INSERT ON Alquileres
FOR EACH ROW
BEGIN
    INSERT INTO HistorialAlquileres (id_alquiler, id_cliente, id_vehiculo, fecha_alquiler, valor_total)
    VALUES (NEW.id, NEW.id_cliente, NEW.id_vehiculo, NEW.fecha_sal, NEW.valor_total);
END //

DELIMITER ;

-- Esadisticas sucursales

-- Crear la tabla EstadisticasSucursales
CREATE TABLE EstadisticasSucursales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT,
    total_alquileres INT DEFAULT 0,
    total_ingresos DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id)
);

-- Trigger para actualizar estadísticas de sucursales
DELIMITER //

CREATE TRIGGER actualizar_estadisticas_sucursales
AFTER INSERT ON Alquileres
FOR EACH ROW
BEGIN
    DECLARE total_alquileres INT;
    DECLARE total_ingresos DECIMAL(10, 2);

    -- Obtener el total de alquileres y el total de ingresos de la sucursal
    SELECT COUNT(*), SUM(valor_total)
    INTO total_alquileres, total_ingresos
    FROM Alquileres
    WHERE id_suc_sal = NEW.id_suc_sal;

    -- Actualizar las estadísticas de la sucursal
    UPDATE EstadisticasSucursales
    SET total_alquileres = total_alquileres,
        total_ingresos = total_ingresos
    WHERE id_sucursal = NEW.id_suc_sal;
END //

DELIMITER ;

