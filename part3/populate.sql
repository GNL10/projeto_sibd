-- Populating Person
insert into person values ('Adams', 'Lisbon', '965432123', '1234565542342');
insert into person values ('John', 'Lisbon', '931234567', '0897567891231521');

insert into person values ('Maria', 'Aveiro', '932135711', '182424712312356');
insert into person values ('Lewis', 'Amadora', '910984213', '129384512356573121');

-- Populating Supervisor
insert into supervisor values ('Maria', 'Aveiro');
insert into supervisor values ('Lewis', 'Amadora');

-- Populating Analyst
insert into analyst values ('Adams', 'Lisbon');
insert into analyst values ('John', 'Lisbon');

-- Populating substation
insert into substation values (40.640507, -8.653754, 'Aveiro', 'Maria', 'Aveiro');
insert into substation values (38.762329, -9.239910, 'Amadora', 'Lewis', 'Amadora');

-- Populating Element
insert into element values ('B-789');
insert into element values ('B-111');

insert into element values ('B-300');
insert into element values ('B-301');

insert into element values ('B-200');
insert into element values ('B-201');
insert into element values ('B-202');
insert into element values ('B-203');

-- Populating Busbar
insert into busbar values ('B-200', 230);
insert into busbar values ('B-201', 500);
insert into busbar values ('B-202', 200);
insert into busbar values ('B-203', 600);

-- Populating Transformer
insert into transformer values ('B-300', 230, 500, 40.640507, -8.653754, 'B-200', 'B-201');
insert into transformer values ('B-301', 200, 600, 38.762329, -9.239910, 'B-202', 'B-203');

-- Populating Incident
insert into incident values ('08-JAN-2019 10:35:02', 'B-789', 'Element stopped working after a spark', 'High');
insert into incident values ('21-JUL-2018 01:11:18', 'B-789', 'Element is making an unusual noise', 'Low');


-- Populating Analyses
insert into analyses values ('08-JAN-2019 10:35:02', 'B-789', 'Squirrel died on the element', 'Adams', 'Lisbon');
insert into analyses values ('21-JUL-2018 01:11:18', 'B-789', 'Broken support caused the problem', 'John', 'Lisbon');