package mg.bus.sig.repository;

import mg.bus.sig.dto.ArretBusDto;
import mg.bus.sig.dto.BusPositionDto;
import mg.bus.sig.dto.LigneBusDto;
import mg.bus.sig.dto.SuggestionDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BusRepository {
    private final JdbcTemplate jdbcTemplate;

    public BusRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<LigneBusDto> findAllLignes() {
        String sql = """
                SELECT id, numero, nom, depart, arrivee, couleur, duree_estimee, frequence_estimee,
                       prix_estime, ROUND((ST_Length(geom::geography) / 1000)::numeric, 2) AS distance_km,
                       ST_AsGeoJSON(geom) AS geojson
                FROM ligne_bus
                ORDER BY numero
                """;
        return jdbcTemplate.query(sql, (rs, rowNum) -> new LigneBusDto(
                rs.getInt("id"),
                rs.getString("numero"),
                rs.getString("nom"),
                rs.getString("depart"),
                rs.getString("arrivee"),
                rs.getString("couleur"),
                rs.getString("duree_estimee"),
                rs.getString("frequence_estimee"),
                rs.getInt("prix_estime"),
                rs.getDouble("distance_km"),
                rs.getString("geojson")
        ));
    }

    public List<ArretBusDto> findAllArrets() {
        String sql = """
                SELECT id, nom, quartier, ST_AsGeoJSON(geom) AS geojson
                FROM arret_bus
                ORDER BY nom
                """;
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ArretBusDto(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("quartier"),
                rs.getString("geojson")
        ));
    }

    public List<BusPositionDto> findAllBusPositions() {
        String sql = """
                SELECT b.id, b.code_bus, l.numero AS ligne_numero, b.statut,
                       to_char(b.derniere_maj, 'YYYY-MM-DD HH24:MI:SS') AS derniere_maj,
                       ST_AsGeoJSON(b.geom) AS geojson
                FROM bus_position b
                JOIN ligne_bus l ON l.id = b.ligne_id
                ORDER BY l.numero, b.code_bus
                """;
        return jdbcTemplate.query(sql, (rs, rowNum) -> new BusPositionDto(
                rs.getInt("id"),
                rs.getString("code_bus"),
                rs.getString("ligne_numero"),
                rs.getString("statut"),
                rs.getString("derniere_maj"),
                rs.getString("geojson")
        ));
    }

    public List<SuggestionDto> suggestLignes(double longitude, double latitude) {
        String sql = """
                WITH utilisateur AS (
                    SELECT ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography AS geom
                )
                SELECT l.numero, l.nom, l.depart, l.arrivee,
                       ROUND(ST_Distance(l.geom::geography, u.geom)::numeric, 0) AS distance_m
                FROM ligne_bus l, utilisateur u
                ORDER BY l.geom::geography <-> u.geom
                LIMIT 3
                """;
        return jdbcTemplate.query(sql, (rs, rowNum) -> new SuggestionDto(
                rs.getString("numero"),
                rs.getString("nom"),
                rs.getString("depart"),
                rs.getString("arrivee"),
                rs.getDouble("distance_m")
        ), longitude, latitude);
    }
}
