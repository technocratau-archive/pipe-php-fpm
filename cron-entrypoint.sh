#!/bin/bash
set -xe

CRON_FILE="/etc/cron.d/cron"
LOGGER_CMD="tee -a /var/log/cron.log"

if [ -n "`getent hosts | grep syslog`" ];
then
  LOGGER_CMD="/usr/bin/logger -u /dev/null -n syslog -P 514 -p local7.info -t cron"
fi

rm -rf $CRON_FILE
for var in $PHP_ENV_VARS; do
  echo "$var=`printenv $var`" >> $CRON_FILE
done

for crontask in "`env | grep CRONTASK_ | cut -d = -f 2-`";
do
  echo "$crontask 2>&1 | $LOGGER_CMD" >> $CRON_FILE
done

cron -f
