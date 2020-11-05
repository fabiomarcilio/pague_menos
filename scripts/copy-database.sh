  #!/bin/bash
  COLOR_RED='\033[1;31m';
  COLOR_GREEN='\033[1;32m';
  COLOR_BLUE='\033[1;36m';
  COLOR_YELLOW='\033[1;49;33m';
  COLOR_DARK_GRAY='\033[1;90m';
  COLOR_CLEAN='\033[0m';


  print() {
    echo
    echo -e "${COLOR_YELLOW}$@${COLOR_CLEAN}"
  }

  execute() {
    _COMMAND=$@
    print "time $_COMMAND"
    echo -e $COLOR_GREEN$(date)$COLOR_CLEAN
    time eval "$_COMMAND"
    if [ $? -ne 0 ]; then
        exit 1
    fi
  }

  example() {
    echo -e "${COLOR_DARK_GRAY}=================================="
    echo "How to use it:"
    echo "	.copy-postgresql-database <DATABASE> "
    echo
    echo " example:"
    echo "	.copy-postgresql-database card-445"
    echo "	.copy-postgresql-database staging"
    echo "	.copy-postgresql-database banco-teste"
    echo -e "==================================${COLOR_CLEAN}"
  }

  QTD_PARAMS=$#

  validateParams() {
    ERROR=true

    if [ $QTD_PARAMS -ne 1 ]; then
      print $COLOR_RED"Illegal number of parameters"
    else
      ERROR=false
    fi

    [ $ERROR == true ] && example && exit 1
  }

  DB_NAME=$1

  validateParams

  # Substituindo "-" por "_"
  if echo "$DB_NAME" | egrep '-' >/dev/null; then
    DB_NAME=${DB_NAME/-/_}
  fi

  function verifyIfBaseExist() {
    DB_NAME_EXIST="$(sudo docker exec postgresql psql -U postgres -c '\l' | grep -w -o $DB_NAME)"
    if [ ! "$DB_NAME_EXIST" ]; then
      print $COLOR_RED"Database $DB_NAME not found"$COLOR_CLEAN
      exit 1
    else
      killDatabase
    fi
  }

  function killDatabase() {
    print "sudo docker exec postgresql ./scripts/kill-connetion.sh $DB_NAME"
    sudo docker exec postgresql ./scripts/kill-connection.sh $DB_NAME
  }

  function copyDatabaseCache() {
    NEW_CACHE_DATABASE="CREATE DATABASE tmp_$DB_NAME with template $DB_NAME;"

    print "sudo docker exec postgresql psql -U postgres -c '$NEW_CACHE_DATABASE'"
    sudo docker exec postgresql psql -U postgres -c "$NEW_CACHE_DATABASE"
  }

  verifyIfBaseExist
  copyDatabaseCache
