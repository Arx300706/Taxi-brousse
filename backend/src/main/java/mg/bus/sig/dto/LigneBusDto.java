package mg.bus.sig.dto;

public record LigneBusDto(
        int id,
        String numero,
        String nom,
        String depart,
        String arrivee,
        String couleur,
        String dureeEstimee,
        String frequenceEstimee,
        int prixEstime,
        double distanceKm,
        String geojson
) {
}
