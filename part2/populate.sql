----------------------------------------
-- Populate Relations
----------------------------------------

-- Populate Person

--------- analyst-------
insert into person values ('Adams', 'Lisbon', '999999990', '000');
insert into person values ('Brown', 'Oporto', '999999991', '001');
insert into person values ('Cook', 'Lisbon', '999999992', '002');
insert into person values ('Davis', 'Oporto', '999999993', '003');
insert into person values ('Evans', 'Coimbra', '999999994', '004');
insert into person values ('Flores', 'Braga', '999999995', '005');
insert into person values ('Gonzalez', 'Faro', '999999996', '006');
insert into person values ('Iacocca', 'Coimbra', '999999997', '007');
--------- supervisor ----------
insert into person values ('Johnson', 'Cascais', '999999998', '008');
insert into person values ('King', 'Aveiro', '999999999', '009');
insert into person values ('Lopez', 'Vila Real', '999999900', '010');
insert into person values ('Martin', 'Braga', '999999901', '011');
insert into person values ('Nguyen', 'Castelo Branco', '9999999902', '012');
insert into person values ('Oliver', 'Oporto', '9999999903', '013');
insert into person values ('Parker', 'Lisbon', '9999999904', '014');

-- Populate Analyst
insert into analyst values ('Adams', 'Lisbon');
insert into analyst values ('Brown', 'Oporto');
insert into analyst values ('Cook', 'Lisbon');
insert into analyst values ('Davis', 'Oporto');
insert into analyst values ('Evans', 'Coimbra');
insert into analyst values ('Flores', 'Braga');
insert into analyst values ('Gonzalez', 'Faro');
insert into analyst values ('Iacocca', 'Coimbra');


-- Populate Supervisor
insert into supervisor values ('Johnson', 'Cascais');
insert into supervisor values ('King', 'Aveiro');
insert into supervisor values ('Lopez', 'Vila Real');
insert into supervisor values ('Martin', 'Braga');
insert into supervisor values ('Nguyen', 'Castelo Branco');
insert into supervisor values ('Oliver', 'Oporto');
insert into supervisor values ('Parker', 'Lisbon');

-- Populate substation
insert into substation values (38.7077507, -9.1365919, 'Lisbon', 'Johnson', 'Cascais');
insert into substation values (38.7678191,-9.099972, 'Lisbon', 'Parker', 'Lisbon');
insert into substation values (40.640496,-18.6537841, 'Aveiro', 'King', 'Aveiro');


-- Populate element
insert into element values ('B-789');
insert into element values ('B-111');
insert into element values ('B-200');
insert into element values ('B-201');
insert into element values ('B-114');
insert into element values ('B-300');
insert into element values ('B-301');
insert into element values ('B-302');
insert into element values ('B-303');



-- Populate line
insert into line values ('B-789', 1000);
insert into line values ('B-111', 4);
insert into line values ('B-114', 500);

-- Populate bus_bar
insert into bus_bar values ('B-300', 230);
insert into bus_bar values ('B-301', 45000);
insert into bus_bar values ('B-302', 1000);
insert into bus_bar values ('B-303', 1000);

-- Populate transformer
insert into transformer values ('B-200', 230, 1000, 38.7077507, -9.1365919, 'B-300', 'B-302');
insert into transformer values ('B-201', 1000, 45000, 38.7077507, -9.1365919, 'B-303', 'B-301');

-- Populate incident
insert into incident values ('08-JAN-2019 10:35:02', 'B-789', 'Incendio na linha', 5);
insert into incident values ('23-JUN-2019 09:00:01', 'B-111', 'Ramo na linha', 2);
insert into incident values ('01-OCT-2015 23:55:16', 'B-114', 'Descarga atmosferica', 9);

-- Populate analyses
insert into analyses values ('Adams', 'Lisbon', '08-JAN-2019 10:35:02', 'Fogo posto', 'B-789');
insert into analyses values ('Adams', 'Lisbon', '23-JUN-2019 09:00:01', 'Ramo na linha', 'B-111');

-- Populate line_connection
insert into line_connection values ('B-111', 'B-300', 'B-301');
insert into line_connection values ('B-114', 'B-302', 'B-303');
