----------------------------------------
-- QUERIES
----------------------------------------

-- A)
SELECT DISTINCT analyst.name
FROM analyst
JOIN analyses ON analyst.name = analyses.name
WHERE analyses.id = 'B-789';

-- B)
SELECT analyst.name
FROM analyst
JOIN analyses ON analyst.name = analyses.name
GROUP BY (analyst.name)
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM analyst
    JOIN analyses ON analyst.name = analyses.name
    GROUP BY (analyst.name)
);

-- C)
SELECT s.locality_name, s.lat, s.lng
FROM substation s
JOIN transformer t on s.lat = t.lat and s.lng = t.lng
GROUP BY (s.lat, s.lng)
HAVING COUNT(*) >= 2;

-- D)
SELECT s.locality_name
FROM substation s
GROUP BY s.locality_name
HAVING COUNT(*) >= ALL(
    SELECT COUNT(*)
    FROM substation s
    GROUP BY s.locality_name
);
