package mg.bus.sig.dto;

public record BusPositionDto(
        int id,
        String codeBus,
        String ligneNumero,
        String statut,
        String derniereMaj,
        String geojson
) {
}
