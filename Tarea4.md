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