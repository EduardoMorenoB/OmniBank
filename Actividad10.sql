SELECT
    account_type,
    COUNT(*) AS cantidad_cuentas,
    SUM(balance) AS saldo_total,
    MIN(balance) AS saldo_minimo,
    MAX(balance) AS saldo_maximo,
    AVG(balance) AS saldo_promedio
FROM core.accounts
WHERE is_active = TRUE
GROUP BY account_type
HAVING COUNT(*) > 0
ORDER BY saldo_total DESC, account_type ASC;


SELECT
    COUNT(*) AS cuentas_activas_verificadas,
    SUM(a.balance) AS saldo_total_verificado
FROM core.accounts a
WHERE a.is_active = TRUE;


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    COUNT(t.transaction_id) AS cantidad_movimientos,
    COALESCE(SUM(t.amount), 0) AS volumen_bruto_reg,
    MIN(t.amount) AS importe_movimiento_minimo,
    MAX(t.amount) AS importe_movimiento_maximo,
    AVG(t.amount) AS importe_movimiento_promedio
FROM core.customers c
LEFT JOIN core.accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN core.transactions t
    ON t.account_id = a.account_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(t.transaction_id) >= 2
    OR COALESCE(SUM(t.amount), 0) > 100
ORDER BY volumen_bruto_reg DESC, c.email;


SELECT
    t.account_id,
    COUNT(t.transaction_id) AS cantidad_movimientos,
    SUM(t.amount) AS volumen_bruto_reg,
    MIN(t.amount) AS importe_movimiento_minimo,
    MAX(t.amount) AS importe_movimiento_maximo,
    AVG(t.amount) AS importe_movimiento_promedio
FROM core.transactions t
GROUP BY t.account_id
HAVING COUNT(t.transaction_id) > 0
ORDER BY t.account_id;


/*
Corrección: Según la clave pude notar que el saldo sale solo de accounts y suma 19950 (CHECKING 4950, SAVINGS 15000, CREDIT 0), y que los cuatro eventos suman 800 en transactions. No es el saldo de ninguna cuenta. COUNT(transaction_id) no le inventa un movimiento a Humberto, y HAVING se evalua despues de agrupar.
*/

SELECT account_type,
       COUNT(*) AS account_count,
       SUM(balance) AS stored_balance_total,
       MIN(balance) AS smallest_stored_balance,
       MAX(balance) AS largest_stored_balance,
       ROUND(AVG(balance), 2) AS average_stored_balance
FROM core.accounts
WHERE is_active
GROUP BY account_type
ORDER BY stored_balance_total DESC, account_type;

SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(t.transaction_id) AS recorded_event_count,
       COALESCE(SUM(t.amount), 0) AS recorded_gross_volume
FROM core.customers c
LEFT JOIN core.accounts a ON a.customer_id = c.customer_id
LEFT JOIN core.transactions t ON t.account_id = a.account_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(t.transaction_id) >= 2 OR COALESCE(SUM(t.amount), 0) > 100
ORDER BY recorded_gross_volume DESC, c.email;

SELECT COUNT(*) AS active_accounts, SUM(balance) AS stored_balance_total
FROM core.accounts
WHERE is_active;

SELECT COUNT(*) AS recorded_events, SUM(amount) AS recorded_gross_volume
FROM core.transactions;
