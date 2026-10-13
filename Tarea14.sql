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


/*
Corrección: Según la clave pude notar que tres cuentas activas no tienen DEPOSIT: ACCT-1001, ACCT-2001 y ACCT-3002. Las dos primeras sí tienen otros movimientos, así que falta de depósito no es falta de actividad. El anti join busca solo tx_type = 'DEPOSIT'.
*/

SELECT a.account_number, a.account_type, c.first_name, c.last_name
FROM core.accounts a
JOIN core.customers c ON c.customer_id = a.customer_id
LEFT JOIN core.transactions t
  ON t.account_id = a.account_id
 AND t.tx_type = 'DEPOSIT'
WHERE a.is_active
  AND t.transaction_id IS NULL
ORDER BY a.account_number;
