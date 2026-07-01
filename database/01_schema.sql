CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS bus_position CASCADE;
DROP TABLE IF EXISTS ligne_arret CASCADE;
DROP TABLE IF EXISTS arret_bus CASCADE;
DROP TABLE IF EXISTS ligne_bus CASCADE;
DROP TABLE IF EXISTS terminus_bus CASCADE;

CREATE TABLE terminus_bus (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(120) NOT NULL,
    quartier VARCHAR(120),
    geom GEOMETRY(Point, 4326) NOT NULL
);

CREATE TABLE ligne_bus (
    id SERIAL PRIMARY KEY,
    numero VARCHAR(10) NOT NULL UNIQUE,
    nom VARCHAR(160) NOT NULL,
    depart VARCHAR(120) NOT NULL,
    arrivee VARCHAR(120) NOT NULL,
    couleur VARCHAR(20) NOT NULL DEFAULT '#1d4ed8',
    duree_estimee VARCHAR(40) NOT NULL,
    frequence_estimee VARCHAR(40) NOT NULL,
    prix_estime INTEGER NOT NULL,
    geom GEOMETRY(LineString, 4326) NOT NULL
);

CREATE TABLE arret_bus (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(140) NOT NULL,
    quartier VARCHAR(120),
    geom GEOMETRY(Point, 4326) NOT NULL
);

CREATE TABLE ligne_arret (
    ligne_id INTEGER NOT NULL REFERENCES ligne_bus(id) ON DELETE CASCADE,
    arret_id INTEGER NOT NULL REFERENCES arret_bus(id) ON DELETE CASCADE,
    ordre INTEGER NOT NULL,
    PRIMARY KEY (ligne_id, arret_id)
);

CREATE TABLE bus_position (
    id SERIAL PRIMARY KEY,
    ligne_id INTEGER NOT NULL REFERENCES ligne_bus(id) ON DELETE CASCADE,
    code_bus VARCHAR(30) NOT NULL,
    statut VARCHAR(30) NOT NULL DEFAULT 'en_service',
    derniere_maj TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    geom GEOMETRY(Point, 4326) NOT NULL
);

CREATE INDEX idx_terminus_bus_geom ON terminus_bus USING GIST (geom);
CREATE INDEX idx_ligne_bus_geom ON ligne_bus USING GIST (geom);
CREATE INDEX idx_arret_bus_geom ON arret_bus USING GIST (geom);
CREATE INDEX idx_bus_position_geom ON bus_position USING GIST (geom);
