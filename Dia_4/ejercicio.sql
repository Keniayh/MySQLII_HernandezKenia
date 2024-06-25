CREATE DATABASE AutoRental;

USE AutoRental;

CREATE TABLE Sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(100),
    direccion VARCHAR(255),
    telefono_fijo VARCHAR(20),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT,
    cedula VARCHAR(20),
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    direccion_residencia VARCHAR(255),
    ciudad_residencia VARCHAR(100),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id)
);

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(20),
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    direccion_residencia VARCHAR(255),
    ciudad_residencia VARCHAR(100),
    celular VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE Vehiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50),
    placa VARCHAR(20),
    referencia VARCHAR(100),
    modelo YEAR,
    puertas INT,
    capacidad INT,
    sunroof BOOLEAN,
    motor VARCHAR(50),
    color VARCHAR(50)
);

CREATE TABLE Alquileres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT,
    id_cliente INT,
    id_empleado INT,
    id_suc_sal INT,
    fecha_sal DATE,
    id_suc_lleg INT,
    fecha_lleg DATE,
    fecha_esp_lleg DATE,
    valor_sem DECIMAL(10, 2),
    valor_dia DECIMAL(10, 2),
    porcentaje_descuento DECIMAL(5, 2),
    valor_cotizado DECIMAL(10, 2),
    valor_pagado DECIMAL(10, 2),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id),
    FOREIGN KEY (id_suc_sal) REFERENCES Sucursales(id),
    FOREIGN KEY (id_suc_lleg) REFERENCES Sucursales(id)
);
