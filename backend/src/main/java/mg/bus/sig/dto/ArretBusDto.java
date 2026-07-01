package mg.bus.sig.dto;

public record ArretBusDto(
        int id,
        String nom,
        String quartier,
        String geojson
) {
}
