#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " copy-database.sh <DATABASEL> <NEW_DATABASE>"
  echo
  echo " example:"
  echo "   sh /scripts/copy-database.sh teste copia_teste"
  echo -e "==================================${COLOR_CLEAN}"
}

DATABASE_NAME=$1
NEW_DATABASE_NAME=$2

if [ -z $DATABASE_NAME ] || [ -z $NEW_DATABASE_NAME ]; then
  echo -e "${COLOR_RED}Erro: Parâmetros esperados inválidos"
  example;
  exit 1;
fi

psql -U $POSTGRES_USER -c "CREATE DATABASE $NEW_DATABASE_NAME WITH TEMPLATE $DATABASE_NAME;"