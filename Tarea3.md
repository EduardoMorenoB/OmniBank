Análisis de dependencias transitivas

Desde el punto de vista de la normalización
estricta, el auditor tiene razón al considerar
saldo_actual como un dato derivado y redundante,
ya que puede calcularse a partir de la suma algebraica
de las transacciones registradas para cada cuenta. Es una
aplicación de la tercera forma normal (3NF), el campo
podría eliminarse y obtenerse mediante SUM.

Sin embargo, en un entorno empresarial con clientes
que pueden acumular muchas transacciones, recalcular
el saldo completo en cada consulta
generaría un costo elevado, afectando a los
Req. NF.

Por esta razón, se recomienda mantener
saldo_actual en la tabla cuentas. El saldo se
consultaría de manera inmediata sin
recorrer todo el historial transaccional.
Cada depósito o retiro registraría la transacción
y actualizaría saldo_actual dentro de una
misma operación.
