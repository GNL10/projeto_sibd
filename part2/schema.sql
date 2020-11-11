-- TODO IC1 e IC2 em bus_bar???
-- TODO constraint pk_account primary key(account_number) ???
-- TODO more populate
-- TODO delete counts queries
-- TODO voltage and impedance > 0

----------------------------------------
-- Drop Tables
----------------------------------------
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
drop table if exists line_connection cascade;


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
--    constraint pk_account primary key(account_number),
--    constraint fk_account_branch foreign key(branch_name) references branch(branch_name));

CREATE TABLE person(
    name VARCHAR(80),
    address VARCHAR(255),
    phone VARCHAR(15) NOT NULL,
    tax_id VARCHAR(15) NOT NULL,
    PRIMARY KEY (name, address),
    UNIQUE (phone), -- IC-6
    UNIQUE (tax_id) -- IC-7
    --	Every person must exist either in the table 'supervisor' or in the table 'analyst'
);

CREATE TABLE supervisor (
    name VARCHAR(80),
    address VARCHAR(255),
    PRIMARY KEY(name, address),
    FOREIGN KEY(name, address) REFERENCES person(name, address)
    -- IC-5 A Supervisor of a substation cannot analyse incidents regarding
    -- elements from that substation
);

CREATE TABLE analyst (
    name VARCHAR(80),
    address VARCHAR(255),
    PRIMARY KEY(name, address),
    FOREIGN KEY(name, address) REFERENCES person(name, address)
    -- IC-5 An Analyst of an Incident regarding an element of a substation,
    -- cannot supervise that substation
);


CREATE TABLE element(
    id VARCHAR(7),
    PRIMARY KEY (id)
    -- IC-5 Elements of a substation where an incident occurs cannot
    -- be analysed by a person that supervises that substation

    -- No element can exist at the same time in the tables
    -- 'line', 'bus_bar' or 'transformer'

    -- Every element must exist either in the table 'line',
    -- 'bus_bar' or 'transformer'
);


CREATE TABLE incident (
    instant TIMESTAMP,
    id VARCHAR(7),
    description TEXT NOT NULL,
    severity NUMERIC(1) NOT NULL, -- from 0 to 9 (0 being the lowest severity and 9 the highest)
    PRIMARY KEY (instant, id),
    FOREIGN KEY (id) REFERENCES element(id),
    CHECK (instant <= now()) -- Check-Extra-1 instant of incident cannot be from the future
    -- IC-5 Incidents regarding an element of a substation cannot
    -- be analysed by a person that supervises that substation
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
    -- IC-5 The analysis of an Incident regarding an element of a substation cannot
    -- be done by a person that supervises that substation
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
    locality_name VARCHAR(30) NOT NULL,
    name VARCHAR(80),
    address VARCHAR(255) ,
    PRIMARY KEY (lat, lng),
    FOREIGN KEY (name, address) REFERENCES supervisor(name, address),
    CHECK ( lat <= 90 AND lat >= -90 ), -- Check-Extra-2 Check if values of latitude are acceptable
    CHECK ( lng <= 180 AND lng >= -180 ) -- Check-Extra-3 Check if values of longitude are acceptable
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
    -- IC-1 The voltage of the primary bus_bar must match the primary_voltage of the
    -- Transformer to which the bus_bar is connected
    -- IC-2 The voltage of the secondary bus_bar must match the secondary_voltage of the
    -- Transformer to which the bus_bar is connected
);

CREATE TABLE transformer (
    id VARCHAR(7),
    primary_voltage INTEGER NOT NULL,
    secondary_voltage INTEGER  NOT NULL,
    lat DECIMAL(8,6),
    lng DECIMAL(9,6),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES element(id),
    FOREIGN KEY (lat, lng) REFERENCES substation(lat, lng),

    primary_bb_id VARCHAR(7),
    secondary_bb_id VARCHAR(7),
    FOREIGN KEY (primary_bb_id) REFERENCES bus_bar(id),
    FOREIGN KEY (secondary_bb_id) REFERENCES bus_bar(id),
    CHECK ( primary_bb_id !=  secondary_bb_id) -- IC-3
    -- IC-1 The voltage of the primary Bus Bar must match the primary voltage of the
    -- Transformer to which the Bus Bar is connected
    -- IC-2 The voltage of the secondary Bus Bar must match the secondary voltage of the
    -- Transformer to which the Bus Bar is connected
);

CREATE TABLE line_connection (
    line_id VARCHAR(7),
    bus_bar1_id VARCHAR(7),
    bus_bar2_id VARCHAR(7),
    PRIMARY KEY (line_id, bus_bar1_id, bus_bar2_id),
    FOREIGN KEY(line_id) REFERENCES line(id),
    FOREIGN KEY(bus_bar1_id) REFERENCES bus_bar(id),
    FOREIGN KEY(bus_bar2_id) REFERENCES bus_bar(id),
    CHECK(bus_bar1_id != bus_bar2_id) -- IC-4
 );

