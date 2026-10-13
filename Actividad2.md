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

## Correccion.

Pude notar que identifiqué correctamente las tres entidades principales, pero observé que cometí errores al establecer sus relaciones, ya que relacioné las cuentas con el tipo de cuenta como si fueran entidades diferentes y agregué una relación directa entre clientes y transacciones. Después de revisar mi actividad, comprendí que el tipo de cuenta es un atributo de CUENTAS y que las transacciones deben relacionarse con CUENTAS mediante dos llaves foráneas, una para la cuenta de origen y otra para la cuenta de destino.

### CLIENTES

- cliente_id (PK)
- nombre
- correo
- telefono
- fecha_nacimiento
- tax_id

### CUENTAS

- cuenta_id (PK)
- cliente_id (FK)
- moneda
- tipo_cuenta
- saldo_actual
- limite_credito

### TRANSACCIONES

- transaccion_id (PK)
- from_account (FK -> CUENTAS)
- to_account (FK -> CUENTAS)
- monto
- tipo_transaccion
- fecha_completada

### Relaciones y cardinalidad

CLIENTES |------------< CUENTAS

CUENTAS (Origen) |------------< TRANSACCIONES

CUENTAS (Destino) |------------< TRANSACCIONES

### Descripción

- Un cliente puede tener muchas cuentas.
- Cada cuenta pertenece a un cliente.
- Una cuenta puede participar en muchas transacciones como origen.
- Una cuenta puede participar en muchas transacciones como destino.
- Cada transacción tiene dos llaves foráneas que apuntan a CUENTAS.
- No existe una relación directa entre CLIENTES y TRANSACCIONES.
