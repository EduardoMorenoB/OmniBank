## TAREA 5
1. Se rechaza el uso de ON DELETE CASCADE
dentro del núcleo financiero, especialmente en
core.customers, accounts, transactions y loans. En
un sistema bancario real eliminar por accidente
un cliente o una cuenta no puede provocar que
automáticamente desaparezcan todas sus transacciones
o préstamos relacionados.


2. Los registros de core.transactions y core.loans nunca
deben eliminarse físicamente con DELETE, una vez forman
parte del historial financiero consolidado. Aunque
la cuenta de un cliente se cancele, sus
transacciones deben quedar en registro.


3. La solución correcta sería implementar
una baja lógica. Cuando un cliente solicite una
cancelación de cuenta, su atributo permanecería
en core.customers y cambiar su estado a
CLOSED sin eliminarla. Así core.transactions
y core.loans quedan intactos, es decir no usar
ON DELETE CASCADE, en lugar usar
bajas lógicas.

## Correccion

1. No se pone ON DELETE CASCADE en customers ni en accounts. El equipo de pruebas puede limpiar su ambiente en orden inverso o con TRUNCATE en un entorno temporal. En produccion un delete de un cliente no puede borrar de golpe sus transferencias, creditos y cobros.

2. El historial de core.transactions es rastro contable. Borrarlo al dar de baja a una persona descuadra el libro y deja al banco sin evidencia ante una auditoria. Esas filas no se borran con DELETE.

3. La baja es logica, con la bandera que ya tenemos, y el borrado fisico queda bloqueado con ON DELETE RESTRICT:

UPDATE core.customers
SET is_active = false
WHERE customer_id = '...';

UPDATE core.accounts
SET is_active = false,
    updated_at = CURRENT_TIMESTAMP
WHERE customer_id = '...';

Asi las cuentas dejan de operar y los reportes historicos siguen completos.

Corrección: Según la clave pude notar que no basta con rechazar CASCADE: la baja tiene que ser logica con is_active = false y el delete fisico queda bloqueado con ON DELETE RESTRICT, porque el historial de transacciones no se puede perder.
