-- TODO: ADD drop tables
-- TODO: -- IC4 em line, tem que ser comentario
-- TODO analyses
-- TODO line connection and transformer connection
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


-- ID B509 tentar fazer os ids desde estilo (will not be an int)

-- EXAMPLE
--create table account
--   (account_number  char(5) not null,
--    branch_name     varchar(80) not null,
--    balance         numeric(16,4) not null,
--   constraint pk_account primary key(account_number),
--    constraint fk_account_branch foreign key(branch_name) references branch(branch_name));

CREATE TABLE person(
name VARCHAR(80),
address VARCHAR(255),
phone VARCHAR(15) NOT NULL,
tax_id VARCHAR(20) NOT NULL,
PRIMARY KEY (name, address),
UNIQUE (phone),
UNIQUE (tax_id)
--	Every person must exist either in the table 'supervisor' or in the table 'analyst'
);

CREATE TABLE supervisor (
name VARCHAR(80),
address VARCHAR(255),
PRIMARY KEY(name, address),
FOREIGN KEY(name, address) REFERENCES person(name, address)
);

CREATE TABLE analyst (
name VARCHAR(80),
address VARCHAR(255),
PRIMARY KEY(name, address),
FOREIGN KEY(name, address) REFERENCES person(name, address)
);


CREATE TABLE element(
id VARCHAR(7),
PRIMARY KEY (id)
);


CREATE TABLE incident (
instant TIMESTAMP,
id VARCHAR(7),
description TEXT NOT NULL,
severity NUMERIC(1) NOT NULL, -- from 0 to 9 (0 being the lowest severity and 9 the highest)
PRIMARY KEY (instant, id),
FOREIGN KEY (id) REFERENCES element(id)
-- People cannot analyse incidents regarding Elements of a Substation
-- they supervise
);

CREATE TABLE analyses (
name VARCHAR(80),
address VARCHAR(255),
instant TIMESTAMP,
report TEXT NOT NULL,
id VARCHAR(7),
PRIMARY KEY(instant, id),
FOREIGN KEY (name, address) REFERENCES analyst(name, address),
FOREIGN KEY (instant, id) REFERENCES incident(instant, id)
);

CREATE TABLE line_incident (
instant TIMESTAMP,
id VARCHAR(7),
point INTEGER NOT NULL,
PRIMARY KEY (instant, id),
FOREIGN KEY (instant, id) REFERENCES incident(instant, id)
);

CREATE TABLE substation (
lat DECIMAL(8,6),
lng DECIMAL(9,6),
locality_name VARCHAR(80) NOT NULL,
name VARCHAR(80),
address VARCHAR(255) ,
PRIMARY KEY (lat, lng),
FOREIGN KEY (name, address) REFERENCES supervisor(name, address)
);

CREATE TABLE line (
id VARCHAR(7),
impedance INTEGER NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id)
-- every line must exist in the table "line_connection"
);

CREATE TABLE bus_bar (
id VARCHAR(7),
voltage INTEGER NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id)
);

CREATE TABLE transformer (
id VARCHAR(7),
primary_voltage INTEGER NOT NULL,
secondary_voltage INTEGER  NOT NULL,
lat DECIMAL(8,6),
lng DECIMAL(9,6),
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES element(id),
FOREIGN KEY (lat, lng) REFERENCES substation(lat, lng)
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
insert into analyst values ('Adams', 'Lisbon');
insert into analyst values ('Brown', 'Oporto');
insert into analyst values ('Cook', 'Lisbon');
insert into analyst values ('Davis', 'Oporto');
insert into analyst values ('Evans', 'Coimbra');
insert into analyst values ('Flores', 'Braga');
insert into analyst values ('Gonzalez', 'Faro');
insert into analyst values ('Iacocca', 'Coimbra');


-- Populate Supervisor
insert into supervisor values ('Johnson', 'Cascais');
insert into supervisor values ('King', 'Aveiro');
insert into supervisor values ('Lopez', 'Vila Real');
insert into supervisor values ('Martin', 'Braga');
insert into supervisor values ('Nguyen', 'Castelo Branco');
insert into supervisor values ('Oliver', 'Oporto');
insert into supervisor values ('Parker', 'Lisbon');

-- Populate substation
insert into substation values (38.7077507, -9.1365919, 'Lisbon', 'Johnson', 'Cascais');
insert into substation values (38.7678191,-9.099972, 'Lisbon', 'Parker', 'Lisbon');
insert into substation values (40.640496,-8.6537841, 'Aveiro', 'King', 'Aveiro');


-- Populate element
insert into element values ('B-789');
insert into element values ('B-111');
insert into element values ('B-200');
insert into element values ('B-201');


-- Populate line
insert into line values ('B-789', 1000);
insert into line values ('B-111', 4);

-- Populate transformer
insert into transformer values ('B-200', 230, 1000, 38.7077507, -9.1365919);
insert into transformer values ('B-201', 1000, 45000, 38.7077507, -9.1365919);

-- Populate incident
insert into incident values ('08-JAN-2019 10:35:02', 'B-789', 'Incendio na linha', 5);
insert into incident values ('23-JUN-2019 09:00:01', 'B-111', 'Ramo na linha', 2);

-- Populate analyses
insert into analyses values ('Adams', 'Lisbon', '08-JAN-2019 10:35:02', 'Fogo posto', 'B-789');
insert into analyses values ('Adams', 'Lisbon', '23-JUN-2019 09:00:01', 'Ramo na linha', 'B-111');


----------------------------------------
-- QUERIES
----------------------------------------

-- A)
SELECT analyst.name
FROM analyst
JOIN analyses ON analyst.name = analyses.name
WHERE analyses.id = 'B-789';

-- B)
SELECT analyst.name, COUNT(*)
FROM analyst
JOIN analyses ON analyst.name = analyses.name
GROUP BY (analyst.name);

-- C)
--TODO tirar count
SELECT s.locality_name, s.lat, s.lng, COUNT(*)
FROM substation s
JOIN transformer t on s.lat = t.lat and s.lng = t.lng
GROUP BY (s.lat, s.lng)
HAVING COUNT(*) >= 2;

-- D)
--TODO tirar count
SELECT s.locality_name, COUNT(*)
FROM substation s
GROUP BY s.locality_name
HAVING COUNT(*) >= ALL(
    SELECT COUNT(*)
    FROM substation s
    GROUP BY s.locality_name
    );
