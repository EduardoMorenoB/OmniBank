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
