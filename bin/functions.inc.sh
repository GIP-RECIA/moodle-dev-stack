#!/bin/bash
#
# Ensemble de fonction nécessaires aux autres scripts

# COLORS
BLACK=$(tput -Txterm setaf 0)
RED=$(tput -Txterm setaf 1)
GREEN=$(tput -Txterm setaf 2)
YELLOW=$(tput -Txterm setaf 3)
DK_BLUE=$(tput -Txterm setaf 4)
PINK=$(tput -Txterm setaf 5)
LT_BLUE=$(tput -Txterm setaf 6)

BOLD=$(tput -Txterm bold)
RESET=$(tput -Txterm sgr0)

# Global
TERM=xterm-color

export BLACK, RED, GREEN, YELLOW, DK_BLUE, PINK, LT_BLUE, BOLD, RESET, TERM


#######################################
# Vide un dossier et y replace un .gitignore
#
# Arguments:
#   Le dossier à vider et ou il faut remettre un .gitignore
#######################################
delete_directory_content_and_add_gitignore() {
    local gitignore="$1/.gitignore"

    rm -Rf "${1:?}"/*
    # Ici si pas de redirection des erreur, on a des erreurs sur les
    #  suppressions de "." et ".."
    rm -Rf "${1:?}"/.* 2>/dev/null

    touch "${gitignore}"
    {
      echo "# Ignore everything in this directory"
      echo "*"
      echo "# Except this file"
      echo "!.gitignore"
    } >> "${gitignore}"
}

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}