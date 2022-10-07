#!/bin/bash

PROJECT=""
PACKAGE=""
INSTALL_ALL=""

function usage() {
    echo "Allowed commands"
    echo ""
    echo "--help"
    echo "--install-all=true "
    echo "--project=hermes | bisc8 | loki | octaflow"
    echo "--package=ironforge | hermes | bisc8 | belit | beli2 | loki | core-octaflow | campaign-octaflow"
    echo ""
}

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
fi

while [ ! "$1" == "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --project)
            PROJECT=$VALUE
            ;;
          --install-all)
            INSTALL_ALL=$VALUE
            ;;
        --package)
            PACKAGE=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

###PACKAGES
if [ "$PACKAGE" == "ironforge" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  IRONFORGE='packages/aggrega/ironforge'
  if [ ! -d "$IRONFORGE" ]; then
    git clone git@github.com:AGGREGA/IronforgePkg.git ./packages/aggrega/ironforge
  fi
fi

if [ "$PACKAGE" == "belit" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  BELIT='packages/aggrega/belit'
  if [ ! -d "$BELIT" ]; then
    git clone git@github.com:AGGREGA/belit.git ./packages/aggrega/belit
  fi
fi

if [ "$PACKAGE" == "belit2" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  BELIT2='packages/aggrega/belit2'
  if [ ! -d "$BELIT2" ]; then
    git clone git@github.com:AGGREGA/IronforgePkg.git ./packages/aggrega/belit2
  fi
fi

if [ "$PACKAGE" == "hermes" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  HERMES='packages/aggrega/hermes'
  if [ ! -d "$HERMES" ]; then
    git clone git@github.com:AGGREGA/hermes-pkg.git ./packages/aggrega/hermes
  fi
fi

if [ "$PACKAGE" == "bisc8" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  BISC8='packages/aggrega/bisc8'
  if [ ! -d "$BISC8" ]; then
    git clone git@github.com:AGGREGA/bisc8-pkg.git ./packages/aggrega/bisc8
  fi
fi

if [ "$PACKAGE" == "loki" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  BISC8='packages/aggrega/loki-pkg'
  if [ ! -d "$BISC8" ]; then
    git clone git@github.com:AGGREGA/loki-pkg-pkg.git ./packages/aggrega/loki-pkg
  fi
fi

if [ "$PACKAGE" == "core-octaflow" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  COF='packages/purebros/core-octaflow'
  if [ ! -d "$COF" ]; then
    git clone git@github.com:purebros/core-octaflow.git ./packages/purebros/core-octaflow
  fi
fi

if [ "$PACKAGE" == "campaign-octaflow" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  CaOF='packages/purebros/campaign-octaflow'
  if [ ! -d "$CaOF" ]; then
    git clone git@github.com:purebros/campaign-octaflow.git ./packages/purebros/campaign-octaflow
  fi
fi


###PROJECTS
if [ "$PROJECT" == "hermes" ] ||  [ "$INSTALL_ALL" == "true" ]; then
  HERMES_BACKEND='projects/Hermes-backend'
    if [ ! -d "$HERMES_BACKEND" ]; then
      git clone git@github.com:AGGREGA/Hermes-backend.git ./projects/Hermes-backend
      mkdir -p projects/Hermes-backend/packages
      ln -s ../../../packages/aggrega projects/Hermes-backend/packages/aggrega
      cp projects/Hermes-backend/.env.example projects/Hermes-backend/.env
    fi

    HERMES_FRONT='projects/Hermes-front'
      if [ ! -d "$HERMES_FRONT" ]; then
        git clone git@github.com:AGGREGA/Hermes-front.git ./projects/Hermes-front
        mkdir -p projects/Hermes-front/packages
        ln -s ../../../packages/aggrega projects/Hermes-front/packages/aggrega
        cp  projects/Hermes-front/.env.example  projects/Hermes-front/.env
      fi

    HERMES_PRINT='projects/Hermes-print'
      if [ ! -d "$HERMES_PRINT" ]; then
        git clone git@github.com:AGGREGA/node-print-page.git ./projects/Hermes-print
      fi
      HERMES_HEATMAP='projects/Hermes-heatmap'
      if [ ! -d "$HERMES_HEATMAP" ]; then
        git clone git@github.com:AGGREGA/node-heatmap.git ./projects/Hermes-heatmap
      fi
fi

if [ "$PROJECT" == "bisc8" ] ||  [ "$INSTALL_ALL" == "true" ]; then
    BISC8='projects/Bisc8'
      if [ ! -d "$BISC8" ]; then
        git clone git@github.com:AGGREGA/bisc8-front.git ./projects/Bisc8
        mkdir -p projects/Bisc8/packages
        ln -s ../../../packages/aggrega projects/Bisc8/packages/aggrega
      fi
fi

if [ "$PROJECT" == "loki" ] ||  [ "$INSTALL_ALL" == "true" ]; then
    BISC8='projects/Loki'
      if [ ! -d "$BISC8" ]; then
        git clone git@github.com:AGGREGA/loki-pkg-main.git ./projects/Loki
        mkdir -p projects/Loki/packages
        ln -s ../../../packages/aggrega projects/Loki/packages/aggrega
      fi
fi

if [ "$PROJECT" == "octaflow" ] ||  [ "$INSTALL_ALL" == "true" ]; then
    BISC8='projects/octaflow'
      if [ ! -d "$BISC8" ]; then
        git clone git@github.com:purebros/api-octaflow.git ./projects/Octaflow
        mkdir -p projects/Octaflow/packages
        ln -s ../../../packages/purebros projects/Octaflow/packages/purebros
      fi
fi





