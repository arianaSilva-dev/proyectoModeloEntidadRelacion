# Ejercicio 1.1 y 1.2: Dominios y Restricciones de Columna (Proyecto Red Eléctrica CFE)

## 1. Tabla de Tipos de Datos y Justificación de Dominios

| Tabla | Columna | Tipo de Dato Elegido | Longitud / Precisión | Justificación del Dominio |
|---|---|---|---|---|
| `subestacion` | `latitud`, `longitud` | `DECIMAL` | `(9,6)` | Las coordenadas geográficas requieren alta precisión espacial sin los errores de redondeo de punto flotante. |
| `transformador` | `capacidad_kva` | `DECIMAL` | `(8,2)` | Representa la potencia del transformador. No debe usarse `FLOAT` para evitar imprecisiones acumulativas. |
| `transformador` | `numero_serie_cfe` | `VARCHAR` | `30` | Identificador alfanumérico único institucional. |
| `lectura_carga` | `carga_kva` | `DECIMAL` | `(8,2)` | Carga eléctrica registrada en un instante de tiempo. |
| `reporte` | `folio_institucional` | `VARCHAR` | `30` | Cadena alfanumérica única para rastrear cada reporte de falla o alerta. |
| `reporte` | `fecha_hora` | `TIMESTAMP` | N/A | Guarda instante exacto (fecha y hora) del incidente sin pérdida de precisión. |
| `reporte` | `codigo_postal` | `CHAR` | `5` | Formato estándar fijo de 5 dígitos para CP en México. |
| `reporte_preventivo`| `porcentaje_carga` | `DECIMAL` | `(5,2)` | Porcentaje de 0.00 a 100.00% que indica el estrés del transformador. |
| `suministro` | `numero_servicio` | `CHAR` | `12` | Número de contrato de luz de CFE (fijo de 12 caracteres numéricos). |
| `auditoria_atencion`| `cumplio_sla` | `BOOLEAN` | N/A | Indicador binario (cumplió o no el tiempo límite de atención). |

---

## 2. Restricciones de Columna y Reglas de Negocio

### NOT NULL
1. `transformador.numero_serie_cfe`: Un transformador no puede existir en el catálogo sin su placa/serie de identificación.
2. `reporte.fecha_hora`: Todo reporte requiere marcar el momento exacto en que fue recibido.
3. `orden_trabajo.fecha_creacion`: Una orden de trabajo debe registrar su fecha inicial obligatoriamente.

### DEFAULT
4. `reporte.estatus`: Por omisión toma el valor `'PENDIENTE'`.
5. `orden_trabajo.prioridad`: Por omisión toma el valor `'MEDIA'`.

### UNIQUE
6. `transformador.numero_serie_cfe`: No pueden existir dos transformadores físicos con la misma serie CFE.
7. `suministro.numero_servicio`: El número de contrato de medidor/servicio CFE es único nacionalmente.

### CHECK (10 Restricciones Justificadas)
8. `chk_transformador_capacidad`: `capacidad_kva > 0` (La capacidad nominal debe ser estrictamente positiva).
9. `chk_reporte_preventivo_carga`: `porcentaje_carga BETWEEN 0 AND 150` (El porcentaje no puede ser negativo ni sobrepasar el límite de falla del 150%).
10. `chk_reporte_codigo_postal`: `codigo_postal ~ '^[0-9]{5}$'` (Debe constar exactamente de 5 dígitos numéricos).
11. `chk_suministro_numero_servicio`: `numero_servicio ~ '^[0-9]{12}$'` (El contrato CFE debe tener 12 dígitos).
12. `chk_subestacion_latitud`: `latitud BETWEEN 19.0 AND 20.0` (Restringido al rango geográfico de operación de la CDMX y área metropolitana).
13. `chk_subestacion_longitud`: `longitud BETWEEN -99.5 AND -98.8` (Restringido a la cobertura de longitud de la CDMX).
14. `chk_orden_fechas`: `fecha_cierre >= fecha_creacion` (La fecha de cierre de una reparación no puede ser anterior a la fecha en que se reportó).
15. `chk_cuadrilla_estatus`: `estatus_disponibilidad IN ('DISPONIBLE', 'EN_SITIO', 'INACTIVA')` (Lista cerrada de estados operativos).
16. `chk_reporte_origen`: `origen_reporte IN ('CITADINO', 'SENSADO_IOT', 'INTERNO_CFE')` (Canal válido de recepción del reporte).
17. `chk_auditoria_sla`: `cumplio_sla IN (TRUE, FALSE)` (Verificación estricta del indicador binario).
