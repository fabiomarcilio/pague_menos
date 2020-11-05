#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " grant-access.sh <DATABASE_NAME> <USER>"
  echo
  echo " example:"
  echo "   sh /scripts/grant-access.sh meu_banco sysdba"
  echo -e "==================================${COLOR_CLEAN}"
}


DATABASE_NAME=$1
USER=$2

if [ -z $DATABASE_NAME ] || [ -z $USER ]; then
  echo -e "${COLOR_RED}Erro: Parâmetros esperados inválidos"
  example;
  exit 1;
fi

for tbl in `psql -U $POSTGRES_USER -qAt -c "select tablename from pg_tables where schemaname = 'public';" $DATABASE_NAME` ; do  psql -U $POSTGRES_USER -c "alter table \"$tbl\" owner to $USER" $DATABASE_NAME ; done
for tbl in `psql -U $POSTGRES_USER -qAt -c "select sequence_name from information_schema.sequences where sequence_schema = 'public';" $DATABASE_NAME` ; do  psql -U $POSTGRES_USER -c "alter sequence \"$tbl\" owner to $USER" $DATABASE_NAME ; done
for tbl in `psql -U $POSTGRES_USER -qAt -c "select table_name from information_schema.views where table_schema = 'public';" $DATABASE_NAME` ; do  psql -U $POSTGRES_USER -c "alter view \"$tbl\" owner to $USER" $DATABASE_NAME ; done