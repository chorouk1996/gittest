#!/bin/bash

#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

# Aide
function printHelp () {
  echo "Usage: "
  echo "  $1 -m gen_pki|gen_cha"
  echo "  $1 -h|--help (print this message)"
  echo "    -m <mode> - one of 'up', 'down', 'restart' or 'generate'"
  echo "      - 'gen_pki' - generate required certificates and genesis block"
  echo "      - 'gen_cha' - generate required genesis blocks and transactions"
}

# On crée les certificats X509 grace à l'outil cryptogen. 
# L'outil cryptogen utilise le fichier `crypto-config.yaml` qui contient la définition des organisations de ce TP.
# Docs :
# + cryptogen : http://hyperledger-fabric.readthedocs.io/en/release-1.0/build_network.html#crypto-generator
function generateCerts (){
  if [ -d "crypto-config" ]; then
    rm -Rf crypto-config
  else
    mkdir crypto-config
  fi
  
  echo "Folder \"crypto-config\" created successfully"
  
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && cryptogen generate --config=./crypto-config.yaml"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate certificates..."
    exit 1
  fi
  
  # copying missing admincert in different MSP from admin signcert for banksco
  # ordererorg.users.admin.msp.signcert.pem
  # ordererorg.users.admin.msp.signcert.pem -> ordererorg.msp.admincerts
  # ordererorg.users.admin.msp.signcert.pem -> ordererorg.users.admin.msp.admincerts
  # ordererorg.users.admin.msp.signcert.pem -> ordererorg.orderers.ordererdomain.msp.admincerts
  cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/msp/admincerts/
  cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/admincerts/
  #cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/orderer0.banksco.com/msp/admincerts/
  #cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/orderer1.banksco.com/msp/admincerts/
  #cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/orderer2.banksco.com/msp/admincerts/
  cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererTF1.banksco.com/msp/admincerts/
  cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererMetier.banksco.com/msp/admincerts/
  cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererJuridique.banksco.com/msp/admincerts/

  # copying missing admincert in different MSP from admin signcert for bank1.banksco
  # peerorg.org1.users.admin.msp.signcert.pem
  # peerorg.org1.users.admin.msp.signcert.pem -> peerorg.org1.msp.admincerts
  # peerorg.org1.users.admin.msp.signcert.pem -> peerorg.org1.users.admin.msp.admincerts
  # peerorg.org1.users.admin.msp.signcert.pem -> peerorg.org1.peers.peer0.msp.admincerts
  cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/admincerts/
  #cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/peers/peer0.bank1.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/peers/peerTF1.bank1.banksco.com/msp/admincerts/

  # copying missing admincert in different MSP from admin signcert for bank2.banksco
  # peerorg.org2.users.admin.msp.signcert.pem
  # peerorg.org2.users.admin.msp.signcert.pem -> peerorg.org2.msp.admincerts
  # peerorg.org2.users.admin.msp.signcert.pem -> peerorg.org2.users.admin.msp.admincerts
  # peerorg.org2.users.admin.msp.signcert.pem -> peerorg.org2.peers.peer0.msp.admincerts
  cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/admincerts/
  #cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peer0.bank2.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peerMetier.bank2.banksco.com/msp/admincerts/

  # copying missing admincert in different MSP from admin signcert for bank3.banksco
  # peerorg.org3.users.admin.msp.signcert.pem
  # peerorg.org3.users.admin.msp.signcert.pem -> peerorg.org3.msp.admincerts
  # peerorg.org3.users.admin.msp.signcert.pem -> peerorg.org3.users.admin.msp.admincerts
  # peerorg.org3.users.admin.msp.signcert.pem -> peerorg.org3.peers.peer0.msp.admincerts
  cp -R crypto-config/peerOrganizations/bank3.banksco.com/users/Admin@bank3.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank3.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank3.banksco.com/users/Admin@bank3.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank3.banksco.com/users/Admin@bank3.banksco.com/msp/admincerts/
  #cp -R crypto-config/peerOrganizations/bank3.banksco.com/users/Admin@bank3.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank3.banksco.com/peers/peer0.bank3.banksco.com/msp/admincerts/
  cp -R crypto-config/peerOrganizations/bank3.banksco.com/users/Admin@bank3.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank3.banksco.com/peers/peerJuridique.bank3.banksco.com/msp/admincerts/


  # sudo chown -R $UID crypto-config
  chown -R $UID crypto-config

  cp base/fabric-ca-server-config-bank1.banksco.yaml crypto-config/peerOrganizations/bank1.banksco.com/ca/fabric-ca-server-config.yaml
  cp base/fabric-ca-server-config-bank2.banksco.yaml crypto-config/peerOrganizations/bank2.banksco.com/ca/fabric-ca-server-config.yaml
  cp base/fabric-ca-server-config-bank3.banksco.yaml crypto-config/peerOrganizations/bank3.banksco.com/ca/fabric-ca-server-config.yaml
}

# Generation du "genesis block" de l'orderer ainsi que la transaction de configuration du channel et
# les transactions des peers d'ancrage (anchor peers) grace à l'outil configtxgen.
# Docs :
# + configtxgen : http://hyperledger-fabric.readthedocs.io/en/release-1.0/build_network.html#configuration-transaction-generator
# 				  https://hyperledger-fabric.readthedocs.io/en/release-1.4/commands/configtxgen.html
function generateChannelArtifacts() {
  if [ -d "channel-artifacts" ]; then
    rm channel-artifacts/*
  else
    mkdir channel-artifacts
  fi

  # Generating Orderer Genesis block
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && export FABRIC_CFG_PATH=/exchntw ; configtxgen -profile BanksCoOrdererGenesis -channelID bankscochannel-sys -outputBlock ./channel-artifacts/genesis.block"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate orderer genesis block..."
    exit 1
  fi

  # Generating channel configuration transaction 'channel.tx'
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && export FABRIC_CFG_PATH=/exchntw ; configtxgen -profile BanksCoChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID bankscochannel"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate channel configuration transaction..."
    exit 1
  fi

  # Generating anchor peer update for Bank1MSP
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && export FABRIC_CFG_PATH=/exchntw ; configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank1MSPanchors.tx -channelID bankscochannel -asOrg Bank1MSP"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate anchor peer update for Bank1MSP..."
    exit 1
  fi

  # Generating anchor peer update for Bank2MSP
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && export FABRIC_CFG_PATH=/exchntw ; configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank2MSPanchors.tx -channelID bankscochannel -asOrg Bank2MSP"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate anchor peer update for Bank2MSP..."
    exit 1
  fi

  # Generating anchor peer update for Bank3MSP
  docker run -it --rm --mount type=bind,src=`pwd`,dst=/exchntw hyperledger/fabric-tools:2.2.0 bash -c "cd /exchntw && export FABRIC_CFG_PATH=/exchntw ; configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank3MSPanchors.tx -channelID bankscochannel -asOrg Bank3MSP"
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate anchor peer update for Bank3MSP..."
    exit 1
  fi
}

export FABRIC_CFG_PATH=${PWD}

# Parse commandline args
while getopts "h?m:" opt; do
  case "$opt" in
    h|\?)
      printHelp $0
      exit 0
    ;;
    m)
        MODE=$OPTARG
        if [ "${MODE}" == "gen_pki" ]; then ## Generate PKI Artifacts
          generateCerts
        elif [ "${MODE}" == "gen_cha" ]; then ## Generate Channel Artifacts
          generateChannelArtifacts
        else
          printHelp $0
          exit 1
        fi
    ;;
  esac
done
