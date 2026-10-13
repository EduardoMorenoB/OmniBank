
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
