# Moodle dev env

Projet ayant pour but de reconstituer un environnement de développement pour Moodle, qui soit aussi proche de la prod que possible.

Une fois démarré, Moodle est disponible à l'adresse suivante : http://localhost:8080

## Fonctionnement

**IMPORTANT** : Avant toute chose, il faut initialiser le projet avec la commande suivante :
```bash
bash ./bin/init.sh
```

Ensuite il faut charger le code de moodle dans le dossier public.

Construire la stack de dev :
```bash
docker-compose build
```

Démarrer la stack de dev :
```bash
docker-compose up
```

Stopper la stack de dev : `ctrl + c`

Démarrer la stack de dev en background :
```bash
docker-compose up -d
```

Stopper la stack de dev en background :
```bash
docker-compose down
```

Le code de Moodle est à déployer dans le dossier public.  
Le dossier public est dans le .gitignore pour ne pas être enregistré dans ce dépôt.

## Composition

* apache : Le frontal.
* php : Pour executer Moodle.
* mariadb : La BDD.
* redis1 : Le serveur 1/2 du cluster Redis.
* redis2 : Le serveur 2/2 du cluster Redis.
* sentinel1 : Le serveur 1/3 de Sentinel, pour gérer quel est le redis maître.
* sentinel2 : Le serveur 2/3 de Sentinel.
* sentinel3 : Le serveur 3/3 de Sentinel.
* haproxy : Gére la séparation sur deux ports des requêtes de lecture/écriture vers Redis.
* adminer : Consultation de la bdd.
* phpredisadmin : Permet de consulter redis a travers une interface web.

## Ports linké sur localhost

* [8080](http://localhost:8080) : http moodle
* [8081](http://localhost:8081) : http adminer
* [8082](http://localhost:8082) : http phpredisadmin
* [8083](http://localhost:8083) : http stats haproxy
* 33306 : mariadb
* 56379 : haproxy redis read
* 56380 : haproxy redis write

## Quelques commandes à connaître

### Redis

Le cluster Redis utilise deux containers **Redis** qui sont gérés par trois containers **Sentinel** pour savoir quel **Redis** est le maître.

Pour la suite de cette doc, les commandes vont être jouées sur le container **mde_redis1** mais il est possible de faire de même sur **mde_redis2**.


Faire un ping sur un **Redis** :
```bash
docker exec mde_redis1 redis-cli ping
```

Faire un `SET` sur un **Redis** (ne fonctionne que sur le master) :
```bash
docker exec mde_redis1 redis-cli SET hello "world"
```

Faire un `GET` sur un des **Redis** :
```bash
docker exec mde_redis1 redis-cli GET hello
```

Consulter les `GET` et `SET` d'un des **Redis** :
```bash
docker exec mde_redis1 redis-cli monitor | grep -E ' "(G|S)ET" '
```

Mettre en pause un des **Redis** pour 30s :
```bash
docker exec mde_redis1 redis-cli -p 6379 DEBUG sleep 30
```

Savoir si un **Redis** est master :
```bash
docker exec mde_redis1 redis-cli info replication | grep role
```

### HAProxy

#### Utilisation de Redis

L'utilisation de **Redis** à travers **HAProxy** permet de faire la distinction sur deux ports entre les requêtes en écritures et les requêtes en lecture.  
Les requêtes en lectures seront diffusés entre les différents serveurs **Redis** alors que les requêtes en écritures seront addressées au master.

Voici les ports utilisés :
* Lecture : 6379
* Écriture : 6380

Les commandes précédentes sur **Redis** fonctionnent toujours à travers **HAProxy** à la différence prêt que les requêtes d'écritures doivent toutes être envoyé sur le port spécifique à l'écriture.  
Pour passer par **HAProxy** avec le cli d'un serveur redis il faut donc spécifier host et en cas d'écriture, le port.

Faire un set sur haproxy :
```bash
docker exec mde_redis1 redis-cli -h haproxy -p 6380 SET hello "world"
```

Faire un get sur haproxy :
```bash
docker exec mde_redis1 redis-cli -h haproxy GET hello
```