SELECT
    a.account_number,
    a.account_type,
    a.balance
FROM core.accounts a
WHERE a.is_active
    AND NOT EXISTS (
        SELECT 1
        FROM core.transactions t
        WHERE t.account_id = a.account_id
    )
ORDER BY a.account_number;


SELECT
    a.account_number,
    a.is_active
FROM core.accounts a
WHERE NOT EXISTS (
    SELECT 1
    FROM core.transactions t
    WHERE t.account_id = a.account_id
        AND t.tx_type = 'DEPOSIT'
)
ORDER BY a.account_number;


WITH valores(x) AS (
    VALUES (1), (NULL::INTEGER)
)
SELECT
    2 NOT IN (SELECT x FROM valores) AS not_in_with_null,
    NOT EXISTS (
        SELECT 1
        FROM valores
        WHERE x = 2
    ) AS not_exists_result;

/*
Corrección: Según la clave pude notar que solo ACCT-3002 está activa y sin eventos, y que cuatro cuentas no tienen DEPOSIT: ACCT-1001, ACCT-1002, ACCT-2001 y ACCT-3002. No es lo mismo. NOT IN con un NULL da UNKNOWN; NOT EXISTS solo pregunta si existe x=2 y devuelve TRUE si no está.
*/
