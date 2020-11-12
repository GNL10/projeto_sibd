----------------------------------------
-- Populate Relations
----------------------------------------

-- Populate Person
insert into person values ('Adams', 'Lisbon', '999999990', '000');
insert into person values ('Brown', 'Oporto', '999999991', '001');
insert into person values ('Cook', 'Lisbon', '999999992', '002');
insert into person values ('Davis', 'Oporto', '999999993', '003');
insert into person values ('Evans', 'Coimbra', '999999994', '004');
insert into person values ('Flores', 'Braga', '999999995', '005');
insert into person values ('Gonzalez', 'Faro', '999999996', '006');
insert into person values ('Iacocca', 'Coimbra', '999999997', '007');
insert into person values ('Johnson', 'Lisbon', '999999998', '008');
insert into person values ('King', 'Aveiro', '999999999', '009');
insert into person values ('Lopez', 'Vila Real', '999999900', '010');
insert into person values ('Martin', 'Braga', '999999901', '011');
insert into person values ('Nguyen', 'Castelo Branco', '9999999902', '012');
insert into person values ('Oliver', 'Oporto', '9999999903', '013');
insert into person values ('Parker', 'Lisbon', '9999999904', '014');
insert into person values ('Antoin', 'Patagonia', '9995999904', '018');

-- Populate Analyst
insert into analyst values ('Adams', 'Lisbon');
insert into analyst values ('Brown', 'Oporto');
insert into analyst values ('Cook', 'Lisbon');
insert into analyst values ('Davis', 'Oporto');
insert into analyst values ('Evans', 'Coimbra');
insert into analyst values ('Flores', 'Braga');
insert into analyst values ('Gonzalez', 'Faro');
insert into analyst values ('Iacocca', 'Coimbra');
insert into analyst values ('Antoin', 'Patagonia');

-- Populate Supervisor
insert into supervisor values ('Johnson', 'Lisbon');
insert into supervisor values ('King', 'Aveiro');
insert into supervisor values ('Lopez', 'Vila Real');
insert into supervisor values ('Martin', 'Braga');
insert into supervisor values ('Nguyen', 'Castelo Branco');
insert into supervisor values ('Oliver', 'Oporto');
insert into supervisor values ('Parker', 'Lisbon');

-- Populate substation
insert into substation values (38.7077507, -9.1365919, 'Lisbon', 'Johnson', 'Lisbon');
insert into substation values (38.7678191,-9.099972, 'Lisbon', 'Parker', 'Lisbon');
insert into substation values (38.7373708,-9.1332543, 'Lisbon', 'Parker', 'Lisbon');
insert into substation values (38.6977695,-9.2094318, 'Lisbon', 'Parker', 'Lisbon');
insert into substation values (40.640496,-18.6537841, 'Aveiro', 'King', 'Aveiro');
insert into substation values (41.5228712,-7.5465333, 'Vila Real', 'Lopez', 'Vila Real');
insert into substation values (41.1494512,-8.6107884, 'Oporto', 'Oliver', 'Oporto');
insert into substation values (41.1543991,-8.5750341, 'Oporto', 'Oliver', 'Oporto');
insert into substation values (41.1523592,-8.5150342, 'Oporto', 'Martin', 'Braga');
insert into substation values (41.1513993,-8.5752343, 'Oporto', 'Lopez', 'Vila Real');

-- Populate element
insert into element values ('B-111');
insert into element values ('B-114');
insert into element values ('B-200');
insert into element values ('B-201');
insert into element values ('B-202');
insert into element values ('B-203');
insert into element values ('B-204');
insert into element values ('B-205');
insert into element values ('B-300');
insert into element values ('B-301');
insert into element values ('B-302');
insert into element values ('B-303');
insert into element values ('B-304');
insert into element values ('B-305');
insert into element values ('B-306');
insert into element values ('B-307');
insert into element values ('B-308');
insert into element values ('B-309');
insert into element values ('B-310');
insert into element values ('B-311');
insert into element values ('B-789');
insert into element values ('B-457');
insert into element values ('B-371');
insert into element values ('B-159');



-- Populate line
insert into line values ('B-789', 1000);
insert into line values ('B-111', 4);
insert into line values ('B-114', 500);
insert into line values ('B-457', 180);
insert into line values ('B-371', 47);
insert into line values ('B-159', 510);

-- Populate bus_bar
insert into bus_bar values ('B-300', 230);
insert into bus_bar values ('B-301', 45000);
insert into bus_bar values ('B-302', 1000);
insert into bus_bar values ('B-303', 1000);
insert into bus_bar values ('B-304', 400000);
insert into bus_bar values ('B-305', 230);
insert into bus_bar values ('B-306', 5000);
insert into bus_bar values ('B-307', 30000);
insert into bus_bar values ('B-308', 7000);
insert into bus_bar values ('B-309', 20000);
insert into bus_bar values ('B-310', 230);
insert into bus_bar values ('B-311', 1000);

-- Populate transformer
insert into transformer values ('B-200', 230, 1000, 38.7077507, -9.1365919, 'B-300', 'B-302');
insert into transformer values ('B-201', 1000, 45000, 38.7077507, -9.1365919, 'B-303', 'B-301');
insert into transformer values ('B-202', 400000, 230, 38.7077507, -9.1365919, 'B-304', 'B-305');
insert into transformer values ('B-203', 5000, 30000, 41.1494512,-8.6107884, 'B-306', 'B-307');
insert into transformer values ('B-204', 7000, 20000, 41.1494512,-8.6107884, 'B-308', 'B-309');
insert into transformer values ('B-205', 230, 1000, 40.640496,-18.6537841, 'B-310', 'B-311');

-- Populate incident
insert into incident values ('08-JAN-2019 10:35:02', 'B-789', 'Incendio na linha', 5);
insert into incident values ('02-JUL-2019 22:23:11', 'B-789', 'Curto circuito', 7);
insert into incident values ('23-AUG-2018 13:20:16', 'B-789', 'Arvore na linha', 4);
insert into incident values ('23-JUN-2019 09:00:01', 'B-111', 'Ramo na linha', 2);
insert into incident values ('01-OCT-2015 23:55:16', 'B-114', 'Descarga atmosferica', 9);
insert into incident values ('29-JAN-2017 10:32:12', 'B-303', 'Fumo a sair da bus_bar', 7);
insert into incident values ('25-MAR-2017 06:29:41', 'B-309', 'Interrupcao da rede eletrica', 8);


-- Populate line_incident
insert into line_incident values ('08-JAN-2019 10:35:02', 'B-789', 10);
insert into line_incident values ('02-JUL-2019 22:23:11', 'B-789', 100);
insert into line_incident values ('23-AUG-2018 13:20:16', 'B-789', 13);
insert into line_incident values ('23-JUN-2019 09:00:01', 'B-111', 5);
insert into line_incident values ('01-OCT-2015 23:55:16', 'B-114', 24);

-- Populate analyses
insert into analyses values ('Adams', 'Lisbon', '08-JAN-2019 10:35:02', 'Fogo posto', 'B-789');
insert into analyses values ('Cook', 'Lisbon', '02-JUL-2019 22:23:11', 'Tempestade causou o incidente', 'B-789');
insert into analyses values ('Cook', 'Lisbon', '23-AUG-2018 13:20:16', 'Vento forte derrubou arvore', 'B-789');
insert into analyses values ('Adams', 'Lisbon', '23-JUN-2019 09:00:01', 'Ramo na linha', 'B-111');
insert into analyses values ('Cook', 'Lisbon', '29-JAN-2017 10:32:12', 'Inseto no elemento', 'B-303');
insert into analyses values ('Antoin', 'Patagonia', '25-MAR-2017 06:29:41', 'Descarga Atmosferica', 'B-309');

-- Populate line_connection
insert into line_connection values ('B-111', 'B-300', 'B-301');
insert into line_connection values ('B-114', 'B-302', 'B-303');
insert into line_connection values ('B-457', 'B-303', 'B-302');
insert into line_connection values ('B-371', 'B-303', 'B-311');
insert into line_connection values ('B-371', 'B-305', 'B-310');

