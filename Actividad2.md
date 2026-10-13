# Actividad 2

## CLIENTES

- CLIENT_ID (PK)
- Nombre C.
- Correo_E.
- Teléfono
- Fecha_N.
- Tax_ID

## CUENTAS

- Account_ID (PK)
- Client_ID (FK)
- Tipo_Cuenta
- Saldo
- Límite Crédito
- Moneda

## TRANSACCIONES

- Transaction_ID (PK)
- Account_ID (FK)
- Client_ID (FK)
- Origen_Account
- Destino_Account
- Tipo_Transaction
- Date_Time

## Relaciones y cardinalidad

CLIENTES |------------< CUENTAS

CUENTAS >------------< TIPO_CUENTA

TIPO_CUENTA |------------< TRANSACCIONES


- Un cliente puede tener varias cuentas.
- Una cuenta pertenece a un cliente.
- Una cuenta puede generar muchas transacciones.
- Una transacción puede tener una cuenta de origen.
