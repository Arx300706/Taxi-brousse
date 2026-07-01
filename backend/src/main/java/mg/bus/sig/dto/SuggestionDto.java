package mg.bus.sig.dto;

public record SuggestionDto(
        String numero,
        String nom,
        String depart,
        String arrivee,
        double distanceMetres
) {
}
