# Base de donnees bus SIG

Ce dossier contient uniquement la partie base de donnees.

## Creation

```bash
createdb bus_sig
psql -d bus_sig -f database/01_schema.sql
psql -d bus_sig -f database/02_seed_bus_antananarivo.sql
```

## Verification SIG

```bash
psql -d bus_sig -f database/03_requetes_sig.sql
```

Les coordonnees sont en `EPSG:4326` avec l'ordre PostGIS habituel:
longitude, latitude.

Les donnees des lignes 146, 147 et 178 sont des donnees pedagogiques
approximatives pour une premiere version SIG. Pour un suivi reel des bus, il
faudra remplacer `bus_position` par des positions GPS recues en temps reel.
