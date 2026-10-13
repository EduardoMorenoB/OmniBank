-- PUNTO 1

SELECT
    account_number,
    account_type,
    balance
FROM core.accounts
WHERE (balance >= 1000.00 OR account_type = 'SAVINGS')
ORDER BY balance DESC
LIMIT 2;


-- PUNTO 2

SELECT
    first_name,
    last_name,
    email
FROM core.customers
WHERE email ILIKE '%@email.com';


-- PUNTO 3

SELECT
    account_id,
    amount,
    tx_type,
    COALESCE(
        description,
        'COBRO INSTITUCIONAL O COMISIÓN - SIN RECEPTOR'
    ) AS descripcion_visible
FROM core.transactions
WHERE description IS NULL
  AND tx_type = 'WITHDRAWAL';
