1.  identificar entidades 
 a. Cliente b. cuenta c. transaccion

2. Recursos Funcionales
 a. Cliente debe tener Nombre Completo, Correo, Telefono, Fecha Nacimiento, TaxID
 b. Cuenta ddebe tener N. cuenta, Moneda, Tipo Cambio, Saldo, tipo de cuenta, limite credito
 c. Transaccion debe tener cuenta origen, cuenta destino, monto, tipo transaccion, fecha y hora

3. Los datos de los clientes ddeben ser unicos (correos, telefonos y TaxID no pueden repetirse entre clientes) Y las transacciones ben tener idenfiticadores unicos (id transaccion) y no pueden repetirse entre transacciones.


## Correccion. 

Pude notar que identifiqué correctamente las tres entidades principales del sistema bancario, pero observé que confundí los requisitos funcionales con los atributos que debe almacenar cada entidad y no había explicado claramente las operaciones que debe permitir el sistema. 

### 1. Identificar entidades

a. Clientes
b. Cuentas
c. Transacciones

### 2. Requisitos funcionales

a. El sistema debe permitir registrar clientes con nombre completo, correo electrónico, teléfono, fecha de nacimiento y TaxID.

b. El sistema debe permitir registrar cuentas bancarias con número de cuenta, moneda, saldo, tipo de cuenta y límite de crédito cuando corresponda.

c. El sistema debe permitir registrar transacciones con cuenta de origen, cuenta de destino, monto, tipo de transacción, fecha y hora.

### 3. Restricciones

a. Los correos electrónicos, teléfonos y TaxID no deben repetirse entre clientes.

b. Cada transacción debe tener un identificador único que no pueda repetirse.

c. Cada número de cuenta debe ser único.

d. Las cuentas deben estar asociadas a clientes registrados en el sistema.

e. Las transacciones deben relacionarse con las cuentas correspondientes.
