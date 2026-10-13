
## Punto 1. Cuentas

| Número de cuenta | Tipo de cuenta | Saldo |
|---|---|---:|
| ACCT-2001 | SAVINGS | 15000.00 |
| ACCT-1001 | CHECKING | 4950.00 |

## Punto 2. Clientes y email

| Nombre | Apellido | Correo electrónico |
|---|---|---|
| John | Doe | john.doe@email.com |
| Jane | Smith | jane.smith@email.com |
| Alice | Johnson | alice.j@email.com |
| Humberto | López | hlopez@email.com |

## Punto 3. Transacciones

| ID de cuenta | Monto | Tipo | Descripción |
|---|---:|---|---|
| UUID de la cuenta correspondiente | Monto de la transacción | WITHDRAWAL | COBRO INSTITUCIONAL O COMISIÓN - SIN RECEPTOR |

## Corrección
Pude notar que los resultados de los primeros dos reportes
estaban organizados correctamente, pero observé que en el
tercer punto había omitido el identificador de la cuenta
y el monto de la transacción. Después de revisar mi actividad,
comprendí que el reporte debe mostrar todas las columnas
solicitadas para identificar correctamente los movimientos
que tienen una descripción NULL.
-->
