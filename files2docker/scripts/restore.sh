#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " restore-database.sh <FILE_SQL> <DATABASE_NAME> (optional)<ENCODING>"
  echo
  echo " example:"
  echo "   sh /scripts/restore-database.sh meu_banco.sql meu_banco (optional)WIN1252"
  echo -e "==================================${COLOR_CLEAN}"
}


FILE_SQL=$1
DATABASE_NAME=$2
ENCODING=$3

if [ -z $FILE_SQL ] || [ -z $DATABASE_NAME ]; then
  echo -e "${COLOR_RED}Erro: Parâmetros esperados inválidos"
  example;
  exit 1;
fi

if [ -z $ENCODING ]; then
  psql -U $POSTGRES_USER -c "CREATE DATABASE $DATABASE_NAME;"
else
  psql -U $POSTGRES_USER -c "CREATE DATABASE $DATABASE_NAME ENCODING "$ENCODING" LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0"
fi

sed -i "s/set_config('search_path', '', false)/set_config('search_path', 'public', false)/g" $FILE_SQL

psql -U $POSTGRES_USER -d $DATABASE_NAME -f $FILE_SQL > /dev/null
