## 1.

- **nginx** : point d'entrée unique de l'infrastructure (port 443, HTTPS uniquement).
  Il reçoit toutes les requêtes des visiteurs. Les fichiers statiques (images, CSS, JS)
  sont servis directement par nginx. Les requêtes PHP sont transmises à WordPress
  via le protocole FastCGI (port 9000).

- **wordpress** : le CMS (système de gestion de contenu) qui fait tourner le site.
  Écrit en PHP, exécuté par PHP-FPM. C'est lui qui génère les pages dynamiques
  et communique avec la base de données pour récupérer le contenu.

- **mariadb** : la base de données du site. Elle stocke tout ce que WordPress a
  besoin de conserver : articles, pages, commentaires, utilisateurs, configuration.

## 2. Démarrer / arrêter le projet

  make = Crée les dossiers de données puis construit les 3 images Docker et lance les conteneurs.

  make stop = Les conteneurs sont mis en pause, les données et les images restent intactes.

  make start = Redémarrer des conteneurs  stoppés

  make down = Arrêter et supprimer les conteneurs

  make fclean = Tout nettoyer conteneurs volumes images et les données sur l'hôte

  make re = Tout nettoyer puis relancer


## 3. Accéder au site et au panneau d'administration

- **Site public** : https://amkhelif.42.fr
- **Panneau d'administration WordPress** : https://amkhelif.42.fr/wp-admin

## 4. Localiser et gérer les identifiants

Tous les identifiants sont stockés dans srcs/.env

Variables présentes dans `.env` :


## 5. Vérifier que les services tournent correctement

- Vérifier que les 3 conteneurs sont actifs = docker compose -f srcs/docker-compose.yml ps


- Vérifier que les volumes existent :

  docker volume ls
  docker volume inspect srcs_mariadb_data
  docker volume inspect srcs_wordpress_data

- Vérifier que le réseau existe = docker network ls
