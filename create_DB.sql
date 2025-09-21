-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS clinica_de_ojos;
USE clinica_de_ojos;

-- Pacientes
CREATE TABLE IF NOT EXISTS pacientes (
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(100)
);

-- Médicos
CREATE TABLE IF NOT EXISTS medicos (
  id_medico INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100) NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(100)
);

-- Turnos
CREATE TABLE IF NOT EXISTS turnos (
  id_turno INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  motivo VARCHAR(255),
  FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- Tratamientos
CREATE TABLE IF NOT EXISTS tratamientos (
  id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  descripcion TEXT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- Facturas
CREATE TABLE IF NOT EXISTS facturas (
  id_factura INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  fecha DATE NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- Obra sociales (asociada al paciente)
CREATE TABLE IF NOT EXISTS obra_sociales (
  id_obra_social INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(100),
  FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- Catálogo de prácticas
CREATE TABLE IF NOT EXISTS practicas (
  id_practica INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) UNIQUE,
  nombre VARCHAR(150) NOT NULL,
  precio_base DECIMAL(12,2) NOT NULL
);

-- Detalle de factura
CREATE TABLE IF NOT EXISTS facturas_detalle (
  id_factura_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_factura INT NOT NULL,
  id_practica INT NOT NULL,
  cantidad INT NOT NULL DEFAULT 1,
  precio_unitario DECIMAL(12,2) NOT NULL,
  subtotal DECIMAL(12,2) AS (cantidad * precio_unitario) STORED,
  FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
  FOREIGN KEY (id_practica) REFERENCES practicas(id_practica)
);

-- Pagos aplicados a facturas
CREATE TABLE IF NOT EXISTS pagos (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_factura INT NOT NULL,
  fecha DATE NOT NULL,
  importe DECIMAL(12,2) NOT NULL,
  medio_pago ENUM('efectivo','debito','credito','transferencia','obra_social') NOT NULL,
  estado ENUM('aplicado','pendiente','rechazado') NOT NULL DEFAULT 'aplicado',
  FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
);

-- Salas físicas de atención
CREATE TABLE IF NOT EXISTS salas (
  id_sala INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Asignación de sala al turno
CREATE TABLE IF NOT EXISTS turnos_salas (
  id_turno_sala INT AUTO_INCREMENT PRIMARY KEY,
  id_turno INT NOT NULL,
  id_sala INT NOT NULL,
  FOREIGN KEY (id_turno) REFERENCES turnos(id_turno),
  FOREIGN KEY (id_sala)  REFERENCES salas(id_sala)
);