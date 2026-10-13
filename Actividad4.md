
# Actividad 4

## Instrucciones SQL

```sql
CREATE DATABASE Omni_Bank;

CREATE TYPE tipo_cambio AS ENUM ('MXN', 'USD', 'EUR');

CREATE TYPE tipo_cuenta AS ENUM ('CHECKING', 'SAVINGS', 'CREDIT');

CREATE TYPE tipo_transaccion AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER');
```

## CLIENTES

- Cliente_ID (PK): UUID
- TAX_ID: VARCHAR(100)
- Nombre_1: VARCHAR(25)
- Nombre_2: VARCHAR(25)
- Apellido_P: VARCHAR(25)
- Apellido_M: VARCHAR(25)
- Contacto: contacto_formateado
- EMail: email_formateado

## CUENTAS

- Cuenta_ID (PK): UUID
- Cliente_ID (FK)
- Tipo: tipo_cuenta
- Moneda: tipo_cambio

## TRANSACCION

- TX_ID (PK): UUID
- Cuenta_ID (FK)
- Cliente_ID (FK)
- Fecha_TX: Fecha_UTC
- Saldo: saldo_formateado (saldo con dominio y con Numeric(10,2)

## Correccion.

Pude notar que había identificado correctamente varios tipos de datos como UUID, VARCHAR y ENUM, pero observé que cometí errores al definir algunos nombres y tipos. Utilicé `tipo_cambio` para representar las monedas cuando debía utilizar un tipo de moneda, y no había incluido todos los valores del ENUM. También comprendí que los montos financieros deben manejarse con `NUMERIC(15,2)` en lugar de `NUMERIC(10,2)` y que para almacenar fechas y horas correctamente debo utilizar `TIMESTAMPTZ`. Por último, observé que debía distinguir el saldo de una cuenta del monto de una transacción.

### 1. Instrucciones SQL corregidas

```sql
CREATE DATABASE Omni_Bank;

-- Ejecutar las siguientes instrucciones dentro de Omni_Bank.

CREATE SCHEMA IF NOT EXISTS core;

CREATE TYPE core.tipo_moneda AS ENUM (
    'USD',
    'EUR',
    'MXN',
    'GBP'
);

CREATE TYPE core.tipo_cuenta AS ENUM (
    'CHECKING',
    'SAVINGS',
    'CREDIT'
);

CREATE TYPE core.tipo_transaccion AS ENUM (
    'DEPOSIT',
    'WITHDRAWAL',
    'TRANSFER'
);

CREATE DOMAIN core.saldo_formateado AS NUMERIC(15,2);
```

### 2. CLIENTES

- Cliente_ID (PK): UUID
- TAX_ID: VARCHAR(100)
- Nombre_1: VARCHAR(25)
- Nombre_2: VARCHAR(25)
- Apellido_P: VARCHAR(25)
- Apellido_M: VARCHAR(25)
- Contacto: contacto_formateado
- EMail: email_formateado

### 3. CUENTAS

- Cuenta_ID (PK): UUID
- Cliente_ID (FK): UUID
- Tipo: core.tipo_cuenta
- Moneda: core.tipo_moneda
- Saldo: NUMERIC(15,2)
- Limite_Credito: NUMERIC(15,2)

### 4. TRANSACCIONES

- TX_ID (PK): UUID
- Cuenta_ID (FK): UUID
- Cliente_ID (FK): UUID
- Tipo_Transaccion: core.tipo_transaccion
- Fecha_TX: TIMESTAMPTZ
- Monto_TX: NUMERIC(15,2)
