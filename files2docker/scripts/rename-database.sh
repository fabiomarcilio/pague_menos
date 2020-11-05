#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " restore-database.sh <DATABASE_NAME> <NEW_DATABASE_NAME>"
  echo
  echo " example:"
  echo "   sh /scripts/restore-database.sh meu_banco_atual meu_novo_banco"
  echo -e "==================================${COLOR_CLEAN}"
}


DATABASE_NAME=$1
NEW_DATABASE_NAME=$2

if [ -z $DATABASE_NAME ] || [ -z $NEW_DATABASE_NAME ]; then
  echo -e "${COLOR_RED}Erro: Parâmetros esperados inválidos"
  example;
  exit 1;
fi

psql -U $POSTGRES_USER -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$NEW_DATABASE_NAME' AND pid <> pg_backend_pid();"
psql -U $POSTGRES_USER -c "ALTER DATABASE $DATABASE_NAME RENAME TO $NEW_DATABASE_NAME;"
