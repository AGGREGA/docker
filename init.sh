#!/bin/bash

ID_RSA=".ssh/id_rsa.pub";
DIVIDER="###################################"
if [ ! -f "$ID_RSA" ]; then
  cp ~/.ssh/* .ssh
  echo $DIVIDER;
  echo "ssh keys copied from ~/.ssh/* to .ssh";
  echo $DIVIDER;
  echo $DIVIDER;
  echo "Add git as trusted";
  ssh-keyscan -H github.com >> ~/.ssh/known_hosts
  echo $DIVIDER;
  exit;
fi
INSTALL=$1
if [ "$INSTALL" == 'install' ]; then
  IRONFORGE='packages/aggrega/ironforge'
  if [ ! -d "$IRONFORGE" ]; then
    git clone git@github.com:AGGREGA/IronforgePkg.git ./packages/aggrega/ironforge
  fi
  BELIT='packages/aggrega/belit'
  if [ ! -d "$BELIT" ]; then
    git clone git@github.com:AGGREGA/belit.git ./packages/aggrega/belit
  fi
  BELIT2='packages/aggrega/belit2'
  if [ ! -d "$BELIT2" ]; then
    git clone git@github.com:AGGREGA/belit2.git ./packages/aggrega/belit2
  fi
  HERMES='packages/aggrega/hermes'
  if [ ! -d "$HERMES" ]; then
    git clone git@github.com:AGGREGA/hermes-pkg.git ./packages/aggrega/hermes
  fi
  BIFROST='packages/aggrega/bifrost'
  if [ ! -d "$BIFROST" ]; then
    git clone git@github.com:AGGREGA/bifrost-pkg.git ./packages/aggrega/bifrost
  fi
  BISC8='packages/aggrega/bisc8'
  if [ ! -d "$BISC8" ]; then
    git clone git@github.com:AGGREGA/bisc8-pkg.git ./packages/aggrega/bisc8
  fi
  LOKI='packages/aggrega/loki'
  if [ ! -d "$LOKI" ]; then
    git clone git@github.com:AGGREGA/loki-pkg.git ./packages/aggrega/loki
  fi
  TOTH='packages/aggrega/toth'
  if [ ! -d "$TOTH" ]; then
    git clone git@github.com:AGGREGA/toth.git ./packages/aggrega/toth
  fi
  WATCHMEN='packages/aggrega/watchmen'
  if [ ! -d "$WATCHMEN" ]; then
    git clone git@github.com:AGGREGA/watchmen.git ./packages/aggrega/watchmen
  fi
  SESH='packages/aggrega/sesh'
  if [ ! -d "$SESH" ]; then
    git clone git@github.com:AGGREGA/sesh.git ./packages/aggrega/sesh
  fi
  HERMES_BACKEND='projects/Hermes-backend'
  if [ ! -d "$HERMES_BACKEND" ]; then
    git clone git@github.com:AGGREGA/Hermes-backend.git ./projects/Hermes-backend
    mkdir -p projects/Hermes-backend/packages
    ln -s ../../../packages/aggrega projects/Hermes-backend/packages/aggrega
  fi
  HERMES_FRONT='projects/Hermes-front'
  if [ ! -d "$HERMES_BACKEND" ]; then
    git clone git@github.com:AGGREGA/Hermes-front.git ./projects/Hermes-front
    mkdir -p projects/Hermes-front/packages
    ln -s ../../../packages/aggrega projects/Hermes-front/packages/aggrega
  fi
  HERMES_PRINT='projects/Hermes-print'
  if [ ! -d "$HERMES_PRINT" ]; then
    git clone git@github.com:AGGREGA/node-print-page.git ./projects/Hermes-print
  fi
  HERMES_HEATMAP='projects/Hermes-heatmap'
  if [ ! -d "$HERMES_HEATMAP" ]; then
    git clone git@github.com:AGGREGA/node-heatmap.git ./projects/Hermes-heatmap
  fi
  BISC8='projects/Bisc8'
  if [ ! -d "$BISC8" ]; then
    git clone git@github.com:AGGREGA/bisc8-front.git ./projects/Bisc8
    mkdir -p projects/Bisc8/packages
    ln -s ../../../packages/aggrega projects/Hermes-front/packages/aggrega
  fi
fi





