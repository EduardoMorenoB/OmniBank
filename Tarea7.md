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

## Correccion

El SELECT y despues el INSERT no solo duplica los viajes. Si dos workers leen al mismo tiempo y ninguno ve al cliente, los dos entran al INSERT y el segundo truena con duplicate key. Esa lectura no bloquea la fila.

INSERT INTO core.customers (first_name, last_name, email, phone_number, tax_id)
VALUES ('Humberto', 'López', 'hlopez@email.com', '+52-55-4433-2211', 'TAX-990011')
ON CONFLICT (email)
DO UPDATE SET
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    phone_number = EXCLUDED.phone_number,
    is_active = true
RETURNING customer_id, email, is_active;

EXCLUDED son los datos nuevos del VALUES. Si escribo first_name = first_name se queda el valor viejo. El customer_id y created_at no se tocan. RETURNING cierra la confirmacion en el mismo viaje.

Corrección: Según la clave pude notar que el SELECT antes del INSERT abre una condicion de carrera, y que el UPSERT tiene que usar EXCLUDED en el DO UPDATE y cerrar con RETURNING.
