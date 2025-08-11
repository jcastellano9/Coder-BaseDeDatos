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
