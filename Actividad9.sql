
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


/*
Corrección: Según la clave pude notar que el recorrido sale por account_id y customer_id, que ACCT-1002 y ACCT-3002 no tienen movimientos aunque una este activa y la otra no, y que balance>0 va en el ON para no perder a Alice ni a Humberto. En el WHERE solo quedan John y Jane.
*/

SELECT
    (SELECT COUNT(*) FROM core.customers) AS customers,
    (SELECT COUNT(*) FROM core.accounts) AS accounts,
    (SELECT COUNT(*) FROM core.transactions) AS movements;

SELECT t.transaction_id, c.first_name, c.last_name, a.account_number, t.tx_type, t.amount
FROM core.transactions t
JOIN core.accounts a ON a.account_id = t.account_id
JOIN core.customers c ON c.customer_id = a.customer_id
ORDER BY t.tx_timestamp, t.transaction_id;

SELECT a.account_number, a.is_active,
       CASE WHEN a.is_active THEN 'ACTIVA SIN MOVIMIENTOS'
            ELSE 'DESACTIVADA SIN MOVIMIENTOS' END AS estado
FROM core.accounts a
LEFT JOIN core.transactions t ON t.account_id = a.account_id
WHERE t.transaction_id IS NULL
ORDER BY a.account_number;

SELECT c.email, a.account_number, a.balance
FROM core.customers c
LEFT JOIN core.accounts a
  ON a.customer_id = c.customer_id AND a.balance > 0
ORDER BY c.email, a.account_number;

SELECT c.email, a.account_number, a.balance
FROM core.customers c
LEFT JOIN core.accounts a ON a.customer_id = c.customer_id
WHERE a.balance > 0
ORDER BY c.email, a.account_number;
