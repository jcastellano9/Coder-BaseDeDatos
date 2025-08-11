<h1 align="center">Proyecto Final – Clínica Oftalmológica 👁️</h1>

<p align="center">
  <strong>Entrega Nº 1</strong>  
</p>

**Autor:** Castellano Joaquín  
**Tutor:** Alejandro Daniel Di Stefano  
**Comisión:** 81830  
**Versión:** 1.0  

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

---


## TÉCNICO

### Script inicial


- [*`create_DB.sql`*](create_DB.sql): contiene la creación de las entidades principales del sistema, con sus respectivas claves primarias, foráneas y relaciones.

- [*`data.sql`*](data.sql): incluye la carga inicial de datos relevantes para pruebas.
---
<p align="center">
  <img src="assets/Coder-House-Logo.png" alt="Logo Coderhouse" height="120" style="margin-right: 40px;"/>
  <img src="assets/logo-clinica-de-ojos.jpg" alt="Logo Clínica de Ojos" height="120"/>
</p>


<h4 align="center">📍 Córdoba, Argentina – 2025</h4>

