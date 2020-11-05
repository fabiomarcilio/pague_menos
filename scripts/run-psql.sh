#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " run-psql.sh <DATABASE_NAME>"
  echo
  echo " example:"
  echo "   sh /scripts/run-psql.sh my_database"
  echo -e "==================================${COLOR_CLEAN}"
}

DATABASE_NAME=$1

if [ -z $DATABASE_NAME ]; then
  echo -e "${COLOR_RED}Error: Invalid parameters"
  example;
  exit 1;
fi

docker exec -it postgresql bash -c "psql -U postgres $DATABASE_NAME"