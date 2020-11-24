-- TODO duvida - Na query 3 temos que incluir elementos que nao tem incidentes?

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
select id, count(*)
from incident
group by id
having count(*) <= ALL (
    select count(*)
    from incident
    group by id
    );

-- 4. How many substations does each supervisor supervise? (include supervisors that do not supervise any at the moment)
select sup.name, sup.address, count(sub.gpslat)
from supervisor sup
left outer join substation sub on sup.name = sub.sname and sup.address = sub.saddress
group by sup.name, sup.address;