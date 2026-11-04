# Ejercicio 1.5: Pruebas de Restricciones de Dominio

A continuación se muestran 10 casos de prueba diseñados para intentar violar las restricciones de la base de datos del proyecto propio.

| # | Operación Intentada | Resultado Esperado | Mensaje Devuelto por el Gestor | Regla del Dominio Protegida |
|---|---|---|---|---|
| 1 | `INSERT INTO transformador (id_transformador, numero_serie_cfe) VALUES (1, NULL);` | Rechazo por NOT NULL | ERROR: el valor null para la columna «numero_serie_cfe» viola la restricción de no nulo | Un transformador no puede registrarse sin su número de serie físico. |
| 2 | `INSERT INTO reporte (id_reporte, fecha_hora) VALUES (10, '2026-10-01 10:00:00');` | Éxito con DEFAULT | INSERT 0 1 (Asigna 'PENDIENTE' en columna estatus) | Por omisión, todo reporte inicia en estado pendiente. |
| 3 | `INSERT INTO transformador (numero_serie_cfe) VALUES ('TR-CFE-001');` (Ejecutado dos veces) | Rechazo por UNIQUE | ERROR: llave duplicada viola restricción de unicidad «uq_transformador_serie» | No pueden coexistir dos transformadores con la misma serie física. |
| 4 | `INSERT INTO transformador (capacidad_kva) VALUES (-50.00);` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «transformador» viola la restricción «chk_transformador_capacidad» | La potencia instalada debe ser un valor positivo. |
| 5 | `INSERT INTO reporte_preventivo (porcentaje_carga) VALUES (180.50);` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «reporte_preventivo» viola la restricción «chk_reporte_preventivo_carga» | La carga leída no puede superar el umbral físico del 150%. |
| 6 | `INSERT INTO reporte (codigo_postal) VALUES ('0630');` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «reporte» viola la restricción «chk_reporte_codigo_postal» | El código postal debe contener exactamente 5 dígitos. |
| 7 | `INSERT INTO suministro (numero_servicio) VALUES ('12345ABC');` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «suministro» viola la restricción «chk_suministro_numero_servicio» | El número de contrato CFE debe ser estrictamente numérico de 12 dígitos. |
| 8 | `INSERT INTO subestacion (latitud, longitud) VALUES (15.400000, -99.100000);` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «subestacion» viola la restricción «chk_subestacion_latitud» | La ubicación debe estar dentro de las coordenadas operativas de la CDMX. |
| 9 | `INSERT INTO orden_trabajo (fecha_creacion, fecha_cierre) VALUES ('2026-11-05', '2026-11-01');` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «orden_trabajo» viola la restricción «chk_orden_fechas» | La fecha de atención no puede ser previa a la fecha de creación del reporte. |
| 10 | `INSERT INTO cuadrilla (estatus_disponibilidad) VALUES ('VACACIONES');` | Rechazo por CHECK | ERROR: el nuevo renglón para la relación «cuadrilla» viola la restricción «chk_cuadrilla_estatus» | El estatus de la cuadrilla debe ser un valor del catálogo operativo permitido. |
