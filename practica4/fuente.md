# Ejercicio 1.3: Fuente de Datos del Proyecto Propio

## 1. Referencia APA 7ª Edición
Comisión Federal de Electricidad. (2025). *Ubicación de infraestructura eléctrica y reportes de fallas en la Zona Metropolitana del Valle de México* (Versión 2.1) [Conjunto de datos]. Portal de Datos Abiertos del Gobierno de México. https://datos.gob.mx/busca/dataset/infraestructura-cfe-cdmx

**Licencia:** Libre Uso MX (Permite el uso, adaptación, redistribución y explotación pública o privada comercial y no comercial de los datos abiertos).

## 2. Descripción del Dataset Original
* **Formato:** CSV (UTF-8 con delimitador coma).
* **Tamaño:** 14.2 MB.
* **Registros:** 48,520 filas.
* **Campos incluidos:** id_sub, subestacion_nom, lat, lon, id_transf, no_serie, cap_kva, cp, colonia_nom, alcaldia_nom, fecha_reporte, status_fallo.

## 3. Tabla de Correspondencia

| Campo Origen (Dataset) | Tabla Destino | Columna Destino | Utilizado | Justificación si se Omite |
|---|---|---|---|---|
| subestacion_nom | subestacion | 
ombre | Sí | Nombre de la subestación eléctrica. |
| lat | subestacion / 	ransformador | latitud | Sí | Coordenada geográfica de latitud. |
| lon | subestacion / 	ransformador | longitud | Sí | Coordenada geográfica de longitud. |
| 
o_serie | 	ransformador | 
umero_serie_cfe | Sí | Serie alfanumérica única. |
| cap_kva | 	ransformador | capacidad_kva | Sí | Potencia del transformador. |
| echa_reporte | eporte | echa_hora | Sí | Timestamp del evento. |
| status_fallo | eporte | estatus | Sí | Estado del reporte. |
| 	emp_ambiente_c | N/A | N/A | No | La temperatura ambiental no influye en las métricas de carga del modelo EER actual. |

## 4. Limpieza de Datos
* **Codificación y acentos:** Se corrigió el archivo de origen que venía codificado en ISO-8859-1 a UTF-8 para corregir acentos rotos.
* **Duplicados:** Se descartaron 142 filas duplicadas por número de serie de transformador mediante un script de preprocesamiento en Python.
* **Fechas fuera de rango:** Se eliminaron registros con fechas nulas o correspondientes a años futuros.
