#!/bin/bash
#
# Ensemble de fonction nécessaires aux autres scripts

# COLORS
export BLACK=$(tput -Txterm setaf 0)
export RED=$(tput -Txterm setaf 1)
export GREEN=$(tput -Txterm setaf 2)
export YELLOW=$(tput -Txterm setaf 3)
export DK_BLUE=$(tput -Txterm setaf 4)
export PINK=$(tput -Txterm setaf 5)
export LT_BLUE=$(tput -Txterm setaf 6)

export BOLD=$(tput -Txterm bold)
export RESET=$(tput -Txterm sgr0)

# Global
export TERM=xterm-color


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