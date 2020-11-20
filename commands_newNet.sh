#!/bin/sh
cd ../fabric
cryptogen generate --config=./crypto-config.yaml
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererTF1.banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererMetier.banksco.com/msp/admincerts/
cp -R crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/* crypto-config/ordererOrganizations/banksco.com/orderers/ordererJuridique.banksco.com/msp/admincerts/

# copying missing admincert in different MSP from admin signcert for bank1.banksco
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank1.banksco.com/peers/peerTF1.bank1.banksco.com/msp/admincerts/

# copying missing admincert in different MSP from admin signcert for bank2.banksco
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peerMetier.bank2.banksco.com/msp/admincerts/

# copying missing admincert in different MSP from admin signcert for bank3.banksco
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/admincerts/
cp -R crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/signcerts/* crypto-config/peerOrganizations/bank2.banksco.com/peers/peerJuridique.bank2.banksco.com/msp/admincerts/


cp base/fabric-ca-server-config-bank1-banksco.yaml crypto-config/peerOrganizations/bank1.banksco.com/ca/fabric-ca-server-config.yaml
cp base/fabric-ca-server-config-bank2-banksco.yaml crypto-config/peerOrganizations/bank2.banksco.com/ca/fabric-ca-server-config.yaml
cp base/fabric-ca-server-config-bank3-banksco.yaml crypto-config/peerOrganizations/bank3.banksco.com/ca/fabric-ca-server-config.yaml


configtxgen -profile BanksCoOrdererGenesis -channelID bankscochannel-sys -outputBlock ./channel-artifacts/genesis.block 
configtxgen -profile BanksCoChannel -outputCreateChannelTx   ./channel-artifacts/channel.tx -channelID bankscochannel 
configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank1MSPanchors.tx -channelID bankscochannel -asOrg Bank1MSP 
configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank2MSPanchors.tx -channelID bankscochannel -asOrg Bank2MSP 
configtxgen -profile BanksCoChannel -outputAnchorPeersUpdate ./channel-artifacts/Bank3MSPanchors.tx -channelID bankscochannel -asOrg Bank3MSP 

sleep 24h 

