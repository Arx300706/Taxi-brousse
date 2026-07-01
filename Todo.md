TODO — Projet SIG Taxi-brousse
Phase 1 — Préparer le projet
À faire
 Créer le dossier du projet :
taxibrousse-sig/
├── backend/
├── frontend/
└── database/
 Installer PostgreSQL
 Installer PostGIS
 Installer Java JDK
 Installer Spring Boot
 Installer VS Code ou IntelliJ
 Vérifier que PostgreSQL fonctionne
Objectif de cette phase

Avoir un environnement propre avant de coder.

Phase 2 — Créer la base de données PostgreSQL/PostGIS
À faire
 Créer une base de données :
CREATE DATABASE taxibrousse_sig;
 Activer PostGIS :
CREATE EXTENSION postgis;
 Créer les tables principales :
gare_routiere
arret_taxibrousse
trajet_taxibrousse
 Ajouter les colonnes géométriques :
Point pour les gares
Point pour les arrêts
LineString pour les trajets
 Ajouter les index spatiaux avec GIST
Objectif de cette phase

Ta base doit être capable de stocker des données géographiques.

Phase 3 — Insérer les premières données
À faire

Commence petit. Ne mets pas 50 trajets au début.

 Ajouter 3 gares routières :
Antananarivo
Antsirabe
Toamasina
 Ajouter 3 trajets :
Antananarivo → Antsirabe
Antananarivo → Toamasina
Antananarivo → Mahajanga
 Ajouter quelques arrêts intermédiaires
 Vérifier que les coordonnées sont correctes :
longitude d’abord
latitude ensuite

Exemple :

ST_MakePoint(47.5200, -18.8792)

Attention : l’ordre est longitude, latitude, pas l’inverse.

Objectif de cette phase

Avoir des données simples mais fonctionnelles.

Phase 4 — Tester les requêtes SIG
À faire
 Calculer la distance d’un trajet :
SELECT 
    nom,
    ROUND((ST_Length(geom::geography) / 1000)::numeric, 2) AS distance_km
FROM trajet_taxibrousse;
 Convertir un trajet en GeoJSON :
SELECT ST_AsGeoJSON(geom)
FROM trajet_taxibrousse;
 Trouver les arrêts proches d’un trajet :
SELECT a.nom
FROM arret_taxibrousse a, trajet_taxibrousse t
WHERE ST_DWithin(a.geom::geography, t.geom::geography, 1000);
Objectif de cette phase

Prouver que ton projet est vraiment un projet SIG, pas seulement une carte décorative.

Phase 5 — Créer le backend Java Spring Boot
À faire
 Créer un projet Spring Boot
 Ajouter les dépendances :
Spring Web
Spring JDBC
PostgreSQL Driver
 Configurer application.properties :
spring.datasource.url=jdbc:postgresql://localhost:5432/taxibrousse_sig
spring.datasource.username=postgres
spring.datasource.password=ton_mot_de_passe
 Créer les packages :
controller
service
repository
dto
model
 Créer l’API :
GET /api/trajets
GET /api/gares
GET /api/arrets
Objectif de cette phase

Java doit récupérer les données PostGIS et les envoyer au frontend.

Phase 6 — Créer l’API des trajets
À faire
 Créer TrajetDto
 Créer TrajetRepository
 Créer TrajetService
 Créer TrajetController
 Tester l’URL :
http://localhost:8080/api/trajets

Le résultat doit ressembler à ça :

[
  {
    "id": 1,
    "nom": "Antananarivo - Antsirabe",
    "depart": "Antananarivo",
    "arrivee": "Antsirabe",
    "prixEstime": 25000,
    "dureeEstimee": "4h à 5h",
    "distanceKm": 168.5,
    "geojson": "{...}"
  }
]
Objectif de cette phase

Avoir une API fonctionnelle avant de toucher au design.

Phase 7 — Créer le frontend HTML/CSS/JS
À faire
 Créer index.html
 Créer style.css
 Créer app.js
 Ajouter Leaflet.js
 Afficher une carte centrée sur Madagascar
 Afficher les trajets avec L.geoJSON
 Afficher les popups
 Afficher la liste des trajets à gauche
Objectif de cette phase

Voir les trajets sur une vraie carte interactive.

Phase 8 — Améliorer l’interface

À faire seulement quand les données et l’API marchent.

 Faire une sidebar propre
 Ajouter une barre de recherche
 Ajouter des cartes de trajets
 Ajouter un bouton pour zoomer sur un trajet
 Ajouter une légende de carte
 Ajouter des couleurs différentes pour les trajets
 Ajouter les gares avec des icônes
 Ajouter les arrêts avec de petits marqueurs
Objectif de cette phase

Rendre le projet agréable à utiliser et présentable.

Phase 9 — Ajouter les fonctions importantes
Fonctions à ajouter
 Recherche par ville de départ
 Recherche par ville d’arrivée
 Filtre par prix
 Filtre par durée
 Affichage de la distance
 Affichage des arrêts proches du trajet
 Clic sur un trajet pour voir les détails
 Statistiques simples :
nombre de trajets
distance moyenne
trajet le plus long
trajet le moins cher
Objectif de cette phase

Donner de la valeur au projet, pas juste afficher des lignes.

Phase 10 — Préparer le rapport
Plan conseillé
INTRODUCTION

I. Contexte du projet
   1. Transport interurbain à Madagascar
   2. Importance du taxi-brousse
   3. Apport du SIG

II. Méthodologie
   1. Technologies utilisées
   2. PostgreSQL/PostGIS
   3. Java Spring Boot
   4. Leaflet.js
   5. Structure de la base de données

III. Réalisation
   1. Modèle de données
   2. Création des tables
   3. Requêtes spatiales
   4. API REST
   5. Interface cartographique

IV. Résultats
   1. Carte interactive
   2. Visualisation des trajets
   3. Calcul des distances
   4. Recherche et filtrage

V. Limites et perspectives
   1. Données approximatives
   2. Ajout du GPS réel
   3. Ajout des horaires
   4. Application mobile

CONCLUSION
Ordre exact à suivre

Ne saute pas les étapes.

1. Créer la base PostgreSQL/PostGIS
2. Créer les tables
3. Insérer 3 trajets
4. Tester les requêtes SIG
5. Créer l’API Java
6. Tester l’API avec le navigateur
7. Créer la carte HTML/JS
8. Afficher les trajets
9. Ajouter la belle interface
10. Rédiger le rapport
Version minimale à finir d’abord

Avant de rêver d’une grande application, termine cette version :

 Une carte de Madagascar
 3 trajets de taxi-brousse
 Une liste de trajets
 Un clic sur un trajet
 Un zoom automatique
 Une popup avec distance, prix et durée
 Les données stockées dans PostgreSQL/PostGIS
 Les données envoyées par Java Spring Boot

Si tu finis ça proprement, ton projet est déjà défendable.

Version avancée après

Ensuite seulement, tu peux ajouter :

 Connexion utilisateur
 Ajout de trajet depuis l’interface
 Modification d’un trajet
 Suppression d’un trajet
 Import de fichier GeoJSON
 Export de trajet en GeoJSON
 Statistiques SIG
 Interface responsive mobile
Mon conseil direct

Ton plus grand risque, c’est de vouloir faire une très belle interface avant d’avoir une base SIG solide.

Priorité réelle :

PostGIS > API Java > Carte Leaflet > Design