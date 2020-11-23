-- 1. Who are the analysts that have analyzed every incident of element ‘B-789’?
select a.name
from analyses a
where id = 'B-789';

-- 2. Who are the supervisors that do not supervise substations south of Rio Maior (Portugal) (Rio Maior coordinates: 39.336775, -8.936379 (cf. Google Maps)?
select name
from supervisor
except
select sup.name
from substation s
join supervisor sup on sup.name = s.sname and sup.address = s.saddress
where s.gpslat <= 39.336775;

-- 3. What are the elements with the smallest amount of incidents?

-- 4. How many substations does each supervisor supervise? (include supervisors that do not supervise any at the moment)