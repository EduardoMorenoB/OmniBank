## Tarea 7

1. Problema

El método SELECT y después INSERT/UPDATE
es lento porque realiza 2 viajes a la
base de datos por cada cliente. Con 1 millón
de registros esto genera demasiadas consultas.

Además si dos servidores hacen el mismo
tiempo, ambos pueden creer que el cliente no
existe e insertarlo.


2. Solución UPSERT

INSERT INTO core.customers (...)
VALUES (...)
ON CONFLICT (email)
DO UPDATE SET
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    phone_number = EXCLUDED.phone_number
RETURNING customer_id, email;

EXCLUDED representa los datos nuevos
que llegaron desde el sistema KYC.


3. Resultados

Situación                     Acción de PSQL

Email no existe               INSERT
Email existe                  UPDATE
customer_id existe            No cambia
created_at existe             No cambia
Nombre, apellido y tel.       UPDATE

Resultado principal:

SELECT + IF -> INSERT/UPDATE

UPSERT -> INSERT o UPDATE -> RETURNING

#### Así las consultas se reducen.
