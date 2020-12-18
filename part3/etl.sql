drop table if exists d_reporter;
drop table if exists d_time;
drop table if exists d_location;
drop table if exists d_element;
drop table if exists f_incident;

create table d_reporter (
    id_reporter serial,
    name VARCHAR(80) not null,
    address VARCHAR(80) not null,
    primary key (id_reporter)
);

create table d_time (
    id_time serial,
    day integer not null,
    week_day varchar(9) not null,
    week integer not null,
    month integer not null,
    trimester integer not null,
    year integer not null,
    primary key (id_time)
);

create table d_location (
    id_location serial,
    latitude NUMERIC(8,6) not null,
    longitude NUMERIC(9,6) not null,
    locality VARCHAR(80) not null,
    primary key (id_location)
);

create table d_element (
    id_element serial,
    element_id VARCHAR(10) not null,
    element_type VARCHAR(10) not null,
    primary key (id_element)
);

create table f_incident (
    id_reporter serial,
    id_time serial,
    id_location serial,
    id_element serial,
    severity VARCHAR(30) not null,
    primary key (id_reporter, id_time, id_location, id_element)
);

-- Inserting into d_time
CREATE OR REPLACE FUNCTION load_date_dim()
    RETURNS	VOID AS
$$
DECLARE	date_value	TIMESTAMP;
BEGIN
    date_value := '2015-01-01 00:00:00';
    WHILE date_value < '2030-01-01 00:00:00' LOOP
        INSERT INTO d_time(
        day,
        week_day,
        week,
        month,
        trimester,
        year
        ) VALUES (
            CAST(EXTRACT(DAY FROM date_value) AS INTEGER),
            to_char(date_value, 'Day') ,
            CAST(EXTRACT(WEEK FROM date_value) AS INTEGER),
            CAST(EXTRACT(MONTH FROM date_value)	AS INTEGER),
            CAST(((EXTRACT(MONTH FROM date_value)-1)/4+1) AS INTEGER),
            CAST(EXTRACT(YEAR FROM date_value) AS INTEGER)

        );
        date_value := date_value + INTERVAL '1 DAY';
    END	LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$ BEGIN
    PERFORM load_date_dim();
END $$;

-- Inserting into d_element
insert into d_element (element_id, element_type)
select e.id, CASE WHEN l.id IS NOT NULL THEN 'Line'
                            WHEN t.id IS NOT NULL THEN 'Transf'
                            WHEN b.id IS NOT NULL THEN 'Bus Bar'
                            ELSE 'Unknown' END
from element e
left outer join busbar b on e.id = b.id
left outer join transformer t on e.id = t.id
left outer join line l on e.id = l.id;

-- Inserting into d_location
insert into d_location values (0, 99, 199, 'Unknown');
insert into d_location (latitude, longitude, locality)
select s.gpslat, s.gpslong, s.locality
from transformer t
    join substation s on t.gpslat = s.gpslat and t.gpslong = s.gpslong;

-- Inserting into d_reporter
insert into d_reporter values (0, 'Unknown', 'Unknown');
insert into d_reporter (name, address)
select distinct name,  address
from analyses;

-- Inserting into f_incident
insert into f_incident (id_reporter, id_time, id_location, id_element, severity)
select coalesce(id_reporter, 0) as id_reporter, --The unknown reporter is in the id 0
       t.id_time,
       coalesce(id_location, 0) as id_location, --The unknown location is in the id 0
       id_element,
       severity
from incident i
    left outer join analyses a on a.instant = i.instant and a.id = i.id
    left outer join transformer tr on tr.id = i.id
    left outer join d_time t on extract(year from i.instant) = t.year and extract(month from i.instant) = t.month and extract(day from i.instant) = t.day
    left outer join d_element e on i.id = e.element_id
    left outer join d_reporter r on (r.name, r.address) = (a.name, a.address)
    left outer join d_location l on (l.latitude, l.longitude) = (tr.gpslat, tr.gpslong)
;


-- to view the tables
select * from d_time order by id_time desc;
select * from d_reporter;
select * from d_time;
select * from d_location;
select * from d_element;
select * from f_incident;
select * from f_incident
    natural join d_element
    natural join d_location
    natural join d_reporter
    natural join d_time;