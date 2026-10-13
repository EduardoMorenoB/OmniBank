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
