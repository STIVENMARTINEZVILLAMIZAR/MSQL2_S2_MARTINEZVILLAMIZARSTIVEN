DROP DATABASE IF EXISTS veterinaria;
CREATE DATABASE veterinaria;
USE veterinaria;

-- Tabla Persona: Se incluye ENUM solicitado ('CC','CE')
CREATE TABLE persona (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_documento ENUM('CC', 'CE') NOT NULL,
  documento VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  direccion VARCHAR(150),
  correo VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (documento)
);

CREATE TABLE cliente (
  id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE usuario (
  id INT NOT NULL,
  usuario VARCHAR(45) NOT NULL,
  contrasenha VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE especialidad (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE veterinario (
  id INT NOT NULL,
  tarjeta_profesional VARCHAR(45) NOT NULL,
  especialidad INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id),
  FOREIGN KEY (especialidad) REFERENCES especialidad(id)
);

CREATE TABLE tipo_animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cliente_id INT NOT NULL,
  tipo_animal_id INT NOT NULL,
  anho_nacimiento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tipo_animal_id) REFERENCES tipo_animal(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE producto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  precio_compra DOUBLE NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE precios_producto (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nit VARCHAR(45) NOT NULL,
  razon_social VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE compra (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  proveedor_id INT NOT NULL,
  fecha_compra DATE NOT NULL,
  fecha_registro DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE detalle_compra (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  compra_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id),
  FOREIGN KEY (compra_id) REFERENCES compra(id)
);

CREATE TABLE servicio (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE paquete (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

-- Tabla detalle_paquete: Se incluye ENUM solicitado ('servicio', 'producto')
CREATE TABLE detalle_paquete (
  id INT NOT NULL AUTO_INCREMENT,
  paquete_servicio ENUM('servicio','producto') NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  paquete_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (paquete_id) REFERENCES paquete(id)
);

CREATE TABLE venta (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  cliente_id INT NOT NULL,
  fecha_venta DATE NOT NULL,
  fecha_ingreso DATETIME NOT NULL,
  total VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Tabla detalle_venta: Se incluye ENUM solicitado y lógica de código
CREATE TABLE detalle_venta (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_venta ENUM('producto','paquete','servicio') NOT NULL,
  codigo INT NOT NULL, 
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  venta_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (venta_id) REFERENCES venta(id)
);

CREATE TABLE citas (
  id INT NOT NULL AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  animal_id INT NOT NULL,
  fecha_inicio DATETIME NOT NULL,
  fecha_fin DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  vendedor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (vendedor_id) REFERENCES usuario(id),
  FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
  FOREIGN KEY (animal_id) REFERENCES animal(id)
);

INSERT INTO persona (id, tipo_documento, documento, nombre, apellido, direccion, correo, fecha_nacimiento) VALUES
(1, 'CC', '10000001', 'Juan', 'Perez', 'Calle 1', 'juan@mail.com', '1990-01-01'),
(2, 'CC', '10000002', 'Ana', 'Gomez', 'Calle 2', 'ana@mail.com', '1992-02-02'),
(3, 'CE', '10000003', 'Carlos', 'Ruiz', 'Calle 3', 'carlos@mail.com', '1993-03-03'),
(4, 'CC', '10000004', 'Maria', 'Diaz', 'Calle 4', 'maria@mail.com', '1994-04-04'),
(5, 'CC', '10000005', 'Pedro', 'Lopez', 'Calle 5', 'pedro@mail.com', '1995-05-05'),
(6, 'CC', '10000006', 'Laura', 'Mora', 'Calle 6', 'laura@mail.com', '1996-06-06'),
(7, 'CE', '10000007', 'Jose', 'Ortiz', 'Calle 7', 'jose@mail.com', '1997-07-07'),
(8, 'CC', '10000008', 'Sofia', 'Vega', 'Calle 8', 'sofia@mail.com', '1998-08-08'),
(9, 'CC', '10000009', 'Luis', 'Soto', 'Calle 9', 'luis@mail.com', '1999-09-09'),
(10, 'CC', '10000010', 'Elena', 'Rios', 'Calle 10', 'elena@mail.com', '2000-10-10'),
-- Usuarios (IDs 11-20)
(11, 'CC', '20000001', 'Admin', 'Uno', 'Oficina 1', 'admin1@vet.com', '1980-01-01'),
(12, 'CC', '20000002', 'Vendedor', 'Dos', 'Oficina 2', 'vend2@vet.com', '1981-02-02'),
(13, 'CC', '20000003', 'Cajero', 'Tres', 'Oficina 3', 'caja3@vet.com', '1982-03-03'),
(14, 'CC', '20000004', 'Admin', 'Cuatro', 'Oficina 4', 'admin4@vet.com', '1983-04-04'),
(15, 'CC', '20000005', 'Logistica', 'Cinco', 'Oficina 5', 'log5@vet.com', '1984-05-05'),
(16, 'CC', '20000006', 'Gerente', 'Seis', 'Oficina 6', 'ger6@vet.com', '1985-06-06'),
(17, 'CC', '20000007', 'Auxiliar', 'Siete', 'Oficina 7', 'aux7@vet.com', '1986-07-07'),
(18, 'CC', '20000008', 'Vendedor', 'Ocho', 'Oficina 8', 'vend8@vet.com', '1987-08-08'),
(19, 'CC', '20000009', 'Admin', 'Nueve', 'Oficina 9', 'admin9@vet.com', '1988-09-09'),
(20, 'CC', '20000010', 'Soporte', 'Diez', 'Oficina 10', 'sop10@vet.com', '1989-10-10'),
-- Veterinarios (IDs 21-30)
(21, 'CC', '30000001', 'Doc', 'House', 'Hospital', 'house@vet.com', '1970-01-01'),
(22, 'CC', '30000002', 'Doc', 'Strange', 'Hospital', 'strange@vet.com', '1971-02-02'),
(23, 'CC', '30000003', 'Doc', 'Dolittle', 'Hospital', 'dolittle@vet.com', '1972-03-03'),
(24, 'CC', '30000004', 'Doc', 'Oz', 'Hospital', 'oz@vet.com', '1973-04-04'),
(25, 'CC', '30000005', 'Doc', 'Pepper', 'Hospital', 'pepper@vet.com', '1974-05-05'),
(26, 'CC', '30000006', 'Doc', 'Who', 'Hospital', 'who@vet.com', '1975-06-06'),
(27, 'CC', '30000007', 'Doc', 'Marten', 'Hospital', 'marten@vet.com', '1976-07-07'),
(28, 'CC', '30000008', 'Doc', 'Brown', 'Hospital', 'brown@vet.com', '1977-08-08'),
(29, 'CC', '30000009', 'Doc', 'Dre', 'Hospital', 'dre@vet.com', '1978-09-09'),
(30, 'CC', '30000010', 'Doc', 'Octopus', 'Hospital', 'octopus@vet.com', '1979-10-10');

-- 2. SUBTIPOS (Cliente, Usuario, Veterinario)
INSERT INTO cliente (id) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

INSERT INTO usuario (id, usuario, contrasenha) VALUES 
(11,'admin','123'),(12,'vendedor','123'),(13,'cajero','123'),(14,'admin2','123'),(15,'logis','123'),
(16,'gerente','123'),(17,'aux','123'),(18,'vend2','123'),(19,'admin3','123'),(20,'soporte','123');

INSERT INTO especialidad (nombre) VALUES ('Cirugía'),('General'),('Cardiología'),('Dermatología'),('Odontología');

INSERT INTO veterinario (id, tarjeta_profesional, especialidad) VALUES 
(21,'TP-001',1),(22,'TP-002',2),(23,'TP-003',3),(24,'TP-004',4),(25,'TP-005',5),
(26,'TP-006',1),(27,'TP-007',2),(28,'TP-008',3),(29,'TP-009',4),(30,'TP-010',5);

-- 3. CATÁLOGOS Y PRODUCTOS
INSERT INTO tipo_animal (nombre) VALUES ('Perro'),('Gato'),('Ave'),('Roedor'),('Reptil');

INSERT INTO proveedor (nit, razon_social, correo) VALUES
('9001','Purina','info@purina.com'),('9002','Bayer','info@bayer.com'),('9003','Pfizer','info@pfizer.com'),
('9004','RoyalCanin','info@royal.com'),('9005','Gabrica','info@gabrica.com');

INSERT INTO producto (id, nombre, descripcion, precio_compra, stock) VALUES
(1, 'Vacuna Rabia', 'Vacuna anual', 10000, 100),
(2, 'Antibiotico', 'Caja x 10', 20000, 50),
(3, 'Collar MP', 'Collar antipulgas', 30000, 20),
(4, 'Shampoo', 'Piel sensible', 15000, 40),
(5, 'Juguete Hueso', 'Goma resistente', 5000, 100),
(6, 'Arena Gato', 'Bolsa 5kg', 12000, 60),
(7, 'Alimento Perro', 'Bulto 30kg', 100000, 10),
(8, 'Alimento Gato', 'Bulto 8kg', 80000, 15),
(9, 'Pipeta', 'Antipulgas', 25000, 80),
(10, 'Vitaminas', 'Complejo B', 18000, 90);

INSERT INTO precios_producto (producto_id, nombre, precio) VALUES
(1,'Vacuna Rabia',15000), (2,'Antibiotico',25000), (3,'Collar MP',40000), (4,'Shampoo',20000), (5,'Juguete Hueso',8000),
(6,'Arena Gato',18000), (7,'Alimento Perro',130000), (8,'Alimento Gato',100000), (9,'Pipeta',35000), (10,'Vitaminas',25000);

INSERT INTO servicio (id, nombre, precio) VALUES
(1,'Consulta','50000'),(2,'Baño','30000'),(3,'Peluqueria','40000'),(4,'Vacunacion','10000'),(5,'Cirugia','200000');

INSERT INTO paquete (id, nombre, precio) VALUES
(1,'Combo Cachorro','100000'),(2,'Spa Day','60000'),(3,'Salud Total','150000');

INSERT INTO detalle_paquete (paquete_servicio, cantidad, subtotal, paquete_id) VALUES
('servicio', 1, 50000, 1), ('producto', 1, 15000, 1), -- Paquete 1 incluye consulta y vacuna
('servicio', 1, 30000, 2), ('servicio', 1, 40000, 2); -- Paquete 2 incluye baño y peluqueria

-- 4. RELACIONES / MOVIMIENTOS
INSERT INTO animal (id, nombre, cliente_id, tipo_animal_id, anho_nacimiento) VALUES
(1,'Firulais',1,1,2020), (2,'Michi',1,2,2021),
(3,'Rex',2,1,2019), (4,'Lola',3,1,2022),
(5,'Piolin',4,3,2023), (6,'Nemo',5,5,2021),
(7,'Simba',6,2,2020), (8,'Roco',7,1,2018),
(9,'Luna',8,2,2019), (10,'Hammy',9,4,2023);

INSERT INTO compra (id, usuario_id, proveedor_id, fecha_compra, fecha_registro, total) VALUES
(1, 15, 1, '2023-01-01', NOW(), 500000), (2, 15, 2, '2023-01-02', NOW(), 300000),
(3, 15, 3, '2023-01-03', NOW(), 200000), (4, 15, 4, '2023-01-04', NOW(), 100000),
(5, 15, 5, '2023-01-05', NOW(), 600000);

INSERT INTO detalle_compra (producto_id, cantidad, subtotal, compra_id) VALUES
(1, 10, 100000, 1), (2, 5, 100000, 2), (3, 5, 150000, 3), (4, 2, 30000, 4), (5, 10, 50000, 5);

INSERT INTO venta (id, usuario_id, cliente_id, fecha_venta, fecha_ingreso, total) VALUES
(1, 12, 1, '2023-02-01', NOW(), '65000'),
(2, 12, 2, '2023-02-02', NOW(), '100000'),
(3, 18, 3, '2023-02-03', NOW(), '20000'),
(4, 18, 4, '2023-02-04', NOW(), '130000'),
(5, 12, 5, '2023-02-05', NOW(), '50000');

-- Aquí se ve el polimorfismo en CODIGO (refiriendo ID producto, ID servicio o ID paquete)
INSERT INTO detalle_venta (tipo_venta, codigo, cantidad, subtotal, venta_id) VALUES
('producto', 1, 1, 15000, 1), -- Vendió vacuna
('servicio', 1, 1, 50000, 1), -- Vendió consulta
('paquete', 1, 1, 100000, 2), -- Vendió paquete cachorro
('producto', 4, 1, 20000, 3), -- Vendió shampoo
('producto', 7, 1, 130000, 4),-- Vendió bulto comida
('servicio', 1, 1, 50000, 5); -- Vendió consulta

INSERT INTO citas (veterinario_id, animal_id, fecha_inicio, fecha_fin, total, vendedor_id) VALUES
(21, 1, '2023-03-01 08:00:00', '2023-03-01 09:00:00', 50000, 12),
(22, 2, '2023-03-01 09:00:00', '2023-03-01 10:00:00', 30000, 12),
(23, 3, '2023-03-01 10:00:00', '2023-03-01 11:00:00', 40000, 18),
(24, 4, '2023-03-01 11:00:00', '2023-03-01 12:00:00', 50000, 18),
(25, 5, '2023-03-01 14:00:00', '2023-03-01 15:00:00', 50000, 12);