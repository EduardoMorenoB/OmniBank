BEGIN;

INSERT INTO core.customers (
    customer_id, first_name, last_name, email, phone, tax_id
)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'John', 'Doe',
     'john.doe@email.com', '555-0100', 'TAX-100'),
    ('22222222-2222-2222-2222-222222222222', 'Jane', 'Smith',
     'jane.smith@email.com', '555-0200', 'TAX-200'),
    ('33333333-3333-3333-3333-333333333333', 'Alice', 'Johnson',
     'alice.j@email.com', '555-0300', 'TAX-300')
ON CONFLICT (email) DO NOTHING;

INSERT INTO core.accounts (
    account_id, customer_id, account_number, account_type, balance
)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     '11111111-1111-1111-1111-111111111111',
     'ACCT-1001', 'CHECKING', 5000.00),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     '22222222-2222-2222-2222-222222222222',
     'ACCT-2001', 'SAVINGS', 15000.00),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc',
     '33333333-3333-3333-3333-333333333333',
     'ACCT-3001', 'CREDIT', 0.00)
ON CONFLICT (account_number) DO NOTHING;

INSERT INTO core.transactions (
    transaction_id, account_id, tx_type,
    amount, tx_timestamp, description
)
VALUES
    ('10000000-0000-0000-0000-000000000001',
     'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
     'TRANSFER', 150.00, '2026-09-01 10:00+00',
     'Pago de cena hacia Jane'),
    ('10000000-0000-0000-0000-000000000002',
     'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
     'TRANSFER', 300.00, '2026-09-02 10:00+00',
     'Abono a tarjeta de Alice')
ON CONFLICT (transaction_id) DO NOTHING;

WITH fee AS (
    INSERT INTO core.transactions (
        transaction_id, account_id, tx_type,
        amount, tx_timestamp, description
    )
    VALUES (
        '10000000-0000-0000-0000-000000000003',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'WITHDRAWAL', 50.00, '2026-09-03 10:00+00',
        'Comision bancaria mensual'
    )
    ON CONFLICT (transaction_id) DO NOTHING
    RETURNING account_id, amount
)
UPDATE core.accounts AS a
SET balance = a.balance - fee.amount,
    updated_at = CURRENT_TIMESTAMP
FROM fee
WHERE a.account_id = fee.account_id
  AND a.account_number = 'ACCT-1001'
RETURNING a.account_number, a.balance;

COMMIT;

/*
Pude notar que había realizado correctamente la inserción de los
clientes, las cuentas y las transacciones iniciales, utilizando
ON CONFLICT para evitar registros duplicados. Después de revisar
mi actividad, observé que podía mejorar la organización del código
y mantener una relación directa entre la inserción de la comisión
y la actualización del saldo mediante RETURNING. También comprendí
que esta estructura permite descontar los 50.00 únicamente cuando
se registra una nueva comisión, evitando que el saldo vuelva a
disminuir al ejecutar el archivo nuevamente.
*/
