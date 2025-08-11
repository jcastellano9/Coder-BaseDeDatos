USE clinica_de_ojos;

SET FOREIGN_KEY_CHECKS = 0;

-- =========================
-- Pacientes (1..10)
-- =========================
INSERT INTO pacientes (id_paciente, nombre, apellido, fecha_nacimiento, telefono, email) VALUES
(1,'Juan','Rossi','1990-03-15','351-5551111','juan.rossi@gmail.com'),
(2,'María','Suárez','1988-07-22','351-5552222','maria.suarez@gmail.com'),
(3,'Carlos','Pereyra','1975-11-09','351-5553333','carlos.pereyra@hotmail.com'),
(4,'Lucía','Martín','2001-02-01','351-5554444','lucia.martin@yahoo.com'),
(5,'Joaquín','Castellano','2000-05-10','351-5555555','joaquin.castellano@gmail.com'),
(6,'Ana','Gómez','1995-09-30','351-5556666','ana.gomez@gmail.com'),
(7,'Luis','Fernández','1982-12-05','351-5557777','luis.fernandez@gmail.com'),
(8,'Sofía','López','1998-04-18','351-5558888','sofia.lopez@gmail.com'),
(9,'Martín','Aguilar','1993-06-25','351-5559999','martin.aguilar@gmail.com'),
(10,'Paula','Díaz','1987-01-12','351-5550000','paula.diaz@gmail.com');
-- =========================
-- Médicos (1..5)
-- =========================
INSERT INTO medicos (id_medico, nombre, apellido, especialidad, telefono, email) VALUES
(1,'Ana','Pérez','Oftalmología General','351-4101001','ana.perez@clinicaojos.com'),
(2,'Luis','Gómez','Retina','351-4101002','luis.gomez@clinicaojos.com'),
(3,'Valeria','Ruiz','Glaucoma','351-4101003','valeria.ruiz@clinicaojos.com'),
(4,'Diego','Soria','Córnea','351-4101004','diego.soria@clinicaojos.com'),
(5,'Carla','Molina','Oculoplastia','351-4101005','carla.molina@clinicaojos.com');

-- =========================
-- Obra sociales (1..5)
-- =========================
INSERT INTO obra_sociales (id_obra_social, id_paciente, nombre, telefono, email) VALUES
(1,1,'OSDE 210','0810-555-210','contacto@osde.com'),
(2,2,'Swiss Medical SMG30','0810-555-300','contacto@swissmedical.com'),
(3,3,'PAMI','0800-222-7264','info@pami.org'),
(4,5,'OSDE 310','0810-555-310','afiliados@osde.com'),
(5,8,'Sancor Salud','0810-555-7262','info@sancorsalud.com');

-- =========================
-- Turnos
-- =========================
INSERT INTO turnos (id_turno, id_paciente, id_medico, fecha, hora, motivo) VALUES
(1,1,1,'2025-08-05','09:00:00','Control de agudeza visual'),
(2,2,2,'2025-08-06','10:30:00','Chequeo de retina'),
(3,3,3,'2025-08-06','11:15:00','Presión intraocular'),
(4,1,4,'2025-08-07','14:00:00','Consulta por ojo seco'),
(5,4,1,'2025-08-07','15:30:00','Primera consulta'),
(6,5,2,'2025-08-08','09:45:00','Estudio de fondo de ojo'),
(7,6,5,'2025-08-08','10:15:00','Blefaroplastia - evaluación'),
(8,7,3,'2025-08-08','11:00:00','Control glaucoma'),
(9,8,4,'2025-08-09','08:30:00','Molestia corneal'),
(10,9,2,'2025-08-09','12:00:00','Seguimiento retina'),
(11,10,1,'2025-08-10','13:15:00','Receta lentes'),
(12,5,4,'2025-08-11','09:00:00','Topografía corneal');

-- =========================
-- Tratamientos
-- =========================
INSERT INTO tratamientos (id_tratamiento, id_paciente, descripcion, fecha_inicio, fecha_fin) VALUES
(1,1,'Lágrimas artificiales 3x/día por ojo','2025-08-07',NULL),
(2,2,'Suplemento macular + control mensual','2025-08-06',NULL),
(3,3,'Latanoprost 1 gota nocturna','2025-08-06',NULL),
(4,5,'Antibiótico tópico 7 días','2025-08-08','2025-08-15'),
(5,6,'Evaluación prequirúrgica y cuidados palpebrales','2025-08-08',NULL),
(6,7,'Timolol 1 gota cada 12h','2025-08-08',NULL),
(7,8,'Lubricación y lente de contacto terapéutico','2025-08-09',NULL),
(8,9,'Complejo vitamínico ocular','2025-08-09',NULL);

-- =========================
-- Facturas
-- =========================
INSERT INTO facturas (id_factura, id_paciente, fecha, total) VALUES
(1,1,'2025-08-07',150000.00),
(2,2,'2025-08-06',50000.00),
(3,3,'2025-08-06',220000.00),
(4,5,'2025-08-08',180000.00),
(5,8,'2025-08-09',320000.00),
(6,10,'2025-08-10',120000.00);
