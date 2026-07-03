package mg.bus.sig.service;

import mg.bus.sig.dto.ArretBusDto;
import mg.bus.sig.dto.ArretProcheDto;
import mg.bus.sig.dto.BusPositionDto;
import mg.bus.sig.dto.LigneBusDto;
import mg.bus.sig.dto.SuggestionDto;
import mg.bus.sig.repository.BusRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusService {
    private final BusRepository busRepository;

    public BusService(BusRepository busRepository) {
        this.busRepository = busRepository;
    }

    public List<LigneBusDto> getLignes() {
        return busRepository.findAllLignes();
    }

    public List<ArretBusDto> getArrets() {
        return busRepository.findAllArrets();
    }

    public ArretProcheDto getArretProche(double longitude, double latitude) {
        return busRepository.findNearestArret(longitude, latitude);
    }

    public List<BusPositionDto> getBusPositions() {
        return busRepository.findAllBusPositions();
    }

    public List<SuggestionDto> suggestLignes(double longitude, double latitude) {
        return busRepository.suggestLignes(longitude, latitude);
    }
}
