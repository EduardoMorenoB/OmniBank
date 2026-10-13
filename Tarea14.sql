SELECT account_id, account_type, owner_name
FROM accounts
WHERE is_active = true
AND NOT EXISTS (
    SELECT 1
    FROM events
    WHERE events.account_id = accounts.account_id
    AND event_type = 'DEPOSIT'
);

SELECT COUNT(*) AS total_activas_sin_deposito
FROM accounts
WHERE is_active = true
AND NOT EXISTS (
    SELECT 1
    FROM events
    WHERE events.account_id = accounts.account_id
    AND event_type = 'DEPOSIT'
);
