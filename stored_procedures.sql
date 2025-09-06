USE clinica_de_ojos;

-- Crear turno con validaciones (horario y solapamiento por médico)
DROP PROCEDURE IF EXISTS sp_agendar_turno;
DELIMITER //
CREATE PROCEDURE sp_agendar_turno(
  IN p_id_paciente INT,
  IN p_id_medico   INT,
  IN p_fecha       DATE,
  IN p_hora        TIME,
  IN p_motivo      VARCHAR(255)
)
BEGIN
  -- Horario permitido 08:00–19:00
  IF p_hora < '08:00:00' OR p_hora > '19:00:00' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Horario fuera de rango (08:00–19:00).';
  END IF;

  -- Conflicto mismo médico + mismo slot
  IF EXISTS (
    SELECT 1 FROM turnos
    WHERE id_medico=p_id_medico AND fecha=p_fecha AND hora=p_hora
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El médico ya tiene un turno en ese horario.';
  END IF;

  INSERT INTO turnos (id_paciente, id_medico, fecha, hora, motivo)
  VALUES (p_id_paciente, p_id_medico, p_fecha, p_hora, p_motivo);

  SELECT LAST_INSERT_ID() AS nuevo_id_turno;
END//
DELIMITER ;

-- Cancelar turno
DROP PROCEDURE IF EXISTS sp_cancelar_turno;
DELIMITER //
CREATE PROCEDURE sp_cancelar_turno(IN p_id_turno INT)
BEGIN
  DELETE FROM turnos WHERE id_turno=p_id_turno;
  SELECT ROW_COUNT() AS turnos_cancelados;
END//
DELIMITER ;

-- Registrar factura (valida total >= 0)
DROP PROCEDURE IF EXISTS sp_registrar_factura;
DELIMITER //
CREATE PROCEDURE sp_registrar_factura(
  IN p_id_paciente INT,
  IN p_fecha       DATE,
  IN p_total       DECIMAL(10,2)
)
BEGIN
  IF p_total < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El total de la factura no puede ser negativo.';
  END IF;

  INSERT INTO facturas (id_paciente, fecha, total)
  VALUES (p_id_paciente, p_fecha, p_total);

  SELECT LAST_INSERT_ID() AS nuevo_id_factura;
END//
DELIMITER ;

-- Actualizar datos de contacto del paciente (normaliza email)
DROP PROCEDURE IF EXISTS sp_actualizar_datos_paciente;
DELIMITER //
CREATE PROCEDURE sp_actualizar_datos_paciente(
  IN p_id_paciente INT,
  IN p_email       VARCHAR(100),
  IN p_telefono    VARCHAR(15)
)
BEGIN
  UPDATE pacientes
     SET email=LOWER(TRIM(p_email)),
         telefono=TRIM(p_telefono)
   WHERE id_paciente=p_id_paciente;

  SELECT ROW_COUNT() AS pacientes_actualizados;
END//
DELIMITER ;


-- Agenda sin choque
CALL sp_agendar_turno(1, 1, DATE_ADD(CURDATE(), INTERVAL 13 DAY), '10:00:00', 'Control anual');

-- Cancelar el turno recién creado
CALL sp_cancelar_turno(LAST_INSERT_ID());  -- o CALL sp_cancelar_turno(<id>);

-- Registrar una factura de prueba
CALL sp_registrar_factura(3, CURDATE(), 123456.78);

-- Actualizar contacto de paciente
CALL sp_actualizar_datos_paciente(1, 'NUEVO.CORREO@MAIL.COM', ' 351-0000000 ');