#!/bin/bash
#
# A lancer de la racine du projet.
# Petit script ayant pour but d'effacer les données de moodle.
#

source ./bin/functions.inc.sh

deleteDirectoryContentAndAddGitignore ./docker/redis/data1
deleteDirectoryContentAndAddGitignore ./docker/redis/data2