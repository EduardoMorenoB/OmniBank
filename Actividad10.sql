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
