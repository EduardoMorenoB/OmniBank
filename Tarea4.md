```sql
CREATE DOMAIN monto_financiero AS NUMERIC(15,2)
CHECK (VALUE >= 0.00);

CREATE DOMAIN texto_obligatorio AS VARCHAR(100)
CHECK (VALUE <> '' AND LENGTH(TRIM(VALUE)) > 0);
```

Monto financiero:
- Saldo: Saldo_usuario
- limite_credito
- Monto_retiro


Global

Date_time -> TimeStamp -> Usa la zona horaria de quien accede al registro

## Correccion

```sql
CREATE DOMAIN monto_financiero AS NUMERIC(15, 2)
    CHECK (VALUE >= 0.00);

CREATE DOMAIN texto_obligatorio AS VARCHAR(100)
    CHECK (VALUE <> '' AND LENGTH(TRIM(VALUE)) > 0);
```

monto_financiero reemplaza el tipo en:
- saldo_actual, en Cuentas
- limite_credito, en Cuentas
- monto_tx, en Transacciones

Corrección: Según la clave pude notar que el CHECK del dominio tiene que usar VALUE, y que monto_financiero va en saldo_actual, limite_credito y monto_tx, no en un saldo de usuario ni en un monto de retiro.
