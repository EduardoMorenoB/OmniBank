SELECT COUNT(*) AS total_clientes
FROM core.customers;

SELECT COUNT(*) AS total_cuentas
FROM core.accounts;

SELECT COUNT(*) AS total_movimientos
FROM core.transactions;


SELECT COUNT(*) AS total_combinaciones
FROM core.customers c
CROSS JOIN core.accounts a
CROSS JOIN core.transactions t;


-- Reporte de movimientos
SELECT
    c.email,
    a.account_number,
    t.tx_type,
    t.amount,
    t.tx_timestamp
FROM core.transactions t
INNER JOIN core.accounts a
    ON t.account_id = a.account_id
INNER JOIN core.customers c
    ON a.customer_id = c.customer_id
WHERE a.is_active = TRUE
    AND t.amount > 100
ORDER BY t.tx_timestamp;

-- Se encontraron 4 clientes, 5 cuentas y 4 movimientos.
-- El producto cartesiano dio 80 combinaciones.
-- El reporte corregido debe mostrar 3 movimientos.
-- La diferencia ocurre porque CROSS JOIN combina todos los
-- registros sin comprobar las relaciones entre las tablas.
-- INNER JOIN relaciona las cuentas con sus clientes y movimientos.
-- WHERE reduce los resultados a los movimientos mayores de 100.


/*
Corrección: Según la clave pude notar que el CROSS JOIN solo sirve para contar las 80 combinaciones, y que el reporte real une por account_id y customer_id. El filtro es c.is_active y amount >= 100, no la cuenta activa ni un mayor estricto. El orden es tx_timestamp y transaction_id. Salen 3 movimientos, no 80.
*/

SELECT
    (SELECT COUNT(*) FROM core.customers) AS customers,
    (SELECT COUNT(*) FROM core.accounts) AS accounts,
    (SELECT COUNT(*) FROM core.transactions) AS transactions;

SELECT COUNT(*) AS combinations
FROM core.customers
CROSS JOIN core.accounts
CROSS JOIN core.transactions;

SELECT c.email, a.account_number, t.tx_type, t.amount, t.tx_timestamp
FROM core.transactions t
JOIN core.accounts a ON a.account_id = t.account_id
JOIN core.customers c ON c.customer_id = a.customer_id
WHERE c.is_active AND t.amount >= 100
ORDER BY t.tx_timestamp, t.transaction_id;
