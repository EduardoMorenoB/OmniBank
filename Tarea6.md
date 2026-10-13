## Tarea 6

1. El CHECK intentó revisar los 75M de registros
de core.transactions, PostgreSQL usó un bloqueo ACCESS
EXCLUSIVE LOCK que impidió temporalmente lecturas
y escrituras.

2. Solución: Primero se agrega la restricción sin
revisar todo el historial:

ALTER TABLE core.transactions
ADD CONSTRAINT chk_transaction_description_valid
CHECK (LENGTH(TRIM(description)) >= 5)
NOT VALID;

#### Así los datos nuevos ya cumplen con la regla.

3. Validación posterior:

ALTER TABLE core.transactions
VALIDATE CONSTRAINT chk_transaction_description_valid;

#### Usa un bloqueo más ligero.

## Correccion

El corte de 14 minutos no fue falta de RAM ni algo que se arregle solo por hacerlo de noche. El ADD CONSTRAINT con CHECK sobre 75 millones de filas pidio un AccessExclusiveLock: mientras revisa fila por fila no deja pasar ni SELECT ni INSERT ni UPDATE, y la banca web se queda en timeout.

La migracion en dos pasos:

ALTER TABLE core.transactions
    ADD CONSTRAINT chk_transactions_description_valid
    CHECK (LENGTH(TRIM(description)) >= 5) NOT VALID;

Eso solo anota la regla. Los INSERT y UPDATE nuevos ya la cumplen y no se escanean las filas viejas.

ALTER TABLE core.transactions
    VALIDATE CONSTRAINT chk_transactions_description_valid;

La validacion del historico usa un ShareUpdateExclusiveLock. Las consultas y las inserciones siguen, sin el AccessExclusiveLock.

Corrección: Según la clave pude notar que el congelamiento fue por el AccessExclusiveLock del CHECK directo, y que en produccion se agrega la regla con NOT VALID y despues se corre VALIDATE CONSTRAINT aparte.
