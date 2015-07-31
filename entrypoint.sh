#!/bin/bash
export ENV_FILE=/etc/php5/fpm/pool.d/www-environment.conf
echo '[www]' > $ENV_FILE

for var in $PHP_ENV_VARS; do
  echo "env[$var]=\$$var" >> $ENV_FILE
done

/usr/sbin/php5-fpm --nodaemonize
