const API_BASE = "http://localhost:8081/api";

const demoLignes = [
    {
        id: 1,
        numero: "146",
        nom: "Ligne 146 - 67Ha vers Mausolee",
        depart: "67Ha",
        arrivee: "Mausolee",
        couleur: "#f97316",
        dureeEstimee: "35 a 50 min",
        frequenceEstimee: "8 a 12 min",
        prixEstime: 700,
        distanceKm: 6.8,
        geojson: JSON.stringify({type: "LineString", coordinates: [[47.5038, -18.8989], [47.5086, -18.9018], [47.5127, -18.8876], [47.5212, -18.8954], [47.5247, -18.8897], [47.5319, -18.886], [47.5378, -18.8993], [47.5233, -18.9175], [47.5272, -18.9252]]})
    },
    {
        id: 2,
        numero: "147",
        nom: "Ligne 147 - 67Ha vers Ambatomaro",
        depart: "67Ha",
        arrivee: "Ambatomaro",
        couleur: "#2563eb",
        dureeEstimee: "40 a 60 min",
        frequenceEstimee: "8 a 15 min",
        prixEstime: 700,
        distanceKm: 7.7,
        geojson: JSON.stringify({type: "LineString", coordinates: [[47.5038, -18.8989], [47.5086, -18.9018], [47.5212, -18.8954], [47.5247, -18.8897], [47.5319, -18.886], [47.5442, -18.8849], [47.5516, -18.8787], [47.5692, -18.8792]]})
    },
    {
        id: 3,
        numero: "178",
        nom: "Ligne 178 - 67Ha vers Andraisoro",
        depart: "67Ha",
        arrivee: "Andraisoro",
        couleur: "#16a34a",
        dureeEstimee: "30 a 45 min",
        frequenceEstimee: "7 a 12 min",
        prixEstime: 700,
        distanceKm: 6.3,
        geojson: JSON.stringify({type: "LineString", coordinates: [[47.5038, -18.8989], [47.5086, -18.9018], [47.5217, -18.9133], [47.5233, -18.9175], [47.5272, -18.9092], [47.5249, -18.904], [47.5319, -18.886], [47.5452, -18.8992]]})
    }
];

const demoArrets = [
    ["67Ha Est Parking", "67Ha", [47.5038, -18.8989]],
    ["Antohomadinika", "Antohomadinika", [47.5086, -18.9018]],
    ["Antanimena Poste", "Antanimena", [47.5212, -18.8954]],
    ["Ankadifotsy", "Ankadifotsy", [47.5247, -18.8897]],
    ["Andravoahangy", "Andravoahangy", [47.5319, -18.886]],
    ["Ampasampito", "Ampasampito", [47.5442, -18.8849]],
    ["Mausolee", "Anosy", [47.5272, -18.9252]],
    ["Ambatomaro", "Ambatomaro", [47.5692, -18.8792]],
    ["Andraisoro", "Andraisoro", [47.5452, -18.8992]]
].map((item, index) => ({
    id: index + 1,
    nom: item[0],
    quartier: item[1],
    geojson: JSON.stringify({type: "Point", coordinates: item[2]})
}));

const demoBus = [
    ["BUS-146-01", "146", [47.5212, -18.8954]],
    ["BUS-146-02", "146", [47.5272, -18.9175]],
    ["BUS-147-01", "147", [47.5442, -18.8849]],
    ["BUS-147-02", "147", [47.5692, -18.8792]],
    ["BUS-178-01", "178", [47.5233, -18.9175]],
    ["BUS-178-02", "178", [47.5452, -18.8992]]
].map((item, index) => ({
    id: index + 1,
    codeBus: item[0],
    ligneNumero: item[1],
    statut: "en_service",
    derniereMaj: "demo",
    geojson: JSON.stringify({type: "Point", coordinates: item[2]})
}));

const map = L.map("map", {zoomControl: false}).setView([-18.905, 47.526], 13);
L.control.zoom({position: "bottomright"}).addTo(map);

L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", {
    maxZoom: 19,
    attribution: "Tiles &copy; Esri"
}).addTo(map);

const routeLayers = new Map();
const arretLayer = L.layerGroup().addTo(map);
const busLayer = L.layerGroup().addTo(map);
let lignes = [];
let arrets = [];
let busPositions = [];
let activeRoute = null;
let userMarker = null;

async function loadJson(path, fallback) {
    try {
        const response = await fetch(`${API_BASE}${path}`);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        return await response.json();
    } catch (error) {
        return fallback;
    }
}

function parseGeoJson(item) {
    return typeof item.geojson === "string" ? JSON.parse(item.geojson) : item.geojson;
}

function renderRoutes(data) {
    routeLayers.forEach(layer => map.removeLayer(layer));
    routeLayers.clear();

    data.forEach(route => {
        const layer = L.geoJSON(parseGeoJson(route), {
            style: {
                color: route.couleur,
                weight: activeRoute === route.numero ? 7 : 5,
                opacity: activeRoute && activeRoute !== route.numero ? 0.42 : 0.95
            }
        }).bindPopup(`<strong>Ligne ${route.numero}</strong><br>${route.depart} - ${route.arrivee}<br>${route.distanceKm} km`);

        layer.on("click", () => selectRoute(route.numero));
        layer.addTo(map);
        routeLayers.set(route.numero, layer);
    });
}

function renderStops(data) {
    arretLayer.clearLayers();
    data.forEach(stop => {
        const coords = parseGeoJson(stop).coordinates;
        L.circleMarker([coords[1], coords[0]], {
            radius: 4,
            fillColor: "#ffffff",
            fillOpacity: 1,
            color: "#111827",
            weight: 1.5
        }).bindPopup(`<strong>${stop.nom}</strong><br>${stop.quartier || ""}`).addTo(arretLayer);
    });
}

function renderBus(data) {
    busLayer.clearLayers();
    data.forEach(bus => {
        const coords = parseGeoJson(bus).coordinates;
        const icon = L.divIcon({
            className: "",
            html: `<span class="bus-marker">${bus.ligneNumero}</span>`,
            iconSize: [32, 32],
            iconAnchor: [16, 16]
        });
        L.marker([coords[1], coords[0]], {icon})
            .bindPopup(`<strong>${bus.codeBus}</strong><br>Ligne ${bus.ligneNumero}<br>${bus.statut}`)
            .addTo(busLayer);
    });
}

function renderList() {
    const query = document.getElementById("searchInput").value.trim().toLowerCase();
    const filtered = lignes.filter(route => [route.numero, route.nom, route.depart, route.arrivee]
        .join(" ")
        .toLowerCase()
        .includes(query));

    document.getElementById("routeList").innerHTML = filtered.map(route => `
        <article class="route-card ${activeRoute === route.numero ? "active" : ""}" data-route="${route.numero}">
            <div class="route-head">
                <span class="route-number" style="background:${route.couleur}">${route.numero}</span>
                <h2 class="route-name">${route.depart} - ${route.arrivee}</h2>
            </div>
            <div class="meta">
                <span>${route.distanceKm} km</span>
                <span>${route.dureeEstimee}</span>
                <span>${route.prixEstime} Ar</span>
            </div>
        </article>
    `).join("");

    document.querySelectorAll(".route-card").forEach(card => {
        card.addEventListener("click", () => selectRoute(card.dataset.route));
    });
}

function renderStats() {
    const count = lignes.length;
    const avg = count ? lignes.reduce((sum, route) => sum + Number(route.distanceKm), 0) / count : 0;
    const busCount = busPositions.length;
    document.getElementById("stats").innerHTML = `
        <div class="stat"><strong>${count}</strong><span>lignes</span></div>
        <div class="stat"><strong>${avg.toFixed(1)}</strong><span>km moyen</span></div>
        <div class="stat"><strong>${busCount}</strong><span>bus localises</span></div>
    `;
}

function renderLegend() {
    document.getElementById("legend").innerHTML = lignes.map(route => `
        <div class="legend-row"><span class="swatch" style="background:${route.couleur}"></span>Ligne ${route.numero}</div>
    `).join("");
}

function selectRoute(numero) {
    activeRoute = activeRoute === numero ? null : numero;
    renderRoutes(lignes);
    renderList();
    if (activeRoute) {
        map.fitBounds(routeLayers.get(activeRoute).getBounds(), {padding: [40, 40]});
    }
}

function distanceMeters(a, b) {
    const earth = 6371000;
    const dLat = (b[1] - a[1]) * Math.PI / 180;
    const dLon = (b[0] - a[0]) * Math.PI / 180;
    const lat1 = a[1] * Math.PI / 180;
    const lat2 = b[1] * Math.PI / 180;
    const x = Math.sin(dLat / 2) ** 2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dLon / 2) ** 2;
    return 2 * earth * Math.atan2(Math.sqrt(x), Math.sqrt(1 - x));
}

function suggestFromLocation(coords) {
    const suggestions = lignes
        .map(route => {
            const points = parseGeoJson(route).coordinates;
            const nearest = Math.min(...points.map(point => distanceMeters(coords, point)));
            return {...route, nearest};
        })
        .sort((a, b) => a.nearest - b.nearest)
        .slice(0, 3);

    document.getElementById("suggestions").innerHTML = suggestions.map(route => `
        <div class="suggestion">
            <strong>Ligne ${route.numero}</strong> ${route.depart} - ${route.arrivee}<br>
            environ ${Math.round(route.nearest)} m du trace
        </div>
    `).join("");
}

function locateUser() {
    if (!navigator.geolocation) {
        document.getElementById("suggestions").innerHTML = `<div class="suggestion">Localisation indisponible sur ce navigateur.</div>`;
        return;
    }

    navigator.geolocation.getCurrentPosition(position => {
        const coords = [position.coords.longitude, position.coords.latitude];
        if (userMarker) map.removeLayer(userMarker);
        userMarker = L.circleMarker([coords[1], coords[0]], {
            radius: 8,
            fillColor: "#0f766e",
            fillOpacity: 0.9,
            color: "#ffffff",
            weight: 3
        }).bindPopup("Votre position").addTo(map);
        map.setView([coords[1], coords[0]], 15);
        suggestFromLocation(coords);
    }, () => {
        document.getElementById("suggestions").innerHTML = `<div class="suggestion">Autorisez la localisation pour recevoir des suggestions.</div>`;
    }, {enableHighAccuracy: true, timeout: 9000});
}

async function init() {
    [lignes, arrets, busPositions] = await Promise.all([
        loadJson("/lignes", demoLignes),
        loadJson("/arrets", demoArrets),
        loadJson("/bus", demoBus)
    ]);

    renderRoutes(lignes);
    renderStops(arrets);
    renderBus(busPositions);
    renderStats();
    renderLegend();
    renderList();
    suggestFromLocation([47.5220, -18.9020]);

    document.getElementById("searchInput").addEventListener("input", renderList);
    document.getElementById("locateBtn").addEventListener("click", locateUser);
}

init();
