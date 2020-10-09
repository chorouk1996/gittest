#!/bin/bash


#orderer
function generateOrdererSecret(){
  ORDERER_DOMAIN=banksco.com
  ROOTPATH_ORDERER=crypto-config/ordererOrganizations/${ORDERER_DOMAIN}

  echo "root:" ${ROOTPATH_ORDERER}
  
  oc create secret generic secret-blockchain-orderer-solution2 \
	--from-file=ordererorg.ca.priv=${ROOTPATH_ORDERER}/ca/priv_sk \
	--from-file=ordererorg.tlsca.priv=${ROOTPATH_ORDERER}/tlsca/priv_sk \
	--from-file=ordererorg.orderers.ordererdomain.msp.keystore.priv=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/msp/keystore/priv_sk \
	--from-file=ordererorg.orderers.ordererdomain.tls.serverkey=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/tls/server.key \
	--from-file=ordererorg.users.admin.msp.keystore.priv=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/keystore/priv_sk \
	--from-file=ordererorg.users.admin.tls.clientkey=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/tls/client.key

  echo "Orderer creation finished successfully"
}


#org1
function generateOrg1Secret(){
  ORG1_DOMAIN=bank1.banksco.com
  ROOTPATH_ORG1=crypto-config/peerOrganizations/${ORG1_DOMAIN}
  PEER0=peer0
  PEER1=peer1
  USER1=user1
  USER1_UP=User1

  echo "root:" ${ROOTPATH_ORG1}
  
  oc create secret generic secret-blockchain-org1-solution2 \
	--from-file=peerorg.orgdomain1.ca.priv=${ROOTPATH_ORG1}/ca/priv_sk \
	--from-file=peerorg.orgdomain1.tlsca.priv=${ROOTPATH_ORG1}/tlsca/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.keystore.priv=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.serverkey=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.keystore.priv=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.serverkey=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.users.admin.msp.keystore.priv=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientkey=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/tls/client.key \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.keystore.priv=${ROOTPATH_ORG1}/users/${USER1_UP}@${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientkey=${ROOTPATH_ORG1}/users/${USER1_UP}@${ORG1_DOMAIN}/tls/client.key
	
  
    echo "Org1 creation finished successfully"
}

#org2
function generateOrg2Secret(){
  ORG2_DOMAIN=bank2.banksco.com
  ROOTPATH_ORG2=crypto-config/peerOrganizations/${ORG2_DOMAIN}
  PEER2=peer2
  PEER3=peer3
  USER1=user1
  USER1_UP=User1

  echo "root:" ${ROOTPATH_ORG2}
  
  oc create secret generic secret-blockchain-org2-solution2 \
	--from-file=peerorg.orgdomain1.ca.priv=${ROOTPATH_ORG2}/ca/priv_sk \
	--from-file=peerorg.orgdomain1.tlsca.priv=${ROOTPATH_ORG2}/tlsca/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.keystore.priv=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.serverkey=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.keystore.priv=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.serverkey=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.users.admin.msp.keystore.priv=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientkey=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/tls/client.key \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.keystore.priv=${ROOTPATH_ORG2}/users/${USER1_UP}@${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientkey=${ROOTPATH_ORG2}/users/${USER1_UP}@${ORG2_DOMAIN}/tls/client.key
	
  
    echo "Org2 creation finished successfully"
}


###########################
# main
###########################
cd /fabric

generateOrdererSecret
generateOrg1Secret
generateOrg2Secret

