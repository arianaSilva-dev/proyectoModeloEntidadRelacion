-- Migración 001-dominios.sql: Aplicación de dominios y restricciones DDL
-- Proyecto: Prevención de Apagones CFE

BEGIN;

-- 1. Restricciones NOT NULL y DEFAULT
ALTER TABLE reporte 
ALTER COLUMN estatus SET DEFAULT 'PENDIENTE',
ALTER COLUMN estatus SET NOT NULL,
ALTER COLUMN fecha_hora SET NOT NULL;

ALTER TABLE orden_trabajo 
ALTER COLUMN prioridad SET DEFAULT 'MEDIA',
ALTER COLUMN fecha_creacion SET NOT NULL;

-- 2. Restricciones UNIQUE
ALTER TABLE transformador 
ADD CONSTRAINT uq_transformador_serie UNIQUE (numero_serie_cfe);

ALTER TABLE suministro 
ADD CONSTRAINT uq_suministro_numero UNIQUE (numero_servicio);

-- 3. Restricciones CHECK (Reglas del Dominio)
ALTER TABLE transformador 
ADD CONSTRAINT chk_transformador_capacidad CHECK (capacidad_kva > 0);

ALTER TABLE reporte_preventivo 
ADD CONSTRAINT chk_reporte_preventivo_carga CHECK (porcentaje_carga BETWEEN 0.00 AND 150.00);

ALTER TABLE reporte 
ADD CONSTRAINT chk_reporte_codigo_postal CHECK (codigo_postal ~ '^[0-9]{5}$');

ALTER TABLE suministro 
ADD CONSTRAINT chk_suministro_numero_servicio CHECK (numero_servicio ~ '^[0-9]{12}$');

ALTER TABLE subestacion 
ADD CONSTRAINT chk_subestacion_latitud CHECK (latitud BETWEEN 19.000000 AND 20.000000),
ADD CONSTRAINT chk_subestacion_longitud CHECK (longitud BETWEEN -99.500000 AND -98.800000);

ALTER TABLE orden_trabajo 
ADD CONSTRAINT chk_orden_fechas CHECK (fecha_cierre IS NULL OR fecha_cierre >= fecha_creacion);

ALTER TABLE cuadrilla 
ADD CONSTRAINT chk_cuadrilla_estatus CHECK (estatus_disponibilidad IN ('DISPONIBLE', 'EN_SITIO', 'INACTIVA'));

ALTER TABLE reporte 
ADD CONSTRAINT chk_reporte_origen CHECK (origen_reporte IN ('CITADINO', 'SENSADO_IOT', 'INTERNO_CFE'));

ALTER TABLE auditoria_atencion 
ADD CONSTRAINT chk_auditoria_sla CHECK (cumplio_sla IN (TRUE, FALSE));

COMMIT;
