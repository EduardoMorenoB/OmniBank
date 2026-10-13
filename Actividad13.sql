WITH movimientos_cuenta AS (
    SELECT
        account_id,
        COUNT(*) AS eventos,
        SUM(amount) AS volumen_bruto
    FROM core.transactions
    GROUP BY account_id
),
cuentas_activas AS (
    SELECT
        a.account_id,
        a.account_number,
        a.customer_id,
        a.currency,
        COALESCE(m.eventos, 0) AS eventos,
        COALESCE(m.volumen_bruto, 0) AS volumen_bruto
    FROM core.accounts a
    LEFT JOIN movimientos_cuenta m
        ON a.account_id = m.account_id
    WHERE a.is_active
),
reporte AS (
    SELECT
        ca.account_id,
        ca.account_number,
        c.full_name AS titular,
        ca.currency,
        ca.eventos,
        ca.volumen_bruto,
        CASE
            WHEN ca.eventos = 0 THEN 'SIN ACT'
            ELSE 'CON ACTIVIDAD'
        END AS banda
    FROM cuentas_activas ca
    JOIN core.customers c
        ON c.customer_id = ca.customer_id
)
SELECT
    account_number,
    titular,
    currency,
    eventos,
    volumen_bruto,
    banda
FROM reporte
ORDER BY account_number;

SELECT COUNT(*) AS cuentas_activas
FROM core.accounts
WHERE is_active;
