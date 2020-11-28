-- TODO duvida 5.a - 1 so tabela ou 3 tabelas?
-- TODO duvida 5 como fazer delete de bus bar sem dar delete

-- View
-- Create a view to get the supervisors and the number of substations that each one of them supervises,
-- without including supervisors that do not supervise any substation.
create view supervisor_subs_number(name, sub_number)
AS
    select sup.name, count(*) as sub_number
    from substation sub
    join supervisor sup on sub.sname = sup.name and sub.saddress = sup.address
    group by sup.address, sup.name;

select *
from supervisor_subs_number;

-- 1. Who are the analysts that have analyzed every incident of element ‘B-789’?
select distinct a.name, a.address
from analyses a
where id = 'B-789';

-- 2. Who are the supervisors that do not supervise substations south of Rio Maior (Portugal) (Rio Maior coordinates: 39.336775, -8.936379 (cf. Google Maps)?
select name, address -- TODO tem que ter address, porque podem existir names iguais com addresses diferentes!
from supervisor
except
select sup.name, sup.address
from substation s
join supervisor sup on sup.name = s.sname and sup.address = s.saddress
where s.gpslat <= 39.336775;

-- 3. What are the elements with the smallest amount of incidents?
select  e.id, count(i.id) as incidents_number   -- for each i.id in the outer join, there is an incident, null values are not counted
from element e
left outer join incident i on i.id = e.id
group by e.id
having count(i.id) <= ALL (
    select  count(i.id)
    from element e
    left outer join incident i on i.id = e.id
    group by e.id
    );

-- 4. How many substations does each supervisor supervise? (include supervisors that do not supervise any at the moment)
select sup.name, sup.address, count(sub.gpslat)
from supervisor sup
left outer join substation sub on sup.name = sub.sname and sup.address = sub.saddress
group by sup.name, sup.address;



-- default index struct is btree
drop index loc_ind;
drop index pv_ind;

-- different tables cannot use composite index
create index loc_ind on substation using HASH (locality);
create index pv_ind on transformer using HASH (pv);
EXPLAIN ANALYSE SELECT locality, COUNT(*)
FROM transformer
NATURAL JOIN substation
WHERE pv = 200
GROUP BY locality;

drop index desc_ind;
create index desc_ind on incident using btree (instant, description);
explain analyse SELECT id, description
FROM incident
WHERE instant BETWEEN '08-JAN-2013 10:35:02' AND '09-JAN-2020 10:35:02'
AND description LIKE 'E%';