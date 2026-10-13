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
