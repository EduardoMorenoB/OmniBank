CREATE SCHEMA IF NOT EXISTS core;

CREATE TABLE core.customers (
    customer_id UUID DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(30),
    tax_id VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,

    CONSTRAINT pk_customers PRIMARY KEY (customer_id),
    CONSTRAINT uq_customers_email UNIQUE (email),
    CONSTRAINT uq_customers_tax_id UNIQUE (tax_id)
);

CREATE TYPE core.currency AS ENUM ('USD', 'EUR', 'MXN', 'GBP');
CREATE TYPE core.tx_type AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER');
CREATE TYPE core.account_type AS ENUM ('CHECKING', 'SAVINGS', 'CREDIT');

CREATE TABLE core.accounts (
    account_id UUID DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    account_number VARCHAR(30) NOT NULL,
    currency core.currency DEFAULT 'USD' NOT NULL,
    account_type core.account_type DEFAULT 'CHECKING' NOT NULL,
    balance NUMERIC(15,2) DEFAULT 0.00 NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,

    CONSTRAINT pk_accounts PRIMARY KEY (account_id),
    CONSTRAINT uq_accounts_number UNIQUE (account_number),
    CONSTRAINT chk_accounts_balance_not_negative CHECK (balance >= 0.00),
    CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id)
        REFERENCES core.customers(customer_id) ON DELETE RESTRICT
);
CREATE TABLE core.loans (
    loan_id UUID DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    loan_number VARCHAR(30) NOT NULL,
    principal_amount NUMERIC(15, 2) NOT NULL,
    interest_rate NUMERIC(6, 4) NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE' NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
