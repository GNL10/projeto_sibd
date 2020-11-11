----------------------------------------
-- QUERIES
----------------------------------------

-- A)
SELECT analyst.name
FROM analyst
JOIN analyses ON analyst.name = analyses.name
WHERE analyses.id = 'B-789';

-- B)
SELECT analyst.name, COUNT(*)
FROM analyst
JOIN analyses ON analyst.name = analyses.name
GROUP BY (analyst.name);

-- C)
--TODO tirar count
SELECT s.locality_name, s.lat, s.lng, COUNT(*)
FROM substation s
JOIN transformer t on s.lat = t.lat and s.lng = t.lng
GROUP BY (s.lat, s.lng)
HAVING COUNT(*) >= 2;

-- D)
--TODO tirar count
SELECT s.locality_name, COUNT(*)
FROM substation s
GROUP BY s.locality_name
HAVING COUNT(*) >= ALL(
    SELECT COUNT(*)
    FROM substation s
    GROUP BY s.locality_name
);