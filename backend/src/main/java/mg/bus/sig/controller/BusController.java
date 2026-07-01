package mg.bus.sig.controller;

import mg.bus.sig.dto.ArretBusDto;
import mg.bus.sig.dto.BusPositionDto;
import mg.bus.sig.dto.LigneBusDto;
import mg.bus.sig.dto.SuggestionDto;
import mg.bus.sig.service.BusService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class BusController {
    private final BusService busService;

    public BusController(BusService busService) {
        this.busService = busService;
    }

    @GetMapping("/lignes")
    public List<LigneBusDto> lignes() {
        return busService.getLignes();
    }

    @GetMapping("/arrets")
    public List<ArretBusDto> arrets() {
        return busService.getArrets();
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
