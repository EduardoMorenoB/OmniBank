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
