# Ejercicio 2.1 y 2.2: Claves Foraneas y Acciones Referenciales

## 1. Mapeo de Claves Foraneas (FK)

| Tabla Origen | Columna FK | Tabla Referenciada | Columna Referenciada | Permite Nulos | Relacion EER |
|---|---|---|---|---|---|
| transformador | id_subestacion | subestacion | id_subestacion | No | Subestacion alimenta Transformador (1:N) |
| reporte | id_transformador | transformador | id_transformador | Si | Transformador recibe Reporte (0:N) |
| orden_trabajo | id_reporte | reporte | id_reporte | No | Reporte genera Orden (1:1) |
| orden_trabajo | id_cuadrilla | cuadrilla | id_cuadrilla | Si | Cuadrilla atiende Orden (0:N) |

---

## 2. Acciones Referenciales Justificadas

* **subestacion -> transformador (FK id_subestacion):**
  - ON DELETE RESTRICT: Impide borrar una subestacion si tiene transformadores activos.
  - ON UPDATE CASCADE: Sincroniza la clave primaria si cambia.

* **transformador -> reporte (FK id_transformador):**
  - ON DELETE SET NULL: Mantiene el historial de reportes marcando la FK como nula al retirar un transformador.
  - ON UPDATE CASCADE: Sincroniza cambios de clave.

* **reporte -> orden_trabajo (FK id_reporte):**
  - ON DELETE CASCADE: Al borrar un reporte, su orden de trabajo asociada se elimina automaticamente.
