-- TODO: ADD drop tables
-- e.g. drop table if exists loan cascade;
drop table if exists person cascade;
drop table if exists supervisor cascade;
drop table if exists analyst cascade;
drop table if exists substation cascade;
drop table if exists element cascade;
drop table if exists line cascade;
drop table if exists bus_bar cascade;
drop table if exists incident cascade;
drop table if exists transformer cascade;
drop table if exists analyses cascade;
drop table if exists line_incident cascade;



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

CREATE TABLE element(
id INTEGER NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE incident (
instant TIMESTAMP NOT NULL,
description VARCHAR(255) NOT NULL,      -- varchar said by the professor
severity VARCHAR(255) NOT NULL,   --like put high or low or something (said by prof)
id INTEGER NOT NULL,
PRIMARY KEY (instant, id),
FOREIGN KEY (id) REFERENCES element(id)
);

CREATE TABLE analyses (
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
instant DATE NOT NULL,
report VARCHAR(255) NOT NULL,
id INTEGER NOT NULL,
PRIMARY KEY(instant),
FOREIGN KEY (name, address) REFERENCES analyst(name, address), 
FOREIGN KEY (instant, id) REFERENCES incident(instant, id)
);

CREATE TABLE line_incident (
instant DATE NOT NULL,
id INTEGER NOT NULL,
point VARCHAR(255) NOT NULL,
PRIMARY KEY (instant),
FOREIGN KEY (instant, id) REFERENCES incident(instant, id)
);


CREATE TABLE substation (
gps_coords VARCHAR(80) NOT NULL, -- TODO o prof disse na aula um data type que se adequava a coordenadas
                                 -- TODO com o data type 'point' nao da, nao o deixa ser primary key
locality_name VARCHAR(80) NOT NULL,
name VARCHAR(80) NOT NULL,
address VARCHAR(255) NOT NULL,
PRIMARY KEY (gps_coords),
FOREIGN KEY (name, address) REFERENCES supervisor(name, address)
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
gps_coords VARCHAR(80) NOT NULL,                              --Notar que lat é num(8,6), long num(9,6)
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id),
FOREIGN KEY (gps_coords) REFERENCES substation(gps_coords)
);



----------------------------------------
-- Populate Relations
----------------------------------------

-- Populate Person

--------- analyst-------
insert into person values ('Adams', 'Lisbon', '999999990', '000');
insert into person values ('Brown', 'Oporto', '999999991', '001');
insert into person values ('Cook', 'Lisbon', '999999992', '002');
insert into person values ('Davis', 'Oporto', '999999993', '003');
insert into person values ('Evans', 'Coimbra', '999999994', '004');
insert into person values ('Flores', 'Braga', '999999995', '005');
insert into person values ('Gonzalez', 'Faro', '999999996', '006');
insert into person values ('Iacocca', 'Coimbra', '999999997', '007');
--------- supervisor ----------
insert into person values ('Johnson', 'Cascais', '999999998', '008');
insert into person values ('King', 'Aveiro', '999999999', '009');
insert into person values ('Lopez', 'Vila Real', '999999900', '010');
insert into person values ('Martin', 'Braga', '999999901', '011');
insert into person values ('Nguyen', 'Castelo Branco', '9999999902', '012');
insert into person values ('Oliver', 'Oporto', '9999999903', '013');
insert into person values ('Parker', 'Lisbon', '9999999904', '014');

-- Populate Analyst
insert into person values ('Adams', 'Lisbon', '999999990', '000');
insert into person values ('Brown', 'Oporto', '999999991', '001');
insert into person values ('Cook', 'Lisbon', '999999992', '002');
insert into person values ('Davis', 'Oporto', '999999993', '003');
insert into person values ('Evans', 'Coimbra', '999999994', '004');
insert into person values ('Flores', 'Braga', '999999995', '005');
insert into person values ('Gonzalez', 'Faro', '999999996', '006');
insert into person values ('Iacocca', 'Coimbra', '999999997', '007');


-- Populate Supervisor
insert into person values ('Johnson', 'Cascais', '999999998', '008');
insert into person values ('King', 'Aveiro', '999999999', '009');
insert into person values ('Lopez', 'Vila Real', '999999900', '010');
insert into person values ('Martin', 'Braga', '999999901', '011');
insert into person values ('Nguyen', 'Castelo Branco', '9999999902', '012');
insert into person values ('Oliver', 'Oporto', '9999999903', '013');
insert into person values ('Parker', 'Lisbon', '9999999904', '014');


