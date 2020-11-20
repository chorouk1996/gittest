bouygues poc

### BUILD IMAGE

docker build -t fabric-newnet-alpine .  
docker tag fabric-newnet-alpine us.icr.io/bouygues-bloc-1600085663464/fabric-newnet-alpine:latest  
docker push us.icr.io/bouygues-bloc-1600085663464/fabric-newnet-alpine:latest  
(oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-newnet-alpine:latest ${PROJECT}/fabric-newnet-alpine:latest --reference-policy=local)  
oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-newnet-alpine:latest adrienmarchal-iscfrance-fr/fabric-newnet-alpine:latest --reference-policy=local  
oc apply -f template-newnet-init.yaml  
oc process  fabric-newnet-tpl  --param-file=param.env | oc create -f -  
  
  
###Creation des channels (notes)
   
docker exec -it cliBank1 sh   
peer channel create -o ordererTF1.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA  
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK1_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK1_PRADDR   
peer channel join -b bankscochannel.block   
peer channel update -o ordererTF1.banksco.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Bank1MSPanchors.tx --tls --cafile $ORDERER_TLS_CA   
   
docker exec -it cliBank2 sh   
peer channel create -o ordererMetier.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA  
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK2_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK2_PRADDR   
peer channel join -b bankscochannel.block   
peer channel update -o ordererMetier.banksco.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Bank2MSPanchors.tx --tls --cafile $ORDERER_TLS_CA   
   
docker exec -it cliBank3 sh   
peer channel create -o ordererJuridique.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA   
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK3_TLS_CA   
export CORE_PEER_ADDRESS=$PEER0_BANK3_PRADDR   
peer channel join -b bankscochannel.block   
peer channel update -o ordererJuridique.banksco.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Bank3MSPanchors.tx --tls --cafile $ORDERER_TLS_CA   
   