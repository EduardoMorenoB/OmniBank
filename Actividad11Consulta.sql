SELECT 
a.account_id, 
a.account_number,
a.is_active,
c.first_name,
c.5email,
CONCAT(UPPER(TRIM(c.first_name)), '-', RIGHT(a.account_number, 4)) AS etiqueta 
FROM core.accounts AS a 
JOIN core.customers AS c USING (customer_id)
ORDER BY a.account_number;

SELECT
transaction_id,
account_id,
tx_timestamp,
amount,
tx_timestamp + INTERVAL '15 days' AS fecha_revision
FROM core.transactions
WHERE tx_timestamp < TIMESTAMPTZ '2026-09-10 00:00+00'
ORDER BY tx_timestamp;
