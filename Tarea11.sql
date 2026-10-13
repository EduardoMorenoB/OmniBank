SELECT
    COUNT(*) AS total_cuentas,
    COUNT(*) FILTER (
        WHERE is_active = FALSE
    ) AS cuentas_desactivadas,
    ROUND(
        (
            COUNT(*) FILTER (
                WHERE is_active = FALSE
            )
        )::NUMERIC
        / NULLIF(COUNT(*), 0) * 100,
        2
    ) AS porcentaje_desactivadas
FROM core.accounts;
