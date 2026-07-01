# Projet SIG Bus Antananarivo

Version adaptee au bus urbain, pas au taxi-brousse.

## Structure

- `database/` : schema PostGIS, donnees bus 146, 147, 178, requetes SIG.
- `backend/` : API Java Spring Boot et connexion PostgreSQL separee.
- `frontend/` : carte Leaflet en vue satellite avec localisation utilisateur, bus et suggestions.

## Lancer la base

```bash
createdb bus_sig
psql -d bus_sig -f database/01_schema.sql
psql -d bus_sig -f database/02_seed_bus_antananarivo.sql
```

## Lancer l'API

```bash
cd backend
mvn spring-boot:run
```

## Lancer le site

```bash
cd frontend
python3 -m http.server 5173
```

Ouvre ensuite:

```text
http://localhost:5173
```

La page fonctionne aussi en mode demo si le backend n'est pas encore lance.
