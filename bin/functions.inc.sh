#!/bin/bash
#
# Ensemble de fonction nécessaires aux autres scripts

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