#!/bin/bash

PROJECT_PHP=""
PROJECT_NODE=""

function usage() {
    echo "Allowed commands"
    echo ""
    echo "--help"
    echo "--project-php=hermes | bisc8 | loki"
    echo "--project-node=print | heatmap "
    echo ""
}

while [ ! "$1" == "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --project-node)
            PROJECT_NODE=$VALUE
            ;;
        --project-php)
            PROJECT_PHP=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

if [ "$PROJECT_NODE" == "print" ] || [ "$PROJECT_NODE" == "heatmap" ] ; then
  echo "PROJECT NODE is $PROJECT_NODE";
  cd /var/www/project/current;
  npm install;
  pm2 start process.json;
  nginx -g 'daemon off;';
  status=$?
  if [ $status -ne 0 ]; then
    echo "Failed to start nginx: $status"
    exit $status
  fi
else
  echo "Failed find project node: $PROJECT_NODE"
fi

if [ ! -z $PROJECT_PHP ]; then
  echo "PROJECT PHP is $PROJECT_PHP";
  service cron restart
  service nginx restart;
  status=$?
  if [ $status -ne 0 ]; then
      echo "Failed to start nginx: $status"
  fi
  service supervisor stop;
  status=$?
  if [ $status -ne 0 ]; then
      echo "Failed to stop supervisor: $status"
  fi
  service supervisor start;
  status=$?
  if [ $status -ne 0 ]; then
      echo "Failed to start supervisor: $status"
  fi
  cd /var/www/project/current;
  rm -rf storage/framework/*.lock;
  chmod 777 -R storage;
  composer install -vvv;
  sleep 15;
  su -l www-data -s /bin/bash;
  ssh-keyscan -H github.com >> /var/www/.ssh/known_hosts
  php artisan config:cache;
  php artisan migrate;
  if [ "$PROJECT_PHP" == "hermes" ]; then
     service php8.0-fpm restart
     status=$?
     if [ $status -ne 0 ]; then
         echo "Failed to start php fpm to hermes: $status"
     fi
     php artisan db:seed --class=Aggrega\\Hermes\\Database\\Seeds\\DataStartSeed;
  elif [ "$PROJECT_PHP" == "bisc8" ]; then
      service php8.0-fpm restart
      status=$?
      if [ $status -ne 0 ]; then
         echo "Failed to start php fpm to bisc8: $status"
      fi
      php artisan db:seed --class=Aggrega\\Bisc8\\Database\\Seeds\\DataStartSeed;
  elif [ "$PROJECT_PHP" == "loki" ]; then
      service php8.0-fpm restart
      status=$?
      if [ $status -ne 0 ]; then
         echo "Failed to start php fpm to hermes: $status"
      fi
      php artisan db:seed --class=Aggrega\\Loki\\Database\\Seeds\\DataStartSeed;
  else
     echo "Failed find project php: $PROJECT_NODE"
  fi
else
  echo "Failed find project php: $PROJECT_NODE"
fi

while true; do
  echo "Running process";
  if [ ! "$PROJECT_PHP" == "" ]; then
     su www-data -s /bin/bash -c "php /var/www/project/current/artisan  schedule:run" >> /dev/null 2>&1
  fi
  sleep 60
done