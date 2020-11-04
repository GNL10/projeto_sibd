-- ADD drop tables
-- e.g. drop table if exists loan cascade;
CREATE TABLE person(
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
phone VARCHAR(15) NOT NULL,
tax_id VARCHAR(20) NOT NULL,
PRIMARY KEY (name, address),
UNIQUE(phone, tax_id)
);
