#!/bin/bash

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version'
  exit
fi

cd /tmp
tar -xvf cmangos-classic-$CMANGOS_VERSION.tar.gz
mv 1.12.1-client-extracted-files.tar.gz cmangos/bin
cd cmangos/bin
tar -xvf 1.12.1-client-extracted-files.tar.gz

/tmp/wait-for-it.sh db:3306
# TODO So ugly...replace this sleep by a check to make sure the db-filler is over...maybe when it stops pinging.
sleep 30
./mangosd -c /etc/cmangos-classic/mangosd.conf -a /etc/cmangos-classic/ahbot.conf

exec $@
