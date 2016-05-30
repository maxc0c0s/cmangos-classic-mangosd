#!/bin/bash

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version'
  exit
fi

cd /tmp
if [ ! -f "./cmangos/bin/mangosd" ]
then
  echo "extracting cmangos-classic-$CMANGOS_VERSION.tar.gz"
  tar -xvf cmangos-classic-$CMANGOS_VERSION.tar.gz
  echo "moving 1.12.1-client-extracted-files.tar.gz in cmangos/bin"
  mv 1.12.1-client-extracted-files.tar.gz cmangos/bin
  cd /tmp/cmangos/bin
  tar -xvf 1.12.1-client-extracted-files.tar.gz
  # TODO So ugly...replace this sleep by a check to make sure the db-filler is over...maybe when it stops pinging.
  sleep 30
fi

cd /tmp/cmangos/bin
/tmp/wait-for-it.sh db:3306
./mangosd -c /etc/cmangos-classic/mangosd.conf -a /etc/cmangos-classic/ahbot.conf

exec $@
