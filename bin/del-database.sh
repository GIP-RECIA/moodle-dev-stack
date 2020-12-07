#!/bin/bash
#
# A lancer de la racine du projet.
# Petit script ayant pour but d'effacer la base de données.
#

source ./bin/functions.inc.sh

deleteDirectoryContentAndAddGitignore ./docker/mariadb/data