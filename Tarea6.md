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
