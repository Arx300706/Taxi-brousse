package mg.bus.sig.dto;

public record ArretProcheDto(
        int id,
        String nom,
        String quartier,
        double distanceMetres,
        String geojson
) {
}
