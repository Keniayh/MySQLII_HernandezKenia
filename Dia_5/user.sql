-- CREATE USERS
-- #####################################
-- Usar la base de datos
USE AutoRental;


CREATE USER 'administrador'@'%' IDENTIFIED BY 'admin123';
GRANT SELECT, INSERT, UPDATE, DELETE ON AutoRental.* TO 'administrador'@'%';

CREATE USER 'empleadoSucursal'@'%' IDENTIFIED BY 'empleado123';
GRANT SELECT, INSERT, UPDATE ON AutoRental.Vehiculos TO 'empleadoSucursal'@'%';
GRANT SELECT, INSERT ON AutoRental.Alquileres TO 'empleadoSucursal'@'%';

CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente123';
GRANT SELECT, INSERT ON AutoRental.Alquileres TO 'cliente'@'%';
GRANT SELECT ON AutoRental.Vehiculos TO 'cliente'@'%';

CREATE USER 'atencionPublico'@'%' IDENTIFIED BY 'publico123';
GRANT SELECT ON AutoRental.Vehiculos TO 'atencionPublico'@'%';
GRANT SELECT ON AutoRental.Clientes TO 'atencionPublico'@'%';

-- Desarrollado por Kenia Yulieth Hernández Díaz / ID.1.098.386.069