UUID: Identificador único universal utilizado para identificar
cada registro. Las llaves primarias y foráneas relacionadas
deben utilizar el mismo tipo de dato.

CLIENTES:
* cliente_id UUID (PK)
* nombre VARCHAR NOT NULL
* correo VARCHAR UNIQUE, NOT NULL
* telefono VARCHAR
* fecha_nacimiento DATE
* tax_id VARCHAR UNIQUE
* deleted_at TIMESTAMP (NULL = cliente activo)

CUENTAS:
* cuenta_id UUID (PK)
* cliente_id UUID (FK -> Clientes)
* tipo_cuenta VARCHAR NOT NULL
* saldo_actual DECIMAL CHECK (saldo_actual >= 0)
* limite_credito DECIMAL
* moneda VARCHAR NOT NULL
* updated_at TIMESTAMP NOT NULL

TRANSACCIONES:
* transaccion_id UUID (PK)
* from_account UUID (FK -> Cuentas)
* to_account UUID (FK -> Cuentas)
* monto DECIMAL
* tipo_transaccion VARCHAR NOT NULL
* fecha_completada TIMESTAMP NOT NULL


RELACIONES:

[Clientes] 1 ---------------- N [Cuentas]

[Cuentas] 1 ---------------- N [Transacciones]
           (Cuenta de origen)

[Cuentas] 1 ---------------- N [Transacciones]
           (Cuenta de destino)


### Correcciones y aprendizajes
Pude notar que identifiqué correctamente las entidades,
sus relaciones y el uso de UUID en las llaves primarias
y foráneas, pero olvidé agregar algunos atributos como
telefono, fecha_nacimiento y tax_id con su restricción
UNIQUE. También aprendí que deleted_at es una forma
válida de implementar la baja lógica y que updated_at
permite registrar la última modificación de una cuenta.
Comprendí que cada transacción debe relacionarse con
una cuenta de origen y otra de destino mediante
llaves foráneas UUID.
