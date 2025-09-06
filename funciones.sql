-- VISTAS
USE clinica_de_ojos;

-- 1) Agenda completa por turno
DROP VIEW IF EXISTS vw_agenda_medico_dia;
CREATE VIEW vw_agenda_medico_dia AS
SELECT
  t.id_turno,
  t.fecha,
  t.hora,
  CONCAT(p.apellido, ', ', p.nombre)   AS paciente,
  CONCAT(m.apellido, ', ', m.nombre)   AS medico,
  m.especialidad,
  t.motivo
FROM turnos t
JOIN pacientes p ON p.id_paciente = t.id_paciente
JOIN medicos   m ON m.id_medico   = t.id_medico;

-- 2) Turnos de los próximos 14 días (derivada)
DROP VIEW IF EXISTS vw_turnos_proximos;
CREATE VIEW vw_turnos_proximos AS
SELECT *
FROM vw_agenda_medico_dia
WHERE fecha BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 14 DAY)
ORDER BY fecha, hora;

-- 3) Historial de tratamientos por paciente (con duración)
DROP VIEW IF EXISTS vw_historial_tratamientos_paciente;
CREATE VIEW vw_historial_tratamientos_paciente AS
SELECT
  p.id_paciente,
  CONCAT(p.apellido, ', ', p.nombre) AS paciente,
  tto.id_tratamiento,
  tto.descripcion,
  tto.fecha_inicio,
  tto.fecha_fin,
  TIMESTAMPDIFF(
    DAY,
    tto.fecha_inicio,
    COALESCE(tto.fecha_fin, CURDATE())
  ) AS dias_en_tratamiento
FROM pacientes p
JOIN tratamientos tto ON tto.id_paciente = p.id_paciente;

-- 4) Facturación mensual (total por mes)
DROP VIEW IF EXISTS vw_facturacion_mensual;
CREATE VIEW vw_facturacion_mensual AS
SELECT
  DATE_FORMAT(fecha, '%Y-%m') AS mes,
  SUM(total)                  AS total_mes
FROM facturas
GROUP BY DATE_FORMAT(fecha, '%Y-%m');

-- 5) Pacientes por obra social (1-N simple)
DROP VIEW IF EXISTS vw_pacientes_por_obra_social;
CREATE VIEW vw_pacientes_por_obra_social AS
SELECT
  os.nombre AS obra_social,
  p.id_paciente,
  CONCAT(p.apellido, ', ', p.nombre) AS paciente,
  p.email,
  p.telefono
FROM obra_sociales os
JOIN pacientes p ON p.id_paciente = os.id_paciente
ORDER BY os.nombre, paciente;

-- 6) Productividad: turnos por médico y mes
DROP VIEW IF EXISTS vw_productividad_medico;
CREATE VIEW vw_productividad_medico AS
SELECT
  CONCAT(m.apellido, ', ', m.nombre) AS medico,
  m.especialidad,
  DATE_FORMAT(t.fecha, '%Y-%m')      AS mes,
  COUNT(*)                           AS turnos_mes
FROM turnos t
JOIN medicos m ON m.id_medico = t.id_medico
GROUP BY m.id_medico, DATE_FORMAT(t.fecha, '%Y-%m');

-- Probar cada una de las vistas creadas

SELECT * FROM vw_agenda_medico_dia LIMIT 5;
SELECT * FROM vw_turnos_proximos;
SELECT * FROM vw_historial_tratamientos_paciente LIMIT 5;
SELECT * FROM vw_facturacion_mensual;
SELECT * FROM vw_pacientes_por_obra_social LIMIT 5;
SELECT * FROM vw_productividad_medico ORDER BY mes DESC, turnos_mes DESC;
