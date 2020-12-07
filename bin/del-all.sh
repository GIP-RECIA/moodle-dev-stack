#!/bin/bash
#
# A lancer de la racine du projet.
# Petit script ayant pour but d'effacer toutes les données.
#

bash ./bin/del-database.sh
bash ./bin/del-moodledata.sh
bash ./bin/del-redisdata.sh