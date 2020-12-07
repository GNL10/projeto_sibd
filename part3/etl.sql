--TODO perguntar ao prof o tamanho e tipo de var de id_reporter
create table d_reporter (
    id_reporter varchar(30) not null,
	name VARCHAR(80) not null,
    address VARCHAR(80) not null
);

create table d_time (
    id_time varchar(30) not null,
    day integer not null,
    week_day varchar(9) not null,
    week integer not null,
    month integer not null,
    trimester integer not null,
    year integer not null
);

create table d_location (
    id_location varchar(30) not null,
    latitude NUMERIC(9,6) not null,
    longitude NUMERIC(8,6) not null,
    locality VARCHAR(80) not null
);

create table d_element (
    id_element varchar(30) not null,
    element_id varchar(30) not null,
    element_type varchar(30) not null
);

create table f_incident (
    id_reporter varchar(30) not null,
    id_time varchar(30) not null,
    id_location varchar(30) not null,
    id_element varchar(30) not null,
    severity VARCHAR(30) not null
);