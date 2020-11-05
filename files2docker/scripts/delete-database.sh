#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " delete-database.sh <DATABASE-NAME>"
  echo
  echo " example:"
  echo "   sh /scripts/delete-database.sh meu_banco"
  echo -e "==================================${COLOR_CLEAN}"
}


DB_NAME=$1

if [ -z $DB_NAME ]; then
  echo -e "${COLOR_RED}Erro: Parâmetros esperados inválidos"
  example;
  exit 1;
fi

## Mata todos os processos referente ao banco
ps -aux | grep $DB_NAME | awk '{ print $2 }' | sudo xargs kill -9

#### Mata as conexões com o banco
psql -U $POSTGRES_USER -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$DB_NAME' AND pid <> pg_backend_pid();"

#### Exclui o Banco
psql -U $POSTGRES_USER -c "DROP DATABASE $DB_NAME;"
