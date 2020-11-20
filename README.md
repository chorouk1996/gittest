bouygues poc

###Creation des channels (notes)
   
docker exec -it cliBank1 sh   
peer channel create -o ordererTF1.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA  
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK1_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK1_PRADDR   
peer channel join -b bankscochannel.block   
   
docker exec -it cliBank2 sh   
peer channel create -o ordererMetier.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA  
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK2_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK2_PRADDR   
peer channel join -b bankscochannel.block   
   
docker exec -it cliBank3 sh   
peer channel create -o ordererJuridique.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA   
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK3_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK3_PRADDR   
peer channel join -b bankscochannel.block   
   