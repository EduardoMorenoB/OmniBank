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

## Correccion

1. Respuesta al auditor

El auditor junior tiene razon desde la 3NF estricta. saldo_actual es un dato derivado: se puede obtener con la suma de los montos del historial de la cuenta. Guardarlo en la tabla duplica ese estado y, si nadie lo mantiene junto con las transacciones, se puede descuadrar. No es un dato primitivo independiente del flujo de ingresos y egresos.

2. Por que se queda en la tabla

En un banco no se puede calcular el saldo con SUM cada vez que alguien consulta un cajero, paga en un punto de venta o abre la app. Con muchas cuentas y muchos movimientos eso pega en CPU y en disco, y se va la latencia. Tambien hace falta saber al momento si saldo_actual alcanza para el retiro o la transferencia, sin recorrer el historial y sin dejar una ventana en la que dos operaciones pasen al mismo tiempo.

Por eso lo dejo como una desnormalizacion controlada, no porque la 3NF este mal.

3. Como evitar que se desajuste

El saldo no se deberia editar a mano ni calcularse en el frontend. PostgreSQL lo actualiza en la misma transaccion que el movimiento, con un procedimiento almacenado o un trigger, bajo ACID, y con bloqueo de la fila (FOR UPDATE) cuando se va a mover dinero. Asi el saldo y las transacciones quedan juntos o no se confirman.

Una vista materializada serviria para reportes muy grandes, pero el refresco no es inmediato y en un cajero eso no alcanza.

Corrección: Según la clave pude notar que debía reconocer primero que el auditor tiene razón en 3NF estricta y que saldo_actual es derivado; después explicar por qué lo dejamos por rendimiento OLTP y cómo lo protegemos con transacciones y triggers, no por purismo académico.
