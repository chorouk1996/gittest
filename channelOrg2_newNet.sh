#!/bin/sh

rm  /etc/hyperledger/fabric/core.yaml 
cp  /fabric/core.yaml /etc/hyperledger/fabric/
peer channel create -o ordererMetier.banksco.com:7050  -c $CHANNEL_NAME -f /fabric/channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK2_TLS_CA
export CORE_PEER_ADDRESS=$PEER0_BANK2_PRADDR
peer channel join -b bankscochannel.block
peer channel update -o ordererMetier.banksco.com:7050 -c $CHANNEL_NAME -f /fabric/channel-artifacts/Bank2MSPanchors.tx --tls --cafile $ORDERER_TLS_CA
