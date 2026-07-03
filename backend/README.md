# Backend Spring Boot

API pour les lignes de bus urbaines d'Antananarivo.

## Configuration de connexion

La connexion base est separee dans `src/main/resources/application.properties`.
Tu peux aussi utiliser des variables d'environnement:

```bash
export DB_URL=jdbc:postgresql://localhost:5432/bus_sig
export DB_USER=postgres
export DB_PASSWORD=postgres
export GOOGLE_MAPS_API_KEY=ta_cle_google_maps
```

`GOOGLE_MAPS_API_KEY` est optionnel. Sans cette variable, le frontend garde la
carte Esri par defaut.

## Lancer

```bash
cd backend
mvn spring-boot:run
```

Endpoints:

- `GET http://localhost:8081/api/lignes`
- `GET http://localhost:8081/api/trajets`
- `GET http://localhost:8081/api/arrets`
- `GET http://localhost:8081/api/arrets/proche?longitude=47.53273&latitude=-18.98603`
- `GET http://localhost:8081/api/bus`
- `GET http://localhost:8081/api/suggestions?longitude=47.5220&latitude=-18.9020`
- `GET http://localhost:8081/api/config/maps`
