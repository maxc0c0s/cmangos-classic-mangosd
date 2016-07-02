#!/bin/bash

MANGOS_CONFIG_FILE="/etc/cmangos-classic/mangosd.conf"
AHBOT_CONFIG_FILE="/etc/cmangos-classic/ahbot.conf"
BINARY_DIR=$1
TEMP_DIR=$2
CLIENT_EXTRACTED_FILES_PACKAGE="$TEMP_DIR/1.12.1-client-extracted-files.tar.gz" 
CLIENT_EXTRACTED_FILES_MAPS_DIR="$BINARY_DIR/maps"

if [ ! -e $CLIENT_EXTRACTED_FILES_PACKAGE ]; then
echo "$CLIENT_EXTRACTED_FILES_PACKAGE missing...The content generated by https://github.com/cmangos/mangos-classic/blob/master/contrib/extractor_binary/ExtractResources.sh must be compressed into $CLIENT_EXTRACTED_FILES_PACKAGE"
exit 1
fi
if [ ! -e $MANGOS_CONFIG_FILE ]; then
  echo "$MANGOS_CONFIG_FILE must be present...a template for this file can be found here: https://github.com/cmangos/mangos-classic/blob/master/src/mangosd/mangosd.conf.dist.in"
  exit 1
fi
if [ ! -e $AHBOT_CONFIG_FILE ]; then
  echo "$AHBOT_CONFIG_FILE must be present...a template for this file can be found here: https://github.com/cmangos/mangos-classic/blob/master/src/game/AuctionHouseBot/ahbot.conf.dist.in"
  exit 1
fi
if [ ! -e $BINARY_DIR/mangosd ]; then
  echo "$BINARY_DIR/mangosd must be present...this file comes from $BINARY_PACKAGE"
  exit 1
fi

if [  ! -d $CLIENT_EXTRACTED_FILES_MAPS_DIR ]; then
  echo "extracting $CLIENT_EXTRACTED_FILES_PACKAGE in $BINARY_DIR"
  tar -xf $CLIENT_EXTRACTED_FILES_PACKAGE -C $BINARY_DIR
fi

cd $BINARY_DIR
./mangosd -c $MANGOS_CONFIG_FILE -a $AHBOT_CONFIG_FILE
