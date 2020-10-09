#!/bin/sh

cd /fabric-secret

if [ -d "crypto-config" ]; then
  rm -Rf crypto-config
else
  mkdir crypto-config
fi

cryptogen generate --config=./crypto-config.yaml

cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/orderer.banksco.com/msp/admincerts/

  # copying missing admincert in different MSP from admin signcert for bank1.banksco
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/peers/peer0.bank1.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/peers/peer1.bank1.banksco.com/msp/admincerts/

  # copying missing admincert in different MSP from admin signcert for bank2.banksco
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peer0.bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peer1.bank2.banksco.com/msp/admincerts/

cp base/fabric-ca-server-config-bank1-banksco.yaml crypto-config/peerOrganizations/bank1.banksco.com/ca/fabric-ca-server-config.yaml
cp base/fabric-ca-server-config-bank2-banksco.yaml crypto-config/peerOrganizations/bank2.banksco.com/ca/fabric-ca-server-config.yaml



if [ -d "channel-artifacts" ]; then
  rm channel-artifacts/*
else
  mkdir channel-artifacts
fi

export FABRIC_CFG_PATH=/fabric-secret

configtxgen -profile BanksCoOrdererGenesis -outputBlock ./channel-artifacts/genesis.block -channelID bankscochannel-sys 
configtxgen -profile BanksCoChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID bankscochannel 
configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank1MSPanchors.tx -channelID bankscochannel -asOrg Bank1MSP 
configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank2MSPanchors.tx -channelID bankscochannel -asOrg Bank2MSP 

#Note : needed instruction! otherwise the pod immediately goes in "Completed" status.
#		If the Pod is completed, there's nothing running you can exec into.
sleep 24h 

