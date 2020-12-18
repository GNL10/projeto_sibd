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
select name, address
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
select sup.name, sup.address, count(sub.gpslat) -- no distinct so it counts substations with equal lat but different long
from supervisor sup
left outer join substation sub on sup.name = sub.sname and sup.address = sub.saddress
group by sup.name, sup.address;