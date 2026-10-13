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

/*
Corrección: Según la clave pude notar que el corte tiene que ser una fecha fija, no CURRENT_DATE, y que el reporte temporal debe traer año, mes, la revisión a 15 días y la antigüedad contra 2026-10-01. La cuenta se enmascara con los últimos 4 dígitos. Salen cinco cuentas y cuatro movimientos, del 16 al 19 de septiembre.
*/

SELECT c.email,
       CONCAT(UPPER(TRIM(c.first_name)), ' ', UPPER(TRIM(c.last_name))) AS customer_name,
       CONCAT('XXXX-', RIGHT(a.account_number, 4)) AS masked_account,
       a.account_type,
       a.balance::numeric(12, 2) AS balance
FROM core.customers c
JOIN core.accounts a USING (customer_id)
ORDER BY c.email, a.account_number;

SELECT t.transaction_id,
       t.amount::numeric(12, 2) AS amount,
       t.tx_timestamp,
       EXTRACT(YEAR FROM t.tx_timestamp)::integer AS event_year,
       EXTRACT(MONTH FROM t.tx_timestamp)::integer AS event_month,
       t.tx_timestamp + INTERVAL '15 days' AS review_on,
       AGE(TIMESTAMPTZ '2026-10-01 00:00+00', t.tx_timestamp) AS age_at_review
FROM core.transactions t
WHERE t.tx_timestamp < TIMESTAMPTZ '2026-09-10 00:00+00'
ORDER BY t.tx_timestamp;
