<h1 align="center">Proyecto Final – Clínica Oftalmológica 👁️</h1>

<p align="center">
  <strong>Entrega Nº 1</strong>  
</p>

**Autor:** Castellano Joaquín  
**Tutor:** Alejandro Daniel Di Stefano  
**Comisión:** 81830  
**Versión:** 3.0  

---


## INTRODUCCIÓN

El presente proyecto describe el diseño e implementación de un sistema integral de gestión para una clínica oftalmológica. En el contexto sanitario actual, la administración eficiente de la información médica y administrativa resulta esencial para ofrecer una atención de calidad y salvaguardar la seguridad de los pacientes.

#### Objetivo: Diseñar el modelo de datos relacional para la gestión núcleo de una clínica oftalmológica —pacientes, médicos, turnos, tratamientos y facturación— garantizando integridad referencial, trazabilidad de la atención y capacidad de reporte para métricas operativas básicas.


El sistema propuesto optimiza los procesos operativos, facilita la coordinación entre el cuerpo médico y el personal administrativo, y proporciona una plataforma robusta para el manejo confidencial de datos clínicos. Asimismo, incorpora funcionalidades analíticas y está preparado para integrarse con módulos de facturación, obras sociales y reportes operativos, garantizando así la escalabilidad y la sostenibilidad a largo plazo.

---

## FUNCIONAL

### Situación Problemática

La clínica oftalmológica opera actualmente con **planillas Excel, historiales en papel y sistemas aislados** (agenda, cobros, laboratorio). Esta dispersión provoca:

- **Datos duplicados o inconsistentes** entre recepción, consultorios y facturación.  
- **Demoras administrativas** por la carga manual de estudios y comprobantes.  
- **Nula trazabilidad clínica**, dificultando reconstruir quién atendió, qué práctica se realizó y qué insumos se utilizaron.  
- **Falta de métricas confiables** para evaluar productividad, ausentismo y tiempos de espera.

La ausencia de un repositorio único reduce la calidad asistencial y aumenta el riesgo operativo. Implementar una **base de datos relacional centralizada** permitirá:

1. Consolidar la información y garantizar su integridad.  
2. Automatizar procesos críticos, reduciendo errores y tiempos.  
3. Sentar las bases para integrar obras sociales, inventario y analítica de gestión.

---

### Modelo de Negocio


| Componente                  | Descripción resumida                                                                                           |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------|
| **Propuesta de valor**      | Atención oftalmológica integral con tiempos de espera reducidos y trazabilidad completa del historial clínico. |
| **Segmento de clientes**    | Pacientes particulares y afiliados a obras sociales / prepagas que requieren consultas, estudios o cirugías.    |
| **Canales**                 | Turnos presenciales, canal telefónico, portal web con autogestión y recordatorios automáticos.                  |
| **Relación con el cliente** | Seguimiento personalizado post-consulta, notificaciones de resultados y recordatorio de controles periódicos.  |
| **Fuentes de ingresos**     | Honorarios profesionales, cirugías, venta de lentes/insumos y reintegros de obras sociales.                     |
| **Recursos clave**          | Personal médico especializado, equipamiento diagnóstico (láser, OCT), infraestructura IT y base de datos.       |
| **Actividades clave**       | Diagnóstico, tratamiento y seguimiento ocular; gestión de turnos; facturación y reportes operativos.            |
| **Socios clave**            | Obras sociales, proveedores de equipamiento, laboratorios ópticos y aseguradoras de salud.                      |
| **Estructura de costos**    | Sueldos, mantenimiento de equipos, licencias de software, insumos médicos y gastos administrativos.             |


---

### Diagrama de Entidad - Relación

El siguiente diagrama E‑R muestra la estructura lógica de la base de datos (pacientes, profesionales, turnos, tratamientos y facturación) y las relaciones entre esas entidades. Fue generado a partir del script create_DB.sql, garantizando coherencia entre la representación gráfica y la implementación técnica.

📄 [Diagrama de Entidad Relación (DER.pdf)](assets/DER.pdf)

---

### Listado de Tablas

#### `pacientes`

| Campo             | Nombre completo           | Tipo                | Clave | NULL |
| ----------------- | ------------------------- | ------------------- | ----- | ---- |
| id\_paciente      | Identificador de paciente | INT AUTO\_INCREMENT | PK    | NO   |
| nombre            | Nombre                    | VARCHAR(100)        | —     | NO   |
| apellido          | Apellido                  | VARCHAR(100)        | —     | NO   |
| fecha\_nacimiento | Fecha de nacimiento       | DATE                | —     | NO   |
| telefono          | Teléfono                  | VARCHAR(15)         | —     | SÍ   |
| email             | Correo electrónico        | VARCHAR(100)        | —     | SÍ   |

#### `medicos`

| Campo        | Nombre completo         | Tipo                | Clave | NULL |
| ------------ | ----------------------- | ------------------- | ----- | ---- |
| id\_medico   | Identificador de médico | INT AUTO\_INCREMENT | PK    | NO   |
| nombre       | Nombre                  | VARCHAR(100)        | —     | NO   |
| apellido     | Apellido                | VARCHAR(100)        | —     | NO   |
| especialidad | Especialidad            | VARCHAR(100)        | —     | NO   |
| telefono     | Teléfono                | VARCHAR(15)         | —     | SÍ   |
| email        | Correo electrónico      | VARCHAR(100)        | —     | SÍ   |

#### `turnos`

| Campo        | Nombre completo        | Tipo                | Clave                        | NULL |
| ------------ | ---------------------- | ------------------- | ---------------------------- | ---- |
| id\_turno    | Identificador de turno | INT AUTO\_INCREMENT | PK                           | NO   |
| id\_paciente | Paciente               | INT                 | FK → pacientes(id\_paciente) | NO   |
| id\_medico   | Médico                 | INT                 | FK → medicos(id\_medico)     | NO   |
| fecha        | Fecha del turno        | DATE                | —                            | NO   |
| hora         | Hora del turno         | TIME                | —                            | NO   |
| motivo       | Motivo/nota            | VARCHAR(255)        | —                            | SÍ   |

#### `tratamientos`

| Campo           | Nombre completo              | Tipo                | Clave                        | NULL |
| --------------- | ---------------------------- | ------------------- | ---------------------------- | ---- |
| id\_tratamiento | Identificador de tratamiento | INT AUTO\_INCREMENT | PK                           | NO   |
| id\_paciente    | Paciente                     | INT                 | FK → pacientes(id\_paciente) | NO   |
| descripcion     | Descripción del tratamiento  | TEXT                | —                            | NO   |
| fecha\_inicio   | Fecha de inicio              | DATE                | —                            | NO   |
| fecha\_fin      | Fecha de fin                 | DATE                | —                            | SÍ   |

#### `facturas`

| Campo        | Nombre completo          | Tipo                | Clave                        | NULL |
| ------------ | ------------------------ | ------------------- | ---------------------------- | ---- |
| id\_factura  | Identificador de factura | INT AUTO\_INCREMENT | PK                           | NO   |
| id\_paciente | Paciente                 | INT                 | FK → pacientes(id\_paciente) | NO   |
| fecha        | Fecha de emisión         | DATE                | —                            | NO   |
| total        | Importe total            | DECIMAL(10,2)       | —                            | NO   |

#### `obra_sociales`

| Campo            | Nombre completo                         | Tipo                | Clave                        | NULL |
| ---------------- | --------------------------------------- | ------------------- | ---------------------------- | ---- |
| id\_obra\_social | Identificador de obra social (registro) | INT AUTO\_INCREMENT | PK                           | NO   |
| id\_paciente     | Paciente afiliado                       | INT                 | FK → pacientes(id\_paciente) | NO   |
| nombre           | Nombre de la obra social/plan           | VARCHAR(100)        | —                            | NO   |
| telefono         | Teléfono de contacto                    | VARCHAR(15)         | —                            | SÍ   |
| email            | Correo de contacto                      | VARCHAR(100)        | —                            | SÍ   |

#### `practicas`

| Campo        | Nombre completo                        | Tipo                | Clave  | NULL |
| ------------ | --------------------------------------- | ------------------- | ------ | ---- |
| id_practica  | Identificador de práctica              | INT AUTO_INCREMENT  | PK     | NO   |
| codigo       | Código de práctica (único)             | VARCHAR(20)         | UNIQUE | NO   |
| nombre       | Nombre de la práctica                  | VARCHAR(150)        | —      | NO   |
| precio_base  | Precio base de la práctica             | DECIMAL(12,2)       | —      | NO   |

#### `facturas_detalle`

| Campo              | Nombre completo                       | Tipo                | Clave                        | NULL |
| ------------------ | --------------------------------------| ------------------- | ---------------------------- | ---- |
| id_factura_detalle | Identificador de detalle de factura    | INT AUTO_INCREMENT  | PK                           | NO   |
| id_factura         | Factura asociada                      | INT                 | FK → facturas(id_factura)    | NO   |
| id_practica        | Práctica facturada                    | INT                 | FK → practicas(id_practica)  | NO   |
| cantidad           | Cantidad de prácticas                 | INT                 | —                             | NO   |
| precio_unitario    | Precio unitario aplicado              | DECIMAL(12,2)       | —                             | NO   |
| subtotal           | Subtotal calculado (cantidad × precio) | DECIMAL(12,2) STORED| —                             | NO   |

#### `pagos`

| Campo      | Nombre completo                           | Tipo                                                                 | Clave | NULL |
| ---------- | ------------------------------------------ | -------------------------------------------------------------------- | ----- | ---- |
| id_pago    | Identificador de pago                     | INT AUTO_INCREMENT                                                   | PK    | NO   |
| id_factura | Factura pagada                             | INT                                                                  | FK → facturas(id_factura) | NO |
| fecha      | Fecha del pago                             | DATE                                                                 | —     | NO   |
| importe    | Importe del pago                           | DECIMAL(12,2)                                                        | —     | NO   |
| medio_pago | Medio de pago (efectivo, débito, etc.)     | ENUM('efectivo','debito','credito','transferencia','obra_social')    | —     | NO   |
| estado     | Estado del pago (aplicado, pendiente, etc.)| ENUM('aplicado','pendiente','rechazado')                             | —     | NO   |

#### `salas`

| Campo     | Nombre completo          | Tipo                | Clave  | NULL |
| --------- | ------------------------ | ------------------- | ------ | ---- |
| id_sala   | Identificador de sala    | INT AUTO_INCREMENT  | PK     | NO   |
| nombre    | Nombre de la sala        | VARCHAR(50)         | UNIQUE | NO   |

#### `turnos_salas`

| Campo           | Nombre completo            | Tipo               | Clave                       | NULL |
| --------------- | ---------------------------| ------------------ | --------------------------- | ---- |
| id_turno_sala   | Identificador de turno-sala | INT AUTO_INCREMENT | PK                          | NO   |
| id_turno        | Turno asignado             | INT                | FK → turnos(id_turno)       | NO   |
| id_sala         | Sala en la que se atiende  | INT                | FK → salas(id_sala)         | NO   |


---

## Vistas

Se agregan vistas operativas y de reporte que se apoyan en las tablas existentes.

- **vw_agenda_medico_dia** — Agenda consolidada por turno (fecha, hora, paciente, médico, especialidad, motivo).  
  **Tablas:** `turnos`, `pacientes`, `medicos`.

- **vw_turnos_proximos** — Turnos a 14 días vista (útil para recordatorios).  
  **Tablas:** derivada de `vw_agenda_medico_dia`.

- **vw_historial_tratamientos_paciente** — Tratamientos por paciente con duración estimada en días.  
  **Tablas:** `pacientes`, `tratamientos`.

- **vw_facturacion_mensual** — Total facturado por mes (KPI administrativo).  
  **Tablas:** `facturas`.

- **vw_pacientes_por_obra_social** — Pacientes agrupados por obra social.  
  **Tablas:** `obra_sociales`, `pacientes`.

- **vw_productividad_medico** — Cantidad de turnos por médico y por mes.  
  **Tablas:** `turnos`, `medicos`.
  

## Funciones
  
- **fn_edad(fecha_nac)** → INT  
  Calcula edad exacta; útil en listados y segmentación. *(No accede a tablas)*

- **fn_nombre_completo(nombre, apellido)** → VARCHAR  
  Formatea “Apellido, Nombre” para vistas y reportes. *(No accede a tablas)*

- **fn_turno_datetime(fecha, hora)** → DATETIME  
  Unifica fecha+hora de turnos para ordenar/filtrar. *(No accede a tablas)*

- **fn_total_mes(año, mes)** → DECIMAL  
  Devuelve lo facturado en el período solicitado. **Tablas:** `facturas`.


## Stored Procedures

- **sp_agendar_turno(paciente, médico, fecha, hora, motivo)**  
  Inserta un turno validando horario permitido (08–19 h) y evitando solapamientos del mismo médico en el mismo horario.  
  **Tablas:** inserta/consulta `turnos`.

- **sp_cancelar_turno(id_turno)**  
  Cancela el turno indicado y devuelve filas afectadas.  
  **Tablas:** `turnos`.

- **sp_registrar_factura(paciente, fecha, total)**  
  Crea una factura validando montos no negativos; devuelve el ID generado.  
  **Tablas:** `facturas`.

- **sp_actualizar_datos_paciente(id, email, teléfono)**  
  Normaliza email a minúsculas y actualiza contacto.  
  **Tablas:** `pacientes`.


## Triggers

- **trg_pacientes_email_ins / trg_pacientes_email_upd** — Normalizan emails a minúsculas y sin espacios.  
  **Objetivo:** evitar duplicados “lógicos” y mantener consistencia de contacto.  
  **Tablas/situaciones:** `pacientes` en INSERT/UPDATE.

- **trg_trat_fechas_ins / trg_trat_fechas_upd** — Impiden `fecha_fin < fecha_inicio`.  
  **Objetivo:** asegurar coherencia temporal de tratamientos.  
  **Tablas/situaciones:** `tratamientos` en INSERT/UPDATE.

- **trg_turnos_chk_ins / trg_turnos_chk_upd** — Validan franja 08–19 h y evitan turnos duplicados por médico/horario.  
  **Objetivo:** mantener agenda clínica consistente y sin solapamientos.  
  **Tablas/situaciones:** `turnos` en INSERT/UPDATE.

- **trg_facturas_total_ins / trg_facturas_total_upd** — Evitan montos negativos.  
  **Objetivo:** preservar integridad financiera.  
  **Tablas/situaciones:** `facturas` en INSERT/UPDATE.

---

### Informes y análisis de datos

A partir de las vistas y consultas SQL del proyecto se generaron reportes en formato `.csv` (carpeta **informes** del repositorio).  
Estos reportes brindan una visión cuantitativa de la actividad de la clínica:

- **Facturación mensual total**: evolución de los ingresos mes a mes.
- **Prácticas más facturadas**: ranking de las atenciones de mayor facturación.
- **Pacientes con mayor facturación acumulada**: identifica los pacientes que concentran mayor gasto.
- **Turnos por especialidad médica**: distribución y demanda de las distintas especialidades.

Los resultados permiten detectar picos de demanda, especialidades más solicitadas y patrones de facturación, sirviendo como base para decisiones de gestión y planificación.



## TÉCNICO

### Script inicial

- [*`create_DB.sql`*](create_DB.sql): contiene la creación de las entidades principales del sistema, con sus respectivas claves primarias, foráneas y relaciones.
- [*`data.sql`*](data.sql): incluye la carga inicial de datos relevantes para pruebas.
- [*`views.sql`*](views.sql): define las **vistas** operativas y de reporte del modelo.
- [*`funciones.sql`*](funciones.sql): define funciones utilitarias (fn_edad, fn_nombre_completo, fn_turno_datetime, fn_total_mes).
- [*`stored_procedures.sql`*](stored_procedures.sql): define procedimientos almacenados (sp_agendar_turno, sp_cancelar_turno, sp_registrar_factura, sp_actualizar_datos_paciente).
- [*`triggers.sql`*](triggers.sql): define triggers de integridad/normalización (emails en pacientes, fechas en tratamientos, agenda en turnos, montos en facturas).

---
<p align="center">
  <img src="assets/Coder-House-Logo.png" alt="Logo Coderhouse" height="120" style="margin-right: 40px;"/>
  <img src="assets/logo-clinica-de-ojos.jpg" alt="Logo Clínica de Ojos" height="120"/>
</p>


<h4 align="center">📍 Córdoba, Argentina – 2025</h4>

