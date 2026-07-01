INSERT INTO terminus_bus (nom, quartier, geom) VALUES
('67Ha', '67Ha', ST_SetSRID(ST_MakePoint(47.50380, -18.89890), 4326)),
('Mausolee', 'Anosy', ST_SetSRID(ST_MakePoint(47.52720, -18.92520), 4326)),
('Ambatomaro', 'Ambatomaro', ST_SetSRID(ST_MakePoint(47.56920, -18.87920), 4326)),
('Andraisoro', 'Andraisoro', ST_SetSRID(ST_MakePoint(47.54520, -18.89920), 4326));

INSERT INTO arret_bus (nom, quartier, geom) VALUES
('67Ha Est Parking', '67Ha', ST_SetSRID(ST_MakePoint(47.50380, -18.89890), 4326)),
('Antohomadinika', 'Antohomadinika', ST_SetSRID(ST_MakePoint(47.50860, -18.90180), 4326)),
('Ankazomanga', 'Ankazomanga', ST_SetSRID(ST_MakePoint(47.51270, -18.88760), 4326)),
('Antanimena Poste', 'Antanimena', ST_SetSRID(ST_MakePoint(47.52120, -18.89540), 4326)),
('Ankadifotsy', 'Ankadifotsy', ST_SetSRID(ST_MakePoint(47.52470, -18.88970), 4326)),
('Andravoahangy', 'Andravoahangy', ST_SetSRID(ST_MakePoint(47.53190, -18.88600), 4326)),
('Ampasampito', 'Ampasampito', ST_SetSRID(ST_MakePoint(47.54420, -18.88490), 4326)),
('Mausolee', 'Anosy', ST_SetSRID(ST_MakePoint(47.52720, -18.92520), 4326)),
('Antsobolo', 'Antsobolo', ST_SetSRID(ST_MakePoint(47.55160, -18.87870), 4326)),
('Ambatomaro', 'Ambatomaro', ST_SetSRID(ST_MakePoint(47.56920, -18.87920), 4326)),
('Mahamasina', 'Mahamasina', ST_SetSRID(ST_MakePoint(47.52330, -18.91750), 4326)),
('Anosy', 'Anosy', ST_SetSRID(ST_MakePoint(47.52170, -18.91330), 4326)),
('Behoririka', 'Behoririka', ST_SetSRID(ST_MakePoint(47.52490, -18.90400), 4326)),
('Andraisoro', 'Andraisoro', ST_SetSRID(ST_MakePoint(47.54520, -18.89920), 4326));

INSERT INTO ligne_bus (numero, nom, depart, arrivee, couleur, duree_estimee, frequence_estimee, prix_estime, geom) VALUES
('146', 'Ligne 146 - 67Ha vers Mausolee', '67Ha', 'Mausolee', '#f97316', '35 a 50 min', '8 a 12 min', 700,
 ST_SetSRID(ST_MakeLine(ARRAY[
    ST_MakePoint(47.50380, -18.89890),
    ST_MakePoint(47.50860, -18.90180),
    ST_MakePoint(47.51270, -18.88760),
    ST_MakePoint(47.52120, -18.89540),
    ST_MakePoint(47.52470, -18.88970),
    ST_MakePoint(47.53190, -18.88600),
    ST_MakePoint(47.53780, -18.89930),
    ST_MakePoint(47.52330, -18.91750),
    ST_MakePoint(47.52720, -18.92520)
 ]), 4326)),
('147', 'Ligne 147 - 67Ha vers Ambatomaro', '67Ha', 'Ambatomaro', '#2563eb', '40 a 60 min', '8 a 15 min', 700,
 ST_SetSRID(ST_MakeLine(ARRAY[
    ST_MakePoint(47.50380, -18.89890),
    ST_MakePoint(47.50860, -18.90180),
    ST_MakePoint(47.52120, -18.89540),
    ST_MakePoint(47.52470, -18.88970),
    ST_MakePoint(47.53190, -18.88600),
    ST_MakePoint(47.54420, -18.88490),
    ST_MakePoint(47.55160, -18.87870),
    ST_MakePoint(47.56920, -18.87920)
 ]), 4326)),
('178', 'Ligne 178 - 67Ha vers Andraisoro', '67Ha', 'Andraisoro', '#16a34a', '30 a 45 min', '7 a 12 min', 700,
 ST_SetSRID(ST_MakeLine(ARRAY[
    ST_MakePoint(47.50380, -18.89890),
    ST_MakePoint(47.50860, -18.90180),
    ST_MakePoint(47.52170, -18.91330),
    ST_MakePoint(47.52330, -18.91750),
    ST_MakePoint(47.52720, -18.90920),
    ST_MakePoint(47.52490, -18.90400),
    ST_MakePoint(47.53190, -18.88600),
    ST_MakePoint(47.54520, -18.89920)
 ]), 4326));

INSERT INTO ligne_arret (ligne_id, arret_id, ordre)
SELECT l.id, a.id, x.ordre
FROM (VALUES
    ('146', '67Ha Est Parking', 1), ('146', 'Antohomadinika', 2), ('146', 'Ankazomanga', 3),
    ('146', 'Antanimena Poste', 4), ('146', 'Ankadifotsy', 5), ('146', 'Andravoahangy', 6),
    ('146', 'Mahamasina', 7), ('146', 'Mausolee', 8),
    ('147', '67Ha Est Parking', 1), ('147', 'Antohomadinika', 2), ('147', 'Antanimena Poste', 3),
    ('147', 'Ankadifotsy', 4), ('147', 'Andravoahangy', 5), ('147', 'Ampasampito', 6),
    ('147', 'Antsobolo', 7), ('147', 'Ambatomaro', 8),
    ('178', '67Ha Est Parking', 1), ('178', 'Antohomadinika', 2), ('178', 'Anosy', 3),
    ('178', 'Mahamasina', 4), ('178', 'Behoririka', 5), ('178', 'Andravoahangy', 6),
    ('178', 'Andraisoro', 7)
) AS x(numero, arret, ordre)
JOIN ligne_bus l ON l.numero = x.numero
JOIN arret_bus a ON a.nom = x.arret;

INSERT INTO bus_position (ligne_id, code_bus, statut, geom)
SELECT id, 'BUS-146-01', 'en_service', ST_SetSRID(ST_MakePoint(47.52120, -18.89540), 4326) FROM ligne_bus WHERE numero = '146'
UNION ALL
SELECT id, 'BUS-146-02', 'en_service', ST_SetSRID(ST_MakePoint(47.52720, -18.91750), 4326) FROM ligne_bus WHERE numero = '146'
UNION ALL
SELECT id, 'BUS-147-01', 'en_service', ST_SetSRID(ST_MakePoint(47.54420, -18.88490), 4326) FROM ligne_bus WHERE numero = '147'
UNION ALL
SELECT id, 'BUS-147-02', 'pause', ST_SetSRID(ST_MakePoint(47.56920, -18.87920), 4326) FROM ligne_bus WHERE numero = '147'
UNION ALL
SELECT id, 'BUS-178-01', 'en_service', ST_SetSRID(ST_MakePoint(47.52330, -18.91750), 4326) FROM ligne_bus WHERE numero = '178'
UNION ALL
SELECT id, 'BUS-178-02', 'en_service', ST_SetSRID(ST_MakePoint(47.54520, -18.89920), 4326) FROM ligne_bus WHERE numero = '178';
