WITH muestra(valor) AS (
    VALUES
        (10000::NUMERIC),
        (0::NUMERIC),
        (0::NUMERIC),
        (NULL::NUMERIC)
)
SELECT
    AVG(valor) AS promedio_ignorando_null,
    COUNT(valor) AS observaciones_promedio,
    AVG(COALESCE(valor, 0)) AS promedio_null_cero,
    COUNT(*) AS observaciones_usadas_coalesce
FROM muestra;


SELECT
    a.account_id,
    a.account_number,
    a.balance AS saldo_almacenado,
    COUNT(t.transaction_id) AS movimientos_reg,
    COALESCE(SUM(t.amount), 0) AS volumen_bruto_reg
FROM core.accounts AS a
LEFT JOIN core.transactions AS t
    ON t.account_id = a.account_id
WHERE
    a.account_type = 'CREDIT'
    AND a.is_active = TRUE
GROUP BY
    a.account_id,
    a.account_number,
    a.balance
HAVING
    COUNT(t.transaction_id) > 0
    OR COALESCE(SUM(t.amount), 0) >= 300
ORDER BY
    a.account_number;
