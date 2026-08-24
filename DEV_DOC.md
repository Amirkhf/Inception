## 1. Mettre en place l'environnement depuis zéro

**Prérequis** :
- Une VM Linux 
- Docker et Docker Compose installés sur cette VM

**Fichier de configuration `.env`** :
Le fichier `srcs/.env` Il faut le créer manuellement avant le premier
lancement, avec les variables suivantes :

```
DOMAIN_NAME=amkhelif.42.fr
MYSQL_DATABASE=inception_db
MYSQL_USER=dbuser
MYSQL_PASSWORD=<mot de passe>
MYSQL_ROOT_PASSWORD=<mot de passe root>
WP_TITLE=Inception
WP_ADMIN_USER=<login admin, ne doit pas contenir "admin">
WP_ADMIN_PASSWORD=<mot de passe admin>
WP_ADMIN_EMAIL=<email admin>
WP_USER=<login utilisateur classique>
WP_PASSWORD=<mot de passe utilisateur>
WP_EMAIL=<email utilisateur>
```

**Secrets** : ce projet utilise un fichier `.env` pour toutes les données sensibles . Aucun mécanisme Docker secrets
supplémentaire n'est utilisé.

** le domaine localement** :
Ajouter une entrée dans `/etc/hosts` de la machine qui accède au site,
pointant `amkhelif.42.fr` vers l'IP de la VM.

## 2. Build et lancement via Makefile / Docker Compose

1. Crée les dossiers `/home/amkhelif/data/mariadb` et `/home/amkhelif/data/wordpress`
  2. Lance `docker compose up -d --build`.
     - `-d` : detached, les conteneurs tournent en arrière-plan.
     - `--build` : force la reconstruction des 3 images à partir des Dockerfiles

**Ordre de démarrage** : le `docker-compose.yml` définit des `depends_on` :
`wordpress` dépend de `mariadb`, `nginx` dépend de `wordpress`. `depends_on`
garantit seulement l'ordre de démarrage des conteneurs, pas que le service à
l'intérieur soit réellement prêt à recevoir des connexions. C'est pour ça que
`auto_config.sh` contient une boucle d'attente active tant
que MariaDB ne répond pas.

## 3. Gérer les conteneurs et les volumes

- **Voir les logs d'un service** :
  ```
  docker compose -f srcs/docker-compose.yml logs mariadb
  docker compose -f srcs/docker-compose.yml logs wordpress
  docker compose -f srcs/docker-compose.yml logs nginx
  ```
- **Entrer dans un conteneur** :
  ```
  docker exec -it mariadb sh
  docker exec -it wordpress sh
  docker exec -it nginx sh
  ```
- **Reconstruire une seule image** :

  ```
  docker compose -f srcs/docker-compose.yml build mariadb
  ```

- **Arrêter proprement sans supprimer** : `make stop`
- **Supprimer conteneurs (volumes conservés)** : `make down`
- **Tout supprimer (conteneurs + volumes + données sur l'hôte)** : `make fclean`
- **Reset complet puis relance** : `make re`

## 4. Où sont stockées les données 

Le projet utilise deux **volumes nommés** Docker, stockés sur l'hôte dans
`/home/amkhelif/data` :

- `mariadb_data` : la base de données, montée dans `mariadb` sur `/var/lib/mysql`.
- `wordpress_data` : les fichiers du site, montée dans `wordpress` **et** `nginx`
  sur `/var/www/html`, pour que nginx serve les fichiers statiques directement.

**Persistance** : les données survivent à un arrêt (`make down`) ou un
redémarrage de la VM. Seul `make fclean` les supprime.
