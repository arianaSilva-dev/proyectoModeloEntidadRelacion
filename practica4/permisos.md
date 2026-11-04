# Ejercicio 1.6: Usuarios y Permisos

## 1. Definicion de Roles

1. **rol_app (Rol de Aplicacion):**
   * **Proposito:** Utilizado por el backend de la plataforma.
   * **Permisos:** Lectura y escritura (SELECT, INSERT, UPDATE) en tablas operativas.

2. **rol_consulta (Rol de Analista):**
   * **Proposito:** Utilizado por analistas para tableros de visualizacion.
   * **Permisos:** Exclusivamente lectura (SELECT).

3. **rol_admin (Rol de Administracion):**
   * **Proposito:** Utilizado por el DBA.
   * **Permisos:** Control total (ALL PRIVILEGES).

---

## 2. Sentencias SQL (GRANT / REVOKE)

CREATE ROLE rol_app;
CREATE ROLE rol_consulta;
CREATE ROLE rol_admin;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO rol_consulta;
GRANT SELECT, INSERT, UPDATE ON TABLE reporte, orden_trabajo, lectura_carga TO rol_app;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO rol_admin;

---

## 3. Matriz de Permisos

| Tabla / Entidad | rol_consulta | rol_app | rol_admin |
|---|---|---|---|
| subestacion | SELECT | SELECT | ALL PRIVILEGES |
| transformador | SELECT | SELECT | ALL PRIVILEGES |
| reporte | SELECT | SELECT, INSERT, UPDATE | ALL PRIVILEGES |
| orden_trabajo | SELECT | SELECT, INSERT, UPDATE | ALL PRIVILEGES |
