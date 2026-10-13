SELECT
    transaction_id,
    amount,
    tx_type,
    tx_timestamp,
    COALESCE(
        description,
        'EXCLUSIÓN oportunamente detectada'
    ) AS descripcion_monitoreada
FROM core.transactions
WHERE
(
    (
        amount >= 1000.00
        AND tx_type IN ('TRANSFER', 'WITHDRAWAL')
    )
    OR
    (
        description ILIKE '%crypto%'
        OR description ILIKE '%offshore%'
        OR description ILIKE '%shell%'
        OR description ILIKE '%cashout%'
    )
    OR
    (
        NULLIF(TRIM(description), '') IS NULL
        AND tx_type <> 'DEPOSIT'
    )
)
ORDER BY amount DESC;

SELECT
    transaction_id,
    account_id,
    tx_type,
    amount,
    COALESCE(NULLIF(TRIM(description), ''), 'SIN DESCRIPCIÓN') AS visible_description
FROM core.transactions
WHERE (tx_type IN ('TRANSFER', 'WITHDRAWAL') AND amount >= 100)
   OR (tx_type = 'WITHDRAWAL' AND NULLIF(TRIM(description), '') IS NULL)
ORDER BY amount DESC, transaction_id;

/*
Corrección: Según la clave pude notar que el umbral didáctico es 100 en TRANSFER y WITHDRAWAL, que el retiro de 50 entra solo porque no tiene descripción, y que el depósito no cumple ninguno de los dos bloques. Una alerta así pide revisión, no es una acusación.
*/
