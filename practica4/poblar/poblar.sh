 = @"
#!/usr/bin/env bash
# Script de carga masiva idempotente para la Práctica 4
# Uso: PGHOST=localhost PGPORT=5432 PGDATABASE=cfe_db PGUSER=app_user PGPASSWORD=secret ./poblar.sh

set -e

echo "=== Iniciando Carga Masiva de Datos (Proyecto CFE) ==="

# Verificación de variables de entorno requeridas
: """"
: """"
: """"
: """"

# 1. Aplicar migraciones previas
psql -f ../migraciones/001-dominios.sql

# 2. Carga masiva en orden de dependencia usando COPY (Idempotente)
echo "Cargando subestaciones y transformadores..."
psql -c "\copy subestacion FROM '../datos/subestaciones.csv' WITH (FORMAT csv, HEADER true);"
psql -c "\copy transformador FROM '../datos/transformadores.csv' WITH (FORMAT csv, HEADER true);"
psql -c "\copy reporte FROM '../datos/reportes.csv' WITH (FORMAT csv, HEADER true);"

echo "=== Carga masiva completada con éxito ==="
