#!/bin/sh
peer channel fetch newest $CHANNEL_NAME.block -o orderer:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_TLS_CA

#peer channel fetch 0 $CHANNEL_NAME.block -c $CHANNEL_NAME --orderer orderer:7050 --tls --cafile $ORDERER_TLS_CA

export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_BANK2_TLS_CA
export CORE_PEER_ADDRESS=$PEER2_BANK2_PRADDR
peer channel join -b bankscochannel.block
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER3_BANK2_TLS_CA
export CORE_PEER_ADDRESS=$PEER3_BANK2_PRADDR
peer channel join -b bankscochannel.block
#peer channel update -o orderer:7050 -c $CHANNEL_NAME -f /fabric/channel-artifacts/Bank2MSPanchors.tx --tls --cafile $ORDERER_TLS_CA

