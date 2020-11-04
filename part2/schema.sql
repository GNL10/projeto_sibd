-- TODO: ADD drop tables
-- e.g. drop table if exists loan cascade;
drop table if exists person cascade;
drop table if exists supervisor cascade;
drop table if exists analyst cascade;

----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

-- EXAMPLE
--create table account
--   (account_number  char(5) not null,
--    branch_name     varchar(80) not null,
--    balance         numeric(16,4) not null,
--   constraint pk_account primary key(account_number),
--    constraint fk_account_branch foreign key(branch_name) references branch(branch_name));

CREATE TABLE person(
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
phone VARCHAR(15) NOT NULL,
tax_id VARCHAR(20) NOT NULL,
PRIMARY KEY (name, address),
UNIQUE(phone, tax_id)
);

CREATE TABLE supervisor (
name VARCHAR(80) NOT NULL,
PRIMARY KEY(name),
FOREIGN KEY(name) REFERENCES person(name)
);

CREATE TABLE analyst (
name VARCHAR(80) NOT NULL,
PRIMARY KEY(name),
FOREIGN KEY (name) REFERENCES person(name)
);


----------------------------------------
-- Populate Relations
----------------------------------------