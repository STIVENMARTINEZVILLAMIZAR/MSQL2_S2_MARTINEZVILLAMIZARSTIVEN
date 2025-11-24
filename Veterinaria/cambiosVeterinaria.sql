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