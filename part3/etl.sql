drop table if exists d_reporter;
drop table if exists d_time;
drop table if exists d_location;
drop table if exists d_element;
drop table if exists f_incident;

create table d_reporter (
    id_reporter varchar(10) not null,
	name VARCHAR(80) not null,
    address VARCHAR(80) not null
);

create table d_time (
    id_time integer not null,
    day integer not null,
    week_day varchar(9) not null,
    week integer not null,
    month integer not null,
    trimester integer not null,
    year integer not null
);

create table d_location (
    id_location varchar(10) not null,
    latitude NUMERIC(9,6) not null,
    longitude NUMERIC(8,6) not null,
    locality VARCHAR(80) not null
);

create table d_element (
    id_element integer not null,
    element_id VARCHAR(10) not null,
    element_type VARCHAR(10) not null
);

create table f_incident (
    id_reporter varchar(10) not null,
    id_time integer not null,
    id_location varchar(10) not null,
    id_element integer not null,
    severity VARCHAR(30) not null
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
        id_time,
        day,
        week_day,
        week,
        month,
        trimester,
        year
        ) VALUES (
            EXTRACT(YEAR FROM date_value) * 10000 + EXTRACT(MONTH FROM date_value)*100 + EXTRACT(DAY FROM date_value),
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

select * from d_time order by id_time desc;

-- Inserting into d_element
insert into d_element
select row_number() over(), e.id, CASE WHEN l.id IS NOT NULL THEN 'Line'
                                  WHEN t.id IS NOT NULL THEN 'Transf'
                                  WHEN b.id IS NOT NULL THEN 'Bus Bar'
                                  ELSE 'Unknown' END
from element e
left outer join busbar b on e.id = b.id
left outer join transformer t on e.id = t.id
left outer join line l on e.id = l.id;


-- Inserting into d_location
insert into d_location
select row_number() over(), s.gpslat, s.gpslong,
       CASE WHEN s.locality IS NOT NULL THEN s.locality ELSE 'Unknown' END
from transformer t
right outer join substation s on t.gpslat = s.gpslat and t.gpslong = s.gpslong;

-- Inserting into d_reporter
insert into d_reporter
select row_number() over(), name, address
from analyst;

select * from d_reporter;
select * from d_time;
select * from d_location;
select * from d_element;
select * from f_incident;

insert into f_incident
select  CASE WHEN id_reporter IS NOT NULL THEN id_reporter ELSE 'Unknown' END as id_reporter, t.id_time, CASE WHEN id_location IS NOT NULL THEN id_location ELSE 'Unknown' END as id_location, id_element, severity
from incident i
    left outer join analyses a on a.instant = i.instant and a.id = i.id
    left outer join transformer tr on tr.id = i.id
    left outer join d_time t on extract(year from i.instant) = t.year and extract(month from i.instant) = t.month and extract(day from i.instant) = t.day
    left outer join d_element e on i.id = e.element_id
    left outer join d_reporter r on (r.name, r.address) = (a.name, a.address)
    left outer join d_location l on (l.latitude, l.longitude) = (tr.gpslat, tr.gpslong)
;

select * from f_incident;