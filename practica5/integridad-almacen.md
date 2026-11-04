# Ejercicio 2.5: Integridad Referencial en el Almacen Asignado (Sismos)

## 1. Identificacion del Esquema

* **Tabla de Hechos:** Sismo (Registra los eventos teluricos con magnitud, profundidad y epicentro).
* **Dimensiones:** Entidad_Federativa e Instalacion_Critica.
* **Granularidad:** Un renglon representa un sismo individual registrado en una fecha/hora especifica con su ubicacion geografica.

## 2. Verificacion de Claves Foraneas Huerfanas

Al ejecutar consultas de busqueda de llaves desasociadas entre Sismo y Entidad_Federativa:
SELECT s.id_sismo FROM Sismo s LEFT JOIN Entidad_Federativa e ON s.id_entidad = e.id_entidad WHERE e.id_entidad IS NULL;

* **Resultado:** 0 registros huerfanos.

## 3. Evaluacion de Llaves Foraneas en un Data Warehouse

* **Por que se omiten FK a proposito?:** En almacenes de datos masivos (Data Warehouses), las FK suelen omitirse para acelerar procesos de carga masiva (ETL) y consultas de agregacion sin sobrecarga de verificacion.
* **Riesgo corrido:** Perdida de integridad referencial, apariciones de datos huerfanos o incongruencias en reportes analiticos.
