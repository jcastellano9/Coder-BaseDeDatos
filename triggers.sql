USE clinica_de_ojos;

-- =========================
-- Pacientes: normalizar email
-- =========================
DROP TRIGGER IF EXISTS clinica_de_ojos.trg_pacientes_email_ins;
DELIMITER $$
CREATE TRIGGER trg_pacientes_email_ins
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL THEN
    SET NEW.email = LOWER(TRIM(NEW.email));
  END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS clinica_de_ojos.trg_pacientes_email_upd;
DELIMITER $$
CREATE TRIGGER trg_pacientes_email_upd
BEFORE UPDATE ON pacientes
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL THEN
    SET NEW.email = LOWER(TRIM(NEW.email));
  END IF;
END$$
DELIMITER ;

-- =========================
-- Tratamientos: integridad temporal
-- =========================
DROP TRIGGER IF EXISTS clinica_de_ojos.trg_trat_fechas_ins;
DELIMITER $$
CREATE TRIGGER trg_trat_fechas_ins
BEFORE INSERT ON tratamientos
FOR EACH ROW
BEGIN
  IF NEW.fecha_fin IS NOT NULL AND NEW.fecha_fin < NEW.fecha_inicio THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'fecha_fin no puede ser menor a fecha_inicio';
  END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS clinica_de_ojos.trg_trat_fechas_upd;
DELIMITER $$
CREATE TRIGGER trg_trat_fechas_upd
BEFORE UPDATE ON tratamientos
FOR EACH ROW
BEGIN
  IF NEW.fecha_fin IS NOT NULL AND NEW.fecha_fin < NEW.fecha_inicio THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'fecha_fin no puede ser menor a fecha_inicio';
  END IF;
END$$
DELIMITER ;

-- =========================
-- Turnos: horario válido + evitar choque por médico/slot
-- =========================
DROP TRIGGER IF EXISTS clinica_de_ojos.trg_turnos_chk_ins;
DELIMITER $$
CREATE TRIGGER trg_turnos_chk_ins
BEFORE INSERT ON turnos
FOR EACH ROW
BEGIN
  IF NEW.hora < '08:00:00' OR NEW.hora > '19:00:00' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='Horario de turno inválido (08:00–19:00).';
  END IF;

  IF EXISTS (
    SELECT 1 FROM turnos
    WHERE id_medico = NEW.id_medico
      AND fecha     = NEW.fecha
      AND hora      = NEW.hora
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='Conflicto de agenda: mismo médico y horario.';
  END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS clinica_de_ojos.trg_turnos_chk_upd;
DELIMITER $$
CREATE TRIGGER trg_turnos_chk_upd
BEFORE UPDATE ON turnos
FOR EACH ROW
BEGIN
  IF NEW.hora < '08:00:00' OR NEW.hora > '19:00:00' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='Horario de turno inválido (08:00–19:00).';
  END IF;

  IF EXISTS (
    SELECT 1 FROM turnos
    WHERE id_medico = NEW.id_medico
      AND fecha     = NEW.fecha
      AND hora      = NEW.hora
      AND id_turno <> NEW.id_turno
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='Conflicto de agenda: mismo médico y horario.';
  END IF;
END$$
DELIMITER ;

-- =========================
-- Facturas: monto no negativo
-- =========================
DROP TRIGGER IF EXISTS clinica_de_ojos.trg_facturas_total_ins;
DELIMITER $$
CREATE TRIGGER trg_facturas_total_ins
BEFORE INSERT ON facturas
FOR EACH ROW
BEGIN
  IF NEW.total < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='El total no puede ser negativo.';
  END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS clinica_de_ojos.trg_facturas_total_upd;
DELIMITER $$
CREATE TRIGGER trg_facturas_total_upd
BEFORE UPDATE ON facturas
FOR EACH ROW
BEGIN
  IF NEW.total < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT='El total no puede ser negativo.';
  END IF;
END$$
DELIMITER ;


-- 1) Email normalizado
UPDATE pacientes SET email='  JUAN.ROSSI@GMAIL.COM ' WHERE id_paciente=1;
SELECT email FROM pacientes WHERE id_paciente=1;  -- debe quedar en minúsculas y sin espacios

-- 2) Tratamiento con fechas inválidas (debe fallar)
INSERT INTO tratamientos (id_paciente, descripcion, fecha_inicio, fecha_fin)
VALUES (1,'Test', '2025-09-10','2025-09-01');  -- error esperado

-- 3) Turno fuera de horario (debe fallar)
INSERT INTO turnos (id_paciente, id_medico, fecha, hora, motivo)
VALUES (1,1,CURDATE(),'07:59:00','Temprano');  -- error esperado

-- 4) Turno en choque con otro del mismo médico/slot (debe fallar)
-- usa una fecha/hora ya ocupada en tu tabla 'turnos' para el mismo id_medico

-- 5) Factura negativa (debe fallar)
INSERT INTO facturas (id_paciente, fecha, total) VALUES (1, CURDATE(), -1);  -- error esperado