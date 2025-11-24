CREATE DATABASE tienda;
USE tienda;

-- =======================
-- TABLA PERSONA
-- =======================
CREATE TABLE persona (
    id INT NOT NULL AUTO_INCREMENT,
    tipo_documento ENUM('cedula', 'pasaporte', 'tarjeta de identidad') NOT NULL,
    documento VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- =======================
-- TABLA CLIENTE
-- =======================
CREATE TABLE cliente (
    id INT NOT NULL,
    gana_puntos INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
);

-- =======================
-- TABLA VENDEDOR
-- =======================
CREATE TABLE vendedor (
    id INT NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50) NOT NULL,
    rol ENUM('admin', 'empleado') NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
);

-- =======================
-- TABLA MARCA
-- =======================
CREATE TABLE marca (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- =======================
-- TABLA CATEGORIA
-- =======================
CREATE TABLE categoria (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- =======================
-- TABLA PRODUCTO
-- =======================
CREATE TABLE producto (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    marca_fk INT NOT NULL,
    categoria_fk INT NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    FOREIGN KEY (marca_fk) REFERENCES marca(id),
    FOREIGN KEY (categoria_fk) REFERENCES categoria(id)
);

-- =======================
-- TABLA VENTA
-- =======================
CREATE TABLE venta (
    id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedor(id)
);

-- =======================
-- TABLA DETALLE_VENTA
-- =======================
CREATE TABLE detalle_venta (
    id INT NOT NULL AUTO_INCREMENT,
    venta_fk INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (venta_fk) REFERENCES venta(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);

-- ===========================================================
-- INSERTS DE PERSONA
-- ===========================================================
INSERT INTO persona (tipo_documento, documento, nombre, apellido, ciudad)
VALUES
('cedula', '1234567890', 'Juan', 'Pérez', 'Bogotá'),
('pasaporte', 'A12345678', 'María', 'González', 'Medellín'),
('tarjeta de identidad', '987654321', 'Carlos', 'Rodríguez', 'Cali'),
('cedula', '1122334455', 'Laura', 'Martínez', 'Barranquilla'),
('pasaporte', 'B98765432', 'Pedro', 'Sánchez', 'Cartagena');

-- ===========================================================
-- INSERTS MARCA
-- ===========================================================
INSERT INTO marca (id, nombre) VALUES
(1, 'CHEVROLET'),
(2, 'NISSAN'),
(3, 'MAZDA'),
(4, 'FZ 3.0'),
(5, 'BICIEXPRESS'),
(6, 'BMX');

-- ===========================================================
-- INSERTS CATEGORIA
-- ===========================================================
INSERT INTO categoria (id, nombre) VALUES
(1, 'AUTOS'),
(2, 'MOTOS'),
(3, 'BICICLETAS');

-- ===========================================================
-- INSERTS PRODUCTO
-- ===========================================================
INSERT INTO producto (nombre, descripcion, marca_fk, categoria_fk, precio_compra, precio_venta)
VALUES
('Chevrolet Spark', 'Auto compacto ideal para ciudad', 1, 1, 30000000.00, 35000000.00),
('Mazda CX-5', 'SUV de tamaño medio', 3, 1, 80000000.00, 95000000.00),
('Nissan Altima', 'Sedán de lujo con tecnología avanzada', 2, 1, 70000000.00, 80000000.00),
('Yamaha FZ 3.0', 'Motocicleta deportiva de 150cc', 4, 2, 8000000.00, 10000000.00),
('KTM Duke 200', 'Motocicleta deportiva 200cc', 4, 2, 7000000.00, 8500000.00),
('Honda CRF 250L', 'Motocicleta off-road 250cc', 4, 2, 12000000.00, 15000000.00),
('Bicicross BMX', 'Bicicleta BMX para niños', 6, 3, 500000.00, 600000.00),
('Bicicleta Mountain Bike', 'Bicicleta de montaña para adultos', 5, 3, 1200000.00, 1500000.00),
('Bicicleta de ruta Shimano', 'Bicicleta de carretera profesional', 5, 3, 2500000.00, 3000000.00),
('BMX Freestyle', 'BMX para competencias', 6, 3, 800000.00, 1000000.00);

-- ===========================================================
-- INSERTS CLIENTE
-- ===========================================================
INSERT INTO cliente (id, gana_puntos)
VALUES
(1, 1),
(3, 1),
(4, 0);

-- ===========================================================
-- INSERTS VENDEDOR
-- ===========================================================
INSERT INTO vendedor (id, usuario, contraseña, rol)
VALUES
(4, 'admin1', 'contraseña123', 'admin'),
(5, 'admin2', 'contraseña456', 'admin');

-- ===========================================================
-- INSERTS VENTA
-- ===========================================================
INSERT INTO venta (cliente_id, vendedor_id, fecha, total)
VALUES
(1, 4, '2025-11-19 10:00:00', 35000000.00),
(3, 5, '2025-11-19 11:30:00', 8500000.00),
(4, 5, '2025-11-19 12:45:00', 1500000.00);

-- ===========================================================
-- INSERTS DETALLE_VENTA
-- (IDs basados en las ventas generadas arriba: 1,2,3)
-- ===========================================================

-- Venta 1 (Juan)
INSERT INTO detalle_venta (venta_fk, producto_id, cantidad, subtotal)
VALUES
(1, 1, 1, 35000000.00);

-- Venta 2 (Carlos)
INSERT INTO detalle_venta (venta_fk, producto_id, cantidad, subtotal)
VALUES
(2, 4, 1, 10000000.00),
(2, 7, 1, 1500000.00);

-- Venta 3 (Laura)
INSERT INTO detalle_venta (venta_fk, producto_id, cantidad, subtotal)
VALUES
(3, 10, 1, 600000.00),
(3, 8, 1, 1500000.00);

create table auditoria(id int not null auto_increment, vendedor_fk int not null, cliente_fk int not null, accion varchar(50) not null, total double, primary key (id), foreign key (vendedor_fk) references vendedor(id), foreign key (cliente_fk) references cliente(id));
