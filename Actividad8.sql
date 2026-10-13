-- PUNTO 1

SELECT
    account_number,
    account_type,
    balance
FROM core.accounts
WHERE (balance >= 1000.00 OR account_type = 'SAVINGS')
ORDER BY balance DESC
LIMIT 2;


-- PUNTO 2

SELECT
    first_name,
    last_name,
    email
FROM core.customers
WHERE email ILIKE '%@email.com';


-- PUNTO 3

SELECT
    account_id,
    amount,
    tx_type,
    COALESCE(
        description,
        'COBRO INSTITUCIONAL O COMISIÓN - SIN RECEPTOR'
    ) AS descripcion_visible
FROM core.transactions
WHERE description IS NULL
  AND tx_type = 'WITHDRAWAL';


/*
Pude notar que había utilizado correctamente SELECT con columnas
específicas, ORDER BY, LIMIT, ILIKE, IS NULL y COALESCE, pero
observé que en el segundo punto me faltaba incluir el símbolo @
en el patrón del correo electrónico. También identifiqué que
en el tercer punto había omitido las columnas account_id y amount.
Después de revisar mi actividad, comprendí la importancia de
seleccionar todas las columnas solicitadas y definir correctamente
los filtros para obtener resultados más precisos.
*/
