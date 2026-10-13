# Actividad: Normalizando el Prototipo Monolítico de OmniBank

## Paso 1. Primera Forma Normal (1NF)

La Primera Forma Normal indica que cada columna debe contener un solo valor y no debe mezclar varios datos dentro del mismo campo.

En la tabla original existen dos columnas que violan esta regla:

- `cliente_nombre_y_contacto` contiene nombre, correo y teléfono.
- `moneda_y_tipo` contiene la moneda y el tipo de cuenta.

Por lo tanto, estos campos deben separarse.

La tabla en **1NF** quedaría aproximadamente así:

| Columna |
|---|
| transaccion_id |
| fecha_tx |
| cliente_tax_id |
| cliente_nombre |
| cliente_email |
| cliente_telefono |
| cuenta_numero |
| moneda |
| tipo_cuenta |
| saldo_actual |
| monto_tx |
| sucursal_codigo |
| sucursal_direccion |

### Ejemplo

| transaccion_id | fecha_tx | cliente_tax_id | cliente_nombre | cliente_email | cliente_telefono | cuenta_numero | moneda | tipo_cuenta | saldo_actual | monto_tx | sucursal_codigo | sucursal_direccion |
|---|---|---|---|---|---|---|---|---|---:|---:|---|---|
| TX-0001 | 2026-07-20 | TAX-9911 | Roberto Soto | rob@mail.com | 555-9011 | CTA-100 | USD | Checking | 1500.00 | +500.00 | S-CDMX | Av. Juárez #100 |
| TX-0002 | 2026-07-21 | TAX-9911 | Roberto Soto | rob@mail.com | 555-9011 | CTA-100 | USD | Checking | 1300.00 | -200.00 | S-CDMX | Av. Juárez #100 |

Aunque ahora los datos son atómicos, todavía existe mucha información repetida.

---

# Paso 2. Segunda Forma Normal (2NF)

En este caso la llave primaria de la tabla sería:

`transaccion_id`

La 2NF busca que los atributos dependan correctamente de la llave primaria.

Aquí aparece un detalle importante: como `transaccion_id` es una llave primaria de una sola columna, técnicamente no existen dependencias parciales de una llave compuesta.

Sin embargo, la tabla continúa estando mal diseñada porque muchos datos no pertenecen realmente a la transacción.

Por ejemplo:

- `cliente_nombre` depende de `cliente_tax_id`.
- `cliente_email` depende de `cliente_tax_id`.
- `cliente_telefono` depende de `cliente_tax_id`.
- `moneda` depende de `cuenta_numero`.
- `tipo_cuenta` depende de `cuenta_numero`.
- `saldo_actual` depende de `cuenta_numero`.
- `sucursal_direccion` depende de `sucursal_codigo`.

Por esta razón, aunque la tabla pueda cumplir formalmente con una interpretación básica de 2NF, todavía presenta dependencias que deben eliminarse para llegar correctamente a 3NF.

---

# Paso 3. Tercera Forma Normal (3NF)

La Tercera Forma Normal busca eliminar las dependencias transitivas.

Un atributo que no sea llave no debe depender de otro atributo que tampoco sea llave.

Por ejemplo:

`transaccion_id → cliente_tax_id → cliente_nombre`

El nombre del cliente realmente depende de `cliente_tax_id`, no directamente de la transacción.

También ocurre:

`transaccion_id → sucursal_codigo → sucursal_direccion`

La dirección depende de la sucursal y no de la transacción.

Por eso debemos separar la información en diferentes tablas.

---

# Tablas resultantes en 3NF

## 1. Clientes

| Columna | Tipo de llave |
|---|---|
| cliente_tax_id | **(PK)** |
| cliente_nombre | |
| cliente_email | |
| cliente_telefono | |

### Ejemplo

| cliente_tax_id | cliente_nombre | cliente_email | cliente_telefono |
|---|---|---|---|
| TAX-9911 | Roberto Soto | rob@mail.com | 555-9011 |

La información del cliente solamente se guarda una vez.

---

## 2. Sucursales

| Columna | Tipo de llave |
|---|---|
| sucursal_codigo | **(PK)** |
| sucursal_direccion | |

### Ejemplo

| sucursal_codigo | sucursal_direccion |
|---|---|
| S-CDMX | Av. Juárez #100 |

De esta manera no es necesario repetir la dirección en cada transacción.

---

## 3. Cuentas

| Columna | Tipo de llave |
|---|---|
| cuenta_numero | **(PK)** |
| cliente_tax_id | **(FK)** |
| sucursal_codigo | **(FK)** |
| moneda | |
| tipo_cuenta | |
| saldo_actual | |

### Relaciones

`cliente_tax_id (FK) → Clientes.cliente_tax_id`

`sucursal_codigo (FK) → Sucursales.sucursal_codigo`

### Ejemplo

| cuenta_numero | cliente_tax_id | sucursal_codigo | moneda | tipo_cuenta | saldo_actual |
|---|---|---|---|---|---:|
| CTA-100 | TAX-9911 | S-CDMX | USD | Checking | 1300.00 |

La cuenta pertenece a un cliente y se encuentra asociada a una sucursal.

---

## 4. Transacciones

| Columna | Tipo de llave |
|---|---|
| transaccion_id | **(PK)** |
| cuenta_numero | **(FK)** |
| fecha_tx | |
| monto_tx | |

### Relación

`cuenta_numero (FK) → Cuentas.cuenta_numero`

### Ejemplo

| transaccion_id | cuenta_numero | fecha_tx | monto_tx |
|---|---|---|---:|
| TX-0001 | CTA-100 | 2026-07-20 | +500.00 |
| TX-0002 | CTA-100 | 2026-07-21 | -200.00 |

Ahora una transacción solamente almacena los datos propios de la operación bancaria.

---

# Relación final entre las tablas

```text
CLIENTES
-------------------------
cliente_tax_id (PK)
cliente_nombre
cliente_email
cliente_telefono
        |
        | 1
        |
        | N
CUENTAS
-------------------------
cuenta_numero (PK)
cliente_tax_id (FK)
sucursal_codigo (FK)
moneda
tipo_cuenta
saldo_actual
        |
        | 1
        |
        | N
TRANSACCIONES
-------------------------
transaccion_id (PK)
cuenta_numero (FK)
fecha_tx
monto_tx


SUCURSALES
-------------------------
sucursal_codigo (PK)
sucursal_direccion
        |
        | 1
        |
        | N
CUENTAS
```

## Resultado

Después de aplicar 1NF, 2NF y 3NF, el prototipo monolítico se divide en cuatro tablas:

### Clientes

`cliente_tax_id (PK)`  
`cliente_nombre`  
`cliente_email`  
`cliente_telefono`

### Cuentas

`cuenta_numero (PK)`  
`cliente_tax_id (FK)`  
`sucursal_codigo (FK)`  
`moneda`  
`tipo_cuenta`  
`saldo_actual`

### Transacciones

`transaccion_id (PK)`  
`cuenta_numero (FK)`  
`fecha_tx`  
`monto_tx`

### Sucursales

`sucursal_codigo (PK)`  
`sucursal_direccion`

Con esta estructura se evita repetir los datos del cliente y de las sucursales en cada transacción, se reducen las anomalías de actualización y se conserva la integridad de las relaciones mediante llaves primarias y foráneas.
