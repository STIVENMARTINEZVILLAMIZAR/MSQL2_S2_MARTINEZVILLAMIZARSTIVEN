-- =====================================
-- CREAR BASE DE DATOS
-- =====================================
CREATE DATABASE IF NOT EXISTS veterinaria_patitas_felices;
USE veterinaria_patitas_felices;

-- =====================================
-- TABLA: PERSONA
-- =====================================
CREATE TABLE persona (
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(50),
    direccion VARCHAR(200),
    tipo_persona VARCHAR(50)
);

-- =====================================
-- TABLA: CLIENTE
-- =====================================
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

-- =====================================
-- TABLA: MEDICO
-- =====================================
CREATE TABLE medico (
    id_medico INT PRIMARY KEY,
    id_persona INT,
    especialidad VARCHAR(100),
    cedula_profesional VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

-- =====================================
-- TABLA: AUXILIAR
-- =====================================
CREATE TABLE auxiliar (
    id_auxiliar INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

-- =====================================
-- TABLA: VENDEDOR
-- =====================================
CREATE TABLE vendedor (
    id_vendedor INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

-- =====================================
-- TABLA: ANIMAL
-- =====================================
CREATE TABLE animal (
    id_animal INT PRIMARY KEY,
    categoria VARCHAR(100),
    raza VARCHAR(100)
);

-- =====================================
-- TABLA: MASCOTA
-- =====================================
CREATE TABLE mascota (
    id_mascota INT PRIMARY KEY,
    id_cliente INT,
    id_animal INT,
    nombre VARCHAR(100),
    edad VARCHAR(50),
    peso FLOAT,
    fecha_ingreso DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal)
);

-- =====================================
-- TABLA: SERVICIO
-- =====================================
CREATE TABLE servicio (
    id_servicio INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio FLOAT
);

-- =====================================
-- TABLA: CITA
-- =====================================
CREATE TABLE cita (
    id_cita INT PRIMARY KEY,
    id_mascota INT,
    id_medico INT,
    id_servicio INT,
    fecha_hora DATETIME,
    tipo_cita VARCHAR(50),
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

-- =====================================
-- TABLA: PROVEEDOR
-- =====================================
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(50)
);

-- =====================================
-- TABLA: PRODUCTO
-- =====================================
CREATE TABLE producto (
    id_producto INT PRIMARY KEY,
    id_proveedor INT,
    nombre VARCHAR(100),
    precio_venta FLOAT,
    stock_actual INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- =====================================
-- TABLA: PAQUETE
-- =====================================
CREATE TABLE paquete (
    id_paquete INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio_paquete FLOAT
);

-- =====================================
-- DETALLE PAQUETE – PRODUCTO (N–N)
-- =====================================
CREATE TABLE detalle_paquete_producto (
    id_paquete INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_paquete, id_producto),
    FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- =====================================
-- DETALLE PAQUETE – SERVICIO (N–N)
-- =====================================
CREATE TABLE detalle_paquete_servicio (
    id_paquete INT,
    id_servicio INT,
    cantidad INT,
    PRIMARY KEY (id_paquete, id_servicio),
    FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

-- =====================================
-- TABLA: VENTA
-- =====================================
CREATE TABLE venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_vendedor INT,
    fecha_hora DATETIME,
    total FLOAT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

-- =====================================
-- DETALLE VENTA PRODUCTO
-- =====================================
CREATE TABLE detalle_venta_producto (
    id_venta INT,
    id_producto INT,
    cantidad INT,
    precio_unitario FLOAT,
    PRIMARY KEY (id_venta, id_producto),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- =====================================
-- DETALLE VENTA SERVICIO
-- =====================================
CREATE TABLE detalle_venta_servicio (
    id_venta INT,
    id_servicio INT,
    cantidad INT,
    precio_unitario FLOAT,
    PRIMARY KEY (id_venta, id_servicio),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);
