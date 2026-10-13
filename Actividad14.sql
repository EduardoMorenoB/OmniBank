SELECT
    e1.account_id,
    e1.event_id,
    e2.event_id
FROM events e1
JOIN events e2
    ON e1.account_id = e2.account_id
    AND e1.event_id < e2.event_id
    AND e2.created_at <= e1.created_at + INTERVAL '48 hours';


SELECT
    c.customer_name,
    t.account_type
FROM customers c
CROSS JOIN (
    SELECT DISTINCT account_type
    FROM accounts
)  
WHERE NOT EXISTS (
    SELECT 1 
    FROM accounts a
    WHERE a.customer_id = c.customer_id
        AND a.account_type = t.account_type
);


/*
Corrección: Según la clave pude notar que el self JOIN necesita desigualdad estricta para no duplicar el par, y que la matriz sale del enum de tipos, no de sucursales ni de la moneda. John tiene un par de movimientos en la misma cuenta. Lo que falta es una combinación titular-tipo, no una cuenta real.
*/

SELECT t1.account_id, t1.transaction_id AS earlier_id, t2.transaction_id AS later_id
FROM core.transactions t1
JOIN core.transactions t2
  ON t1.account_id = t2.account_id
 AND (t1.tx_timestamp, t1.transaction_id) < (t2.tx_timestamp, t2.transaction_id)
 AND t2.tx_timestamp <= t1.tx_timestamp + INTERVAL '48 hours'
ORDER BY t1.account_id, t1.tx_timestamp;

WITH types AS (
    SELECT unnest(enum_range(NULL::core.tipo_cuenta)) AS account_type
)
SELECT c.customer_id, c.email, ty.account_type
FROM core.customers c
CROSS JOIN types ty
LEFT JOIN core.accounts a
  ON a.customer_id = c.customer_id
 AND a.account_type = ty.account_type
WHERE a.account_id IS NULL
ORDER BY c.email, ty.account_type;
