
-- ACTIVIDAD 9: REPORTES RELACIONALES DE OMNI_BANK

-- RECUENTOS

SELECT COUNT(*) AS total_clientes
FROM core.customers;

SELECT COUNT(*) AS total_accounts
FROM core.accounts;

SELECT COUNT(*) AS total_transactions
FROM core.transactions;


-- CONSULTA 1: RECORRIDO DE MOVIMIENTOS

SELECT t.transaction_id, c.first_name, c.last_name, a.account_number, t.tx_type, t.amount
FROM core.transactions t
INNER JOIN core.accounts a
    ON t.account_id = a.account_id
INNER JOIN core.customers c
    ON a.customer_id = c.customer_id
ORDER BY t.tx_timestamp, t.transaction_id;


-- CONSULTA 2: CUENTAS SIN MOVIMIENTOS

SELECT a.account_number, a.is_active,
    CASE
        WHEN a.is_active = TRUE
            THEN 'CUENTA ACTIVA SIN MOVIMIENTOS'
        ELSE 'CUENTA DESACTIVADA SIN MOVIMIENTOS'
    END AS etiqueta_actividad
FROM core.accounts a
LEFT JOIN core.transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


-- CONSULTA 3: TITULARES CON CUENTAS ELEGIBLES

SELECT c.email, a.account_number, a.balance
FROM core.customers c
LEFT JOIN core.accounts a
    ON c.customer_id = a.customer_id
    AND a.balance > 0;


-- COMPARACION

SELECT c.email, a.account_number, a.balance
FROM core.customers c
LEFT JOIN core.accounts a
    ON c.customer_id = a.customer_id
WHERE a.balance > 0;
