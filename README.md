bouygues poc

###Creation des channels (notes)
   
docker exec -it cliBank1 sh   
peer channel create -o ordererTF1.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA   
   
docker exec -it cliBank2 sh   
peer channel create -o ordererMetier.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA  
   
docker exec -it cliBank3 sh   
peer channel create -o ordererJuridique.banksco.com:7050  -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_TLS_CA   
   