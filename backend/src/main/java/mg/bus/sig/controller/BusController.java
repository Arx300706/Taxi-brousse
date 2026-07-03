package mg.bus.sig.controller;

import mg.bus.sig.dto.ArretBusDto;
import mg.bus.sig.dto.ArretProcheDto;
import mg.bus.sig.dto.BusPositionDto;
import mg.bus.sig.dto.LigneBusDto;
import mg.bus.sig.dto.SuggestionDto;
import mg.bus.sig.service.BusService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class BusController {
    private final BusService busService;
    private final String googleMapsApiKey;

    public BusController(BusService busService, @Value("${google.maps.api-key:}") String googleMapsApiKey) {
        this.busService = busService;
        this.googleMapsApiKey = googleMapsApiKey;
    }

    @GetMapping("/config/maps")
    public Map<String, String> mapsConfig() {
        return Map.of("googleMapsApiKey", googleMapsApiKey);
    }

    @GetMapping("/lignes")
    public List<LigneBusDto> lignes() {
        return busService.getLignes();
    }

    @GetMapping("/trajets")
    public List<LigneBusDto> trajets() {
        return busService.getLignes();
    }

    @GetMapping("/arrets")
    public List<ArretBusDto> arrets() {
        return busService.getArrets();
    }

    @GetMapping("/arrets/proche")
    public ArretProcheDto arretProche(
            @RequestParam double longitude,
            @RequestParam double latitude
    ) {
        return busService.getArretProche(longitude, latitude);
    }

    @GetMapping("/bus")
    public List<BusPositionDto> bus() {
        return busService.getBusPositions();
    }

    @GetMapping("/suggestions")
    public List<SuggestionDto> suggestions(
            @RequestParam double longitude,
            @RequestParam double latitude
    ) {
        return busService.suggestLignes(longitude, latitude);
    }
}
