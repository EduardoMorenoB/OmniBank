WITH account_metrics AS (
    SELECT
        a.account_id,
        a.currency,
        COALESCE(SUM(e.amount), 0) AS total_amount
    FROM accounts a
    LEFT JOIN events e
        ON e.account_id = a.account_id
    WHERE a.is_active = TRUE
    GROUP BY a.account_id, a.currency
)
SELECT
    currency,
    COUNT(account_id) AS total_accounts,
    SUM(total_amount) AS gross_volume,
    ROUND(AVG(total_amount), 2) AS avg_volume_per_account
FROM account_metrics
GROUP BY currency;


/*
Corrección: Según la clave pude notar que el volumen se arma primero por cuenta y el LEFT JOIN conserva las activas en cero antes de agrupar por moneda. La semilla da una fila USD, cuatro cuentas, volumen 800 y promedio 200. Si agrego despues de un join que multiplica eventos, el total y el denominador cambian.
*/

WITH movement AS (
    SELECT account_id, SUM(amount) AS gross_volume
    FROM core.transactions
    GROUP BY account_id
),
account_metrics AS (
    SELECT a.account_id, a.currency, COALESCE(m.gross_volume, 0) AS gross_volume
    FROM core.accounts a
    LEFT JOIN movement m USING (account_id)
    WHERE a.is_active
),
by_currency AS (
    SELECT currency, COUNT(*) AS account_count, SUM(gross_volume) AS gross_volume
    FROM account_metrics
    GROUP BY currency
)
SELECT currency, account_count, gross_volume,
       ROUND(gross_volume / account_count, 2) AS average_per_account
FROM by_currency
ORDER BY currency;

SELECT (SELECT COUNT(*) FROM core.accounts WHERE is_active) AS active_accounts,
       (SELECT COALESCE(SUM(amount), 0) FROM core.transactions) AS direct_gross_volume,
       (SELECT COUNT(*) FROM core.transactions t
        JOIN core.accounts a USING (account_id)
        WHERE a.account_number = 'ACCT-3002') AS empty_account_events;
