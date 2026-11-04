# Ejercicio 2.4: Edicion de Valores y Transacciones

## 1. Sentencias DML Avanzadas

* **INSERT con Subconsulta y ON CONFLICT:**
INSERT INTO lectura_carga (id_transformador, fecha_hora, carga_kva)
SELECT id_transformador, NOW(), 85.50 FROM transformador WHERE numero_serie_cfe = "TR-CFE-001"
ON CONFLICT (id_transformador, fecha_hora) DO UPDATE SET carga_kva = EXCLUDED.carga_kva;

* **UPDATE Dependiente de Otra Tabla:**
UPDATE reporte SET estatus = "EN_PROCESO"
FROM orden_trabajo WHERE reporte.id_reporte = orden_trabajo.id_reporte AND orden_trabajo.fecha_asignacion IS NOT NULL;

* **UPDATE con Expresion CASE:**
UPDATE orden_trabajo SET prioridad = CASE 
WHEN fecha_creacion < NOW() - INTERVAL "2 DAYS" THEN "ALTA"
WHEN fecha_creacion < NOW() - INTERVAL "1 DAY" THEN "MEDIA"
ELSE "BAJA"
END;

* **DELETE con Subconsulta y Borrado Logico:**
-- Borrado logico
UPDATE reporte SET estatus = "CANCELADO" WHERE id_reporte = 12;
-- Borrado fisico con subconsulta
DELETE FROM lectura_carga WHERE id_transformador IN (SELECT id_transformador FROM transformador WHERE capacidad_kva < 10);

---

## 2. Transaccion Completa con Puntos de Recuperacion

BEGIN;

INSERT INTO reporte (id_reporte, fecha_hora, estatus) VALUES (900, NOW(), "PENDIENTE");
SAVEPOINT punto_reporte;

INSERT INTO orden_trabajo (id_orden, id_reporte, prioridad, fecha_creacion) VALUES (500, 900, "ALTA", NOW());

-- Reversion parcial si falla la asignacion de cuadrilla
ROLLBACK TO SAVEPOINT punto_reporte;

-- Confirmacion final
COMMIT;

---

## 3. Transaccion que Falla a la Mitad (Atomicidad)

BEGIN;

UPDATE transformador SET capacidad_kva = 100.00 WHERE id_transformador = 1;

-- Intento de violacion de restriccion CHECK
INSERT INTO transformador (capacidad_kva) VALUES (-50.00);

-- El gestor devuelve: ERROR: el nuevo renglon viola la restriccion chk_transformador_capacidad
ROLLBACK;

