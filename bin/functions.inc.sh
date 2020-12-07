#!/bin/bash

# Vide un dossier et y replace un .gitignore
#
# $1 : Le dossier à vider et ou il faut remettre un .gitignore
deleteDirectoryContentAndAddGitignore() {
    rm -Rf $1/*
    GITIGNORE=$1/.gitignore
    echo "# Ignore everything in this directory" > $GITIGNORE
    echo "*" >> $GITIGNORE
    echo "# Except this file" >> $GITIGNORE
    echo "!.gitignore" >> $GITIGNORE
}