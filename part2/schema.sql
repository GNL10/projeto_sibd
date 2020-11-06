-- TODO: ADD drop tables
-- e.g. drop table if exists loan cascade;
drop table if exists person cascade;
drop table if exists supervisor cascade;
drop table if exists analyst cascade;
drop table if exists substation cascade;
drop table if exists element cascade;
drop table if exists line cascade;

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
UNIQUE (phone),
UNIQUE (tax_id)
--	Every person must exist either in the table 'supervisor' or in the table 'analyst'
);

CREATE TABLE supervisor (
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
PRIMARY KEY(name, address),
FOREIGN KEY(name, address) REFERENCES person(name, address)
);

CREATE TABLE analyst (
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
PRIMARY KEY(name, address),
FOREIGN KEY(name, address) REFERENCES person(name, address)
);


CREATE TABLE substation (
gps_coords VARCHAR(80) NOT NULL, -- TODO o prof disse na aula um data type que se adequava a coordenadas
                                 -- TODO com o data type 'point' nao da, nao o deixa ser primary key
locality_name VARCHAR(80) NOT NULL,
PRIMARY KEY (gps_coords)
);



CREATE TABLE element(
id INTEGER NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE line (
id INTEGER NOT NULL,
impedance NUMERIC(8) NOT NULL,  -- TODO o prof nao precisa de ter casas decimais
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id)
);

CREATE TABLE bus_bar (
id INTEGER NOT NULL,
voltage NUMERIC(10) NOT NULL,  	--RANDOM numeric 10 choice here
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id)
);

CREATE TABLE transformer (
id INTEGER NOT NULL,
primary_voltage NUMERIC(10) NOT NULL,	--RANDOM numeric 10 choice here
secondary_voltage NUMERIC(10)  NOT NULL,	--RANDOM numeric 10 choice here
gps_coords NUMERIC(.....) ……                               #Notar que lat é num(8,6), long num(9,6)
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id)
FOREIGN KEY (gps_coords) REFERENCES substation(gps_coords)
);



----------------------------------------
-- Populate Relations
----------------------------------------
