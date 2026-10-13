
/*
CORRECCION

Pude notar que había agregado correctamente el IBAN, la puntuación crediticia y el nuevo tipo ENUM para los préstamos, pero observé que olvidé utilizar BEGIN y COMMIT para ejecutar la migración dentro de una transacción. Después de revisar mi actividad, comprendí que estos comandos permiten proteger los cambios realizados en las tablas y revertirlos si ocurre algún error antes de confirmar la transacción. También confirmé que había utilizado correctamente USING para convertir el estado de los préstamos al nuevo tipo ENUM.
*/

BEGIN;

CREATE TYPE core.loan_status_enum AS ENUM (
    'ACTIVE',
    'PAID',
    'DEFAULTED',
    'CANCELLED'
);

ALTER TABLE core.customers
    ADD COLUMN credit_score INTEGER NULL;

ALTER TABLE core.customers
    ADD CONSTRAINT chk_customers_credit_score_range
    CHECK (credit_score BETWEEN 300 AND 850);

ALTER TABLE core.accounts
    ADD COLUMN iban VARCHAR(34) NULL;

ALTER TABLE core.accounts
    ADD CONSTRAINT uq_accounts_iban UNIQUE (iban);

ALTER TABLE core.loans
    ALTER COLUMN status DROP DEFAULT,
    ALTER COLUMN status TYPE core.loan_status_enum
        USING status::core.loan_status_enum,
    ALTER COLUMN status
        SET DEFAULT 'ACTIVE'::core.loan_status_enum;

COMMIT;

/* FIN de correccion */
