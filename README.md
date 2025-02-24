# Hearthstone Info - Application Flutter

Bienvenue dans ce projet Flutter, qui a pour objectif de proposer une application permettant de visualiser et d’explorer des cartes Hearthstone, avec la possibilité de gérer ses cartes favorites et d’afficher des informations sur l’application et son développeur.

## Sommaire

1. [Fonctionnalités principales](#fonctionnalités-principales)  
2. [Structure du projet](#structure-du-projet)  
3. [Installation et exécution](#installation-et-exécution)  
4. [Utilisation](#utilisation)  
5. [Personnalisation](#personnalisation)  
6. [Données et droits d’auteur](#données-et-droits-dauteur)  
7. [Auteurs](#auteurs)  

---

## Fonctionnalités principales

- **Accueil (HomePage)** : Affiche une grille de cartes Hearthstone issues des assets du projet. Vous pouvez naviguer entre différentes pages de résultats grâce à des flèches « Précédent » et « Suivant ».
- **Détails d’une carte (DetailsPage)** : Affiche plus d’informations sur la carte sélectionnée (nom, description, faction, etc.). Permet également d’ajouter la carte en favoris.
- **Favoris (FavoritesPage)** : Regroupe toutes les cartes que vous avez marquées comme favorites. Les cartes y sont affichées sous forme de grille cliquable pour revoir leurs détails.
- **Page d’informations (InfoPage)** : Donne des renseignements sur l’application, notamment son but, son développeur ainsi que le lien vers le dépôt GitHub.

---

## Structure du projet

Le projet est structuré de la manière suivante :

```
lib/
 ┣ services/
 ┃   ┗ favorites_manager.dart        # Gestion des favoris (singleton)
 ┣ home/
 ┃   ┗ home.dart                     # Page d'accueil (liste des cartes)
 ┣ details/
 ┃   ┗ details.dart                  # Page de détails pour chaque carte
 ┣ favorites/
 ┃   ┗ FavoritesPage.dart            # Page regroupant les favoris
 ┣ info/
 ┃   ┗ InfoPage.dart                 # Page d'information sur l'application
 ┗ main.dart                         # Point d'entrée de l'application
assets/
 ┣ images/                           # Images des cartes Hearthstone
 ┗ api/
     ┗ filtered_cards.json           # Données JSON filtrées sur les cartes
pubspec.yaml                         # Fichier de configuration Flutter
```

- **HomePage (home.dart)** : Gère l’affichage initial des cartes et la navigation entre les pages (Home, Favoris, Info).  
- **FavoritesPage (FavoritesPage.dart)** : Affiche les cartes favorites.  
- **InfoPage (InfoPage.dart)** : Affiche les informations sur l’application et son développeur (copyright, contact…).  
- **DetailsPage (details.dart)** : Récupère et affiche les informations détaillées d’une carte, et permet l’ajout ou la suppression des favoris via `FavoritesManager`.  
- **FavoritesManager (favorites_manager.dart)** : Classe utilitaire pour gérer les favoris en mémoire.

---

## Installation et exécution

### Prérequis

- Avoir Flutter installé (version stable recommandée).  
- Avoir un émulateur Android/iOS fonctionnel ou un appareil physique branché.  

### Étapes

8. **Cloner le dépôt** :  
   ```bash
   git clone https://github.com/Aoxcis/AMSE.git
   cd AMSE/tp1
   ```
9. **Installer les dépendances** :  
   ```bash
   flutter pub get
   ```
10. **Exécuter l’application** :  
   ```bash
   flutter run
   ```
11. **(Optionnel) Génération APK/IPA** :  
   - Android :  
     ```bash
     flutter build apk
     ```  
   - iOS :  
     ```bash
     flutter build ios
     ```

---

## Utilisation

12. **Page d’accueil (Home)**  
   - Des cartes Hearthstone sont affichées sous forme de grille.  
   - Utilisez les flèches « Précédent » et « Suivant » en bas de l’écran pour naviguer entre les pages de cartes.  

13. **Détails d’une carte**  
   - Touchez une carte sur la grille pour accéder à ses informations détaillées.  
   - Vous pouvez ajouter la carte aux favoris grâce au bouton flottant (icône de cœur).  

14. **Favoris**  
   - Accédez à l’onglet « Favoris » via la barre de navigation en bas.  
   - Consultez la liste des cartes favorites et appuyez sur une carte pour rouvrir sa page de détails.  

15. **Page d’information (Info)**  
   - Depuis la barre de navigation, l’icône « Info » ouvre la page qui détaille le but de l’application, mentionne l’auteur et indique un lien vers le code source.  

---

## Personnalisation

- **Ajouter de nouvelles cartes** :  
  - Placez vos images de cartes dans le dossier `assets/images/`.  
  - Mettez à jour le fichier `pubspec.yaml` pour inclure ces nouveaux assets.  
  - Ajoutez les informations correspondantes dans `api/filtered_cards.json`.   

- **Changer la navigation** :  
  - La navigation repose sur la `NavigationBar` en bas de chaque page. Les routes `/home`, `/favorites` et `/info` sont gérées via `Navigator.pushReplacementNamed`. 

---

## Données et droits d’auteur

Les données et images de cartes proviennent de l’API **HearthstoneJSON** et sont la propriété exclusive de **Blizzard Entertainment**.  
- © Blizzard Entertainment. Tous droits réservés.  
- Ce projet n’est en aucun cas affilié à Blizzard Entertainment.  

Le projet lit localement le fichier `filtered_cards.json`, qui contient des informations extraites de l’API HearthstoneJSON. Les images sont stockées dans `assets/images/` et listées dans `AssetManifest.json`.

---

## Auteurs

- **Développeur** : Grégoire Paul  
  - Contact : [gregoire.paul@etu.imt-nord-europe.fr](mailto:gregoire.paul@etu.imt-nord-europe.fr)  
  - [Profil GitHub](https://github.com/Aoxcis/AMSE.git)

---

**Merci d’avoir téléchargé ou consulté cette application !**  
N’hésitez pas à contribuer, signaler des problèmes ou proposer des améliorations via le dépôt GitHub. Bonne exploration des cartes Hearthstone !