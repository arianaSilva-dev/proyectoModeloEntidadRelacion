# Ejercicio 2.3: Pruebas de Integridad Referencial

## 1. Demostracion de Acciones Referenciales

* **Prueba ON DELETE CASCADE (reporte -> orden_trabajo):**
  - Filas antes: reporte = 1, orden_trabajo = 1.
  - Sentencia DML: DELETE FROM reporte WHERE id_reporte = 5;
  - Filas despues: reporte = 0, orden_trabajo = 0 (Borrado en cascada).

* **Prueba ON DELETE RESTRICT (subestacion -> transformador):**
  - Sentencia DML: DELETE FROM subestacion WHERE id_subestacion = 1;
  - Resultado: ERROR devuelto por el gestor por violacion de llave foranea.

## 2. Insercion con Clave Foranea Inexistente

* **Operacion intentada:**
  INSERT INTO transformador (id_subestacion, numero_serie_cfe, capacidad_kva) VALUES (99999, "TR-TEST-99", 45.00);
* **Resultado del gestor:**
  ERROR: insercion o actualizacion viola la llave foranea en la tabla transformador.
