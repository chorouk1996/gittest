#!/bin/bash


#orderer
function generateOrdererSecret(){
  ORDERER_DOMAIN=banksco.com
  ROOTPATH_ORDERER=crypto-config/ordererOrganizations/${ORDERER_DOMAIN}

  echo "root:" ${ROOTPATH_ORDERER}
  
  oc create secret generic secret-blockchain-orderer-solution2 \
	--from-file=ordererorg.msp.admincerts=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/signcerts/Admin@${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.orderers.ordererdomain.msp.admincerts=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/signcerts/Admin@${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.users.admin.msp.admincerts=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/signcerts/Admin@${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.users.admin.msp.signcerts=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/signcerts/Admin@${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.ca.priv=${ROOTPATH_ORDERER}/ca/priv_sk \
	--from-file=ordererorg.ca.pem=${ROOTPATH_ORDERER}/ca/ca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.tlsca.priv=${ROOTPATH_ORDERER}/tlsca/priv_sk \
	--from-file=ordererorg.tlsca.pem=${ROOTPATH_ORDERER}/tlsca/tlsca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.msp.cacerts.pem=${ROOTPATH_ORDERER}/msp/cacerts/ca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.msp.tlscacerts.pem=${ROOTPATH_ORDERER}/msp/tlscacerts/tlsca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.orderers.ordererdomain.msp.cacerts.priv=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/msp/cacerts/ca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.orderers.ordererdomain.msp.keystore.priv=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/msp/keystore/priv_sk \
	--from-file=ordererorg.orderers.ordererdomain.msp.signcerts.pem=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/msp/signcerts/orderer.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.orderers.ordererdomain.msp.tlscacerts.pem=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/msp/tlscacerts/tlsca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.orderers.ordererdomain.tls.cacrt=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/tls/ca.crt \
	--from-file=ordererorg.orderers.ordererdomain.tls.servercrt=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/tls/server.crt \
	--from-file=ordererorg.orderers.ordererdomain.tls.serverkey=${ROOTPATH_ORDERER}/orderers/orderer.${ORDERER_DOMAIN}/tls/server.key \
	--from-file=ordererorg.users.admin.msp.cacerts.pem=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/cacerts/ca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.users.admin.msp.keystore.priv=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/keystore/priv_sk \
	--from-file=ordererorg.users.admin.msp.tlscacerts.pem=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/msp/tlscacerts/tlsca.${ORDERER_DOMAIN}-cert.pem \
	--from-file=ordererorg.users.admin.tls.cacrt=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/tls/ca.crt \
	--from-file=ordererorg.users.admin.tls.clientcrt=${ROOTPATH_ORDERER}/users/Admin@${ORDERER_DOMAIN}/tls/client.crt \
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

  echo "root:" ${ROOTPATH_ORG1}
  
  oc create secret generic secret-blockchain-org1-solution2 \
	--from-file=peerorg.orgdomain1.msp.admincerts=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/signcerts/Admin@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.admincerts=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/signcerts/Admin@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.admincerts=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/signcerts/Admin@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.admincerts=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/signcerts/Admin@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.signcerts=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/signcerts/Admin@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.admincerts=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/msp/signcerts/${USER1}@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.signcerts=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/msp/signcerts/${USER1}@${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.ca.priv=${ROOTPATH_ORG1}/ca/priv_sk \
	--from-file=peerorg.orgdomain1.ca.pem=${ROOTPATH_ORG1}/ca/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.tlsca.priv=${ROOTPATH_ORG1}/tlsca/priv_sk \
	--from-file=peerorg.orgdomain1.tlsca.pem=${ROOTPATH_ORG1}/tlsca/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.msp.cacerts.pem=${ROOTPATH_ORG1}/msp/cacerts/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.msp.tlscacerts.pem=${ROOTPATH_ORG1}/msp/tlscacerts/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.cacerts.priv=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/msp/cacerts/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.keystore.priv=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.signcerts.pem=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/msp/signcerts/${PEER0}.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.tlscacerts.pem=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/msp/tlscacerts/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.cacrt=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.servercrt=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/tls/server.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.serverkey=${ROOTPATH_ORG1}/peers/${PEER0}.${ORG1_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.cacerts.priv=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/msp/cacerts/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.keystore.priv=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.signcerts.pem=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/msp/signcerts/${PEER1}.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.tlscacerts.pem=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/msp/tlscacerts/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.cacrt=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.servercrt=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/tls/server.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.serverkey=${ROOTPATH_ORG1}/peers/${PEER1}.${ORG1_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.users.admin.msp.cacerts.pem=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/cacerts/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.keystore.priv=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.admin.msp.tlscacerts.pem=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/msp/tlscacerts/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.tls.cacrt=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientcrt=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/tls/client.crt \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientkey=${ROOTPATH_ORG1}/users/Admin@${ORG1_DOMAIN}/tls/client.key \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.cacerts.pem=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/msp/cacerts/ca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.keystore.priv=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.tlscacerts.pem=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/msp/tlscacerts/tlsca.${ORG1_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.cacrt=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientcrt=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/tls/client.crt \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientkey=${ROOTPATH_ORG1}/users/${USER1}@${ORG1_DOMAIN}/tls/client.key
	
  
    echo "Org1 creation finished successfully"
}

#org2
function generateOrg2Secret(){
  ORG2_DOMAIN=bank2.banksco.com
  ROOTPATH_ORG2=crypto-config/peerOrganizations/${ORG2_DOMAIN}
  PEER0=peer0
  PEER1=peer1
  USER1=user1

  echo "root:" ${ROOTPATH_ORG2}
  
  oc create secret generic secret-blockchain-org2-solution2 \
	--from-file=peerorg.orgdomain1.msp.admincerts=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/signcerts/Admin@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.admincerts=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/signcerts/Admin@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.admincerts=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/signcerts/Admin@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.admincerts=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/signcerts/Admin@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.signcerts=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/signcerts/Admin@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.admincerts=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/msp/signcerts/${USER1}@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.signcerts=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/msp/signcerts/${USER1}@${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.ca.priv=${ROOTPATH_ORG2}/ca/priv_sk \
	--from-file=peerorg.orgdomain1.ca.pem=${ROOTPATH_ORG2}/ca/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.tlsca.priv=${ROOTPATH_ORG2}/tlsca/priv_sk \
	--from-file=peerorg.orgdomain1.tlsca.pem=${ROOTPATH_ORG2}/tlsca/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.msp.cacerts.pem=${ROOTPATH_ORG2}/msp/cacerts/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.msp.tlscacerts.pem=${ROOTPATH_ORG2}/msp/tlscacerts/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.cacerts.priv=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/msp/cacerts/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.keystore.priv=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.signcerts.pem=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/msp/signcerts/${PEER0}.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.msp.tlscacerts.pem=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/msp/tlscacerts/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.cacrt=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.servercrt=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/tls/server.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER0}.tls.serverkey=${ROOTPATH_ORG2}/peers/${PEER0}.${ORG2_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.cacerts.priv=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/msp/cacerts/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.keystore.priv=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.signcerts.pem=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/msp/signcerts/${PEER1}.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.msp.tlscacerts.pem=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/msp/tlscacerts/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.cacrt=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.servercrt=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/tls/server.crt \
	--from-file=peerorg.orgdomain1.peers.${PEER1}.tls.serverkey=${ROOTPATH_ORG2}/peers/${PEER1}.${ORG2_DOMAIN}/tls/server.key \
	--from-file=peerorg.orgdomain1.users.admin.msp.cacerts.pem=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/cacerts/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.msp.keystore.priv=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.admin.msp.tlscacerts.pem=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/msp/tlscacerts/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.admin.tls.cacrt=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientcrt=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/tls/client.crt \
	--from-file=peerorg.orgdomain1.users.admin.tls.clientkey=${ROOTPATH_ORG2}/users/Admin@${ORG2_DOMAIN}/tls/client.key \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.cacerts.pem=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/msp/cacerts/ca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.keystore.priv=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/msp/keystore/priv_sk \
	--from-file=peerorg.orgdomain1.users.${USER1}.msp.tlscacerts.pem=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/msp/tlscacerts/tlsca.${ORG2_DOMAIN}-cert.pem \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.cacrt=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/tls/ca.crt \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientcrt=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/tls/client.crt \
	--from-file=peerorg.orgdomain1.users.${USER1}.tls.clientkey=${ROOTPATH_ORG2}/users/${USER1}@${ORG2_DOMAIN}/tls/client.key
	
  
    echo "Org2 creation finished successfully"
}


###########################
# main
###########################
generateOrdererSecret
generateOrg1Secret
generateOrg2Secret

