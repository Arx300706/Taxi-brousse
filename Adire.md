# Ce que on peux dire (≈ 88 secondes)

**Slide 1 — Titre (≈ 8s)**
> "Bonjour, nous vous présentons notre projet SIG : une application de webmapping pour le réseau de bus urbain d'Antananarivo, sur les lignes 146, 147, 178 et 187, développée avec PostgreSQL/PostGIS, Spring Boot et Leaflet.js."

**Slide 2 — Contexte & problématique (≈ 35s)**
> "Le transport urbain à Antananarivo repose sur des minibus privés dont l'information circule presque uniquement à l'oral : itinéraires, arrêts, correspondances. Un nouvel usager ne sait donc pas rapidement quelle ligne prendre ni où descendre, et aucune donnée n'est centralisée pour analyser le réseau. Notre problématique : comment permettre à un usager de visualiser les lignes autour de lui, trouver l'arrêt ou le bus le plus proche, et estimer une distance, depuis un simple navigateur ? Nous avons voulu construire un vrai SIG — pas une carte décorative, mais un système capable de mesurer, chercher et classer."

**Slide 3 — Architecture technique (≈ 45s)**
> "Techniquement, le projet repose sur une architecture trois tiers. Le client utilise Leaflet.js et l'API de géolocalisation du navigateur. Le serveur applicatif, en Java Spring Boot, expose une API REST sur le port 8081, organisée en Controller, Service et Repository. Enfin, les données sont stockées dans PostgreSQL avec l'extension PostGIS, en SRID 4326, avec des index spatiaux GIST pour les performances. C'est cette base spatiale qui permet nos fonctions comme ST_Length, ST_Distance, ST_DWithin ou le plus proche voisin — que mes collègues vont maintenant vous détailler."


**Slide 4 — Fonctionnalités utilisateur (≈ 28-30s)**
> "Concrètement, l'application propose une carte interactive centrée sur Antananarivo. Chaque tracé est cliquable et affiche sa distance, sa durée et son prix. Un champ de recherche permet de filtrer par ligne, quartier ou nom d'arrêt. La géolocalisation calcule automatiquement l'arrêt et le bus les plus proches de l'utilisateur — avec un bouton de secours pour la démonstration si le GPS ne répond pas. Au final, l'application ne se contente pas de montrer où sont les lignes : elle répond à la question 'quelle ligne est la plus utile, ici et maintenant ?'"


## Démo minutée — 1m30

**0-15s : Vue d'ensemble**
- Montrer la carte au chargement, avec les 4 tracés colorés (146 orange, 147 bleu, 178 vert, 187 rouge)
- *"Voici l'application au chargement : les quatre lignes sont affichées avec leurs couleurs, et le panneau à gauche donne déjà les statistiques clés — nombre de lignes, distance moyenne, bus localisés."*

**15-35s : Interaction avec une ligne**
- Cliquer sur une carte de ligne (ex: 146) dans la sidebar, ou directement sur le tracé
- Montrer le zoom automatique et les infos affichées (distance, durée, prix)
- *"Si je clique sur une ligne, la carte zoome dessus et affiche sa distance exacte, sa durée estimée et son prix."*

**35-50s : Recherche**
- Taper un nom de quartier ou un numéro de ligne dans la barre de recherche
- *"On peut aussi chercher directement par quartier ou par numéro de ligne."*

**50-75s : Géolocalisation & suggestions (le moment fort)**
- Activer la géolocalisation (ou utiliser le bouton ITU si simulation pour la ligne 187)
- Montrer la liste des suggestions qui apparaît, classée par distance
- *"En activant la géolocalisation — ou avec le bouton de simulation pour la démonstration — l'application calcule en temps réel les lignes, l'arrêt et le bus les plus proches de notre position, classés par distance."*

**75-90s : Clôture**
- Revenir à la vue d'ensemble ou rester sur les suggestions
- *"C'est cette capacité à calculer, et pas seulement afficher, qui fait de ce projet un véritable système d'information géographique."*
