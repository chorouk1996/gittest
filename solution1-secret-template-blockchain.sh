#!/bin/bash

############################
# ORDERER
############################

# copy "users/admin/msp/signcerts/*" to different places
# NOTE : ">" EREASE all the content of the file and writes from the beginning
# 		 ">>" appends content from end of file
# 		 "-n" with "echo" says not to add a new line
echo -n "  ordererorg.users.admin.msp.signcerts: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/Admin@banksco.com-cert.pem | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.msp.admincerts: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/Admin@banksco.com-cert.pem | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.users.admin.msp.admincerts: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/Admin@banksco.com-cert.pem | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.orderers.ordererdomain.msp.admincerts: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/signcerts/Admin@banksco.com-cert.pem | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

# store all the other certificates
echo -n "  ordererorg.ca.priv: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/ca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  ordererorg.tlsca.priv: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/tlsca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.orderers.ordererdomain.tls.server: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/orderers/orderer.banksco.com/tls/server.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.orderers.ordererdomain.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/orderers/orderer.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.users.admin.tls.client: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/tls/client.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  ordererorg.users.admin.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/ordererOrganizations/banksco.com/users/Admin@banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml



############################
# PEER1
############################

echo -n "  peerorg.orgdomain1.ca.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/ca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.tlsca.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/tlsca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  peerorg.orgdomain1.users.user1.tls.client: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/users/User1@bank1.banksco.com/tls/client.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.users.user1.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/users/User1@bank1.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.users.admin.tls.client: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/tls/client.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.users.admin.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/users/Admin@bank1.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  peerorg.orgdomain1.peers.peer0.tls.server: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/peers/peer0.bank1.banksco.com/tls/server.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.peers.peer0.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/peers/peer0.bank1.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.peers.peer1.tls.server: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/peers/peer1.bank1.banksco.com/tls/server.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain1.peers.peer1.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank1.banksco.com/peers/peer1.bank1.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

############################
# PEER2
############################
echo -n "  peerorg.orgdomain2.ca.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/ca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.tlsca.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/tlsca/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  peerorg.orgdomain2.users.user1.tls.client: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/users/User1@bank2.banksco.com/tls/client.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.users.user1.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/users/User1@bank2.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.users.admin.tls.client: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/tls/client.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.users.admin.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/users/Admin@bank2.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

echo -n "  peerorg.orgdomain2.peers.peer0.tls.server: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/peers/peer0.bank2.banksco.com/tls/server.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.peers.peer0.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/peers/peer0.bank2.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.peers.peer1.tls.server: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/peers/peer1.bank2.banksco.com/tls/server.key | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml
echo -n "  peerorg.orgdomain2.peers.peer1.msp.keystore.priv: " >> secret-blockchain-template.yml
cat crypto-config/peerOrganizations/bank2.banksco.com/peers/peer1.bank2.banksco.com/msp/keystore/priv_sk | tr -d '\n' >> secret-blockchain-template.yml
echo '' >> secret-blockchain-template.yml

