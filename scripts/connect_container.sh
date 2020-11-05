#!/bin/bash
COLOR_RED='\033[1;31m';
COLOR_YELLOW='\033[1;49;33m';
COLOR_DARK_GRAY='\033[1;90m';
COLOR_CLEAN='\033[0m';


example() {
  echo -e "${COLOR_DARK_GRAY}=================================="
  echo "How to use it:"
  echo " connect_container.sh <CONTAINER_NAME>"
  echo
  echo " example:"
  echo "   sh /scripts/connect_container.sh container_name"
  echo -e "==================================${COLOR_CLEAN}"
}

CONTAINER_NAME=$1

if [ -z $CONTAINER_NAME ]; then
  echo -e "${COLOR_RED}Error: Invalid parameters"
  example;
  exit 1;
fi

docker exec -it $CONTAINER_NAME bash