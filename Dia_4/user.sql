-- Creación de roles
use AutoRental;
CREATE ROLE usuario_gestion;
CREATE ROLE atencion_publico;
CREATE ROLE cliente;

-- Otorgar permisos a los roles

GRANT SELECT, INSERT, UPDATE, DELETE ON AutoRental.* TO usuario_gestion;
GRANT SELECT ON AutoRental.* TO atencion_publico;
GRANT SELECT ON AutoRental.* TO cliente;

-- Creación de usuario para gestión interna
CREATE USER 'usuario_gestion'@'172.16.101.160' IDENTIFIED BY '|2VSoB2d@1d5';
GRANT usuario_gestion TO 'usuario_gestion'@'172.16.101.160';

-- Creación de usuario para atención al público
CREATE USER 'usuario_publico'@'172.16.101.160' IDENTIFIED BY 'S3gura!2024';
GRANT atencion_publico TO 'usuario_publico'@'172.16.101.160';

-- Creación de usuario para clientes
CREATE USER 'usuario_cliente'@'172.16.101.160' IDENTIFIED BY 'S3gura!2025';
GRANT cliente TO 'usuario_cliente'@'172.16.101.160';