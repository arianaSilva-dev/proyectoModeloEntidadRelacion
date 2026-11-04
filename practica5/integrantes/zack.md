# Ejercicio 2.6: Trabajo Individual - Jose Issac Ramirez Gonzalez (Zack)

## Modificacion de Accion Referencial

* **Relacion elegida:** reporte -> orden_trabajo (FK id_reporte).
* **Accion original:** ON DELETE CASCADE.
* **Accion probada en copia:** ON DELETE RESTRICT.

## Resultados de la Prueba

1. Al intentar borrar un reporte que tiene una orden de trabajo asociada usando RESTRICT:
   DELETE FROM reporte WHERE id_reporte = 1;
2. El gestor bloquea la operacion y devuelve:
   ERROR: update o delete en reporte viola la llave foranea fk_orden_reporte en orden_trabajo.

## Conclusion del Dominio

Para el dominio de la Red Electrica CFE, la opcion correcta es ON DELETE CASCADE, ya que una orden de trabajo huerfana sin reporte carece de justificacion operativa.
