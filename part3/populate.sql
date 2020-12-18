-- Populating Person
insert into person values ('Adams', 'Lisbon', '965432123', '1234565542342');
insert into person values ('John', 'Lisbon', '931234567', '0897567891231521');

insert into person values ('Maria', 'Aveiro', '932135711', '182424712312356');
insert into person values ('Lewis', 'Amadora', '910984213', '129384512356573121');
insert into person values ('Ricardo', 'Sintra', '913859231', '0012395123904657');
insert into person values ('Adams', 'Sintra', '921874729', '4673925874612');


-- Populating Supervisor
insert into supervisor values ('Maria', 'Aveiro');
insert into supervisor values ('Lewis', 'Amadora');
insert into supervisor values ('Ricardo', 'Sintra');
insert into supervisor values ('Adams', 'Sintra');

-- Populating Analyst
insert into analyst values ('Adams', 'Lisbon');
insert into analyst values ('John', 'Lisbon');
insert into analyst values ('Adams', 'Sintra');
insert into analyst values ('Lewis', 'Amadora');

-- Populating substation
insert into substation values (40.640507, -8.653754, 'Aveiro', 'Maria', 'Aveiro');
insert into substation values (38.762329, -9.239910, 'Amadora', 'Lewis', 'Amadora');

insert into substation values (39.236179, -8.687080, 'Santarem', 'Lewis', 'Amadora');

-- Populating Element
insert into element values ('B-789');
insert into element values ('B-111');

insert into element values ('B-200');
insert into element values ('B-201');
insert into element values ('B-202');
insert into element values ('B-203');

insert into element values ('B-300');
insert into element values ('B-301');

insert into line values ('B-111');

-- Populating Busbar
insert into busbar values ('B-200', 230);
insert into busbar values ('B-201', 500);
insert into busbar values ('B-202', 200);
insert into busbar values ('B-203', 600);
insert into busbar values ('B-789', 600);

-- Populating Transformer
insert into transformer values ('B-300', 230, 500, 40.640507, -8.653754, 'B-200', 'B-201');
insert into transformer values ('B-301', 200, 600, 38.762329, -9.239910, 'B-202', 'B-203');

-- Populating Incident
insert into incident values ('08-JAN-2019 10:35:02', 'B-789', 'Element stopped working after a spark', 'High');
insert into incident values ('22-FEB-2019 15:22:05', 'B-789', 'Element malfunction', 'High');
insert into incident values ('15-APR-2019 12:01:55', 'B-789', 'Element caught fire', 'Medium');

insert into incident values ('21-JUL-2018 01:11:18', 'B-789', 'Element is making an unusual noise', 'Low');
insert into incident values ('24-SEP-2019 12:14:12', 'B-200', 'Complete element failure', 'High');
insert into incident values ('01-OCT-2019 20:33:51', 'B-201', 'Mechanical damage', 'Medium');

insert into incident values ('12-JAN-2019 11:23:31', 'B-301', 'Fire on the transformer', 'High');
insert into incident values ('07-07-2019 12:45:07', 'B-300', 'Bird on the transformer', 'High');


-- Populating Analyses
insert into analyses values ('08-JAN-2019 10:35:02', 'B-789', 'Squirrel died on the element', 'Adams', 'Lisbon');
insert into analyses values ('22-FEB-2019 15:22:05', 'B-789', 'Insulation was old', 'Adams', 'Lisbon');
insert into analyses values ('15-APR-2019 12:01:55', 'B-789', 'Unexpected ground connection', 'Adams', 'Sintra');
insert into analyses values ('21-JUL-2018 01:11:18', 'B-789', 'Broken support caused the problem', 'John', 'Lisbon');
insert into analyses values ('12-JAN-2019 11:23:31', 'B-301', 'Fire on the transformer', 'John', 'Lisbon');
insert into analyses values ('07-07-2019 12:45:07', 'B-300', 'Bird on the transformer', 'Adams', 'Sintra');
-- insert into analyses values ('12-JAN-2019 11:23:31', 'B-301', 'Bird on the transformer', 'Lewis', 'Amadora'); TO TEST IC5

--update substation set sname = 'Lewis', saddress = 'Amadora' where gpslat = 38.762329 and gpslong = -9.239910; --test IC-5