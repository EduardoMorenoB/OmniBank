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


/*
Corrección: Según la clave pude notar que el volumen se suma primero por account_id y despues el LEFT JOIN conserva las cuentas activas vacias. ACCT-3002 sale con cero eventos. El total de la semilla es 800 y no es un saldo. Un INNER JOIN antes de eso pierde esas cuentas.
*/

WITH movement AS (
    SELECT account_id, COUNT(*) AS tx_count, SUM(amount) AS gross_volume
    FROM core.transactions
    GROUP BY account_id
),
account_metrics AS (
    SELECT a.account_id, a.account_number, a.currency, a.customer_id,
           COALESCE(m.tx_count, 0) AS tx_count,
           COALESCE(m.gross_volume, 0) AS gross_volume
    FROM core.accounts a
    LEFT JOIN movement m USING (account_id)
    WHERE a.is_active
)
SELECT c.first_name, c.last_name, am.account_number, am.currency,
       am.tx_count, am.gross_volume,
       CASE WHEN am.tx_count = 0 THEN 'SIN MOVIMIENTOS' ELSE 'CON MOVIMIENTOS' END AS activity_band
FROM account_metrics am
JOIN core.customers c USING (customer_id)
ORDER BY am.account_number;

SELECT (SELECT COUNT(*) FROM core.accounts WHERE is_active) AS active_accounts,
       (SELECT COALESCE(SUM(amount), 0) FROM core.transactions) AS direct_gross_volume;
