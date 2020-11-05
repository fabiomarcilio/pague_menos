#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " ./create_database.sh <DATABASE> "
  echo
  echo " example:"
  echo "   ./create_database.sh meu_banco"
  echo -e "==================================${COLOR_CLEAN}"
}

QTD_PARAMS=$#

function validateParams() {
  ERROR=true

  if [ $QTD_PARAMS -ne 1 ]; then
    print $COLOR_RED"Illegal number of parameters"
  else
    ERROR=false
  fi

  [ $ERROR == true ] && example && exit 1
}

DATABASE=$1

validateParams

psql -U $POSTGRES_USER -c "CREATE DATABASE $DATABASE"