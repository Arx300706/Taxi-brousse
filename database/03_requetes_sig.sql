-- Distance de chaque ligne en kilometres
SELECT
    numero,
    nom,
    ROUND((ST_Length(geom::geography) / 1000)::numeric, 2) AS distance_km
FROM ligne_bus
ORDER BY numero;

-- Export GeoJSON des lignes
SELECT numero, ST_AsGeoJSON(geom) AS geojson
FROM ligne_bus
ORDER BY numero;

-- Arrets a moins de 250 metres d'une ligne
SELECT
    l.numero,
    a.nom AS arret,
    ROUND(ST_Distance(a.geom::geography, l.geom::geography)::numeric, 1) AS distance_m
FROM arret_bus a
JOIN ligne_bus l ON ST_DWithin(a.geom::geography, l.geom::geography, 250)
ORDER BY l.numero, distance_m;

-- Ligne la plus proche d'une position utilisateur exemple
WITH utilisateur AS (
    SELECT ST_SetSRID(ST_MakePoint(47.5220, -18.9020), 4326)::geography AS geom
)
SELECT
    l.numero,
    l.nom,
    ROUND(ST_Distance(l.geom::geography, u.geom)::numeric, 0) AS distance_m
FROM ligne_bus l, utilisateur u
ORDER BY l.geom::geography <-> u.geom
LIMIT 3;
