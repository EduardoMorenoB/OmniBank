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
