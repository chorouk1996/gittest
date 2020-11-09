# Génération de la PKI (public key infrastructure) + Generation du genesis block et des transactions d'initialisation du réseau Exchange Network

## Log in

### IBM Cloud login
Log in to the Cloud IBM account 

`ibmcloud login --sso`

### IBM Cloud Cluster registry connection
Log in to the IBM Cloud Container Registry

`ibmcloud cr login`

### Log in to the Openshift Container Platform
Use the command line provided by your cluster. The command line containing key token is available in the Openshift console.

`oc login --token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --server=https://c103-e.us-south.containers.cloud.ibm.com:31319`

## Use PVC to share files over an init container

### Create the alpine image in the container registry  

#### Activate the project
Create the project if needed

 `oc new-project ${PROJECT}`

or activate the project

`oc project ${PROJECT}`

to check the active project run the command line: `oc status`

Add a role to pull image in the project

`oc policy add-role-to-user system:image-puller system:serviceaccount:${PROJECT}:default  --namespace=${PROJECT}`

Add a rule to write  in the volume 

`oc adm policy add-scc-to-user anyuid -z default`

#### Create the image locally
Build the image from the Dockerfile

`docker build -t fabric-alpine .`

#### Create the image in the registry 
Tag the image

`docker tag fabric-alpine us.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest`

Push the image to the the container registry

`docker push us.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest`

Tag the image in order to operate on image streams

`oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest ${PROJECT}/fabric-alpine:latest --reference-policy=local`

## Deployer le template 
### Apply template

`oc apply -f template-init.yaml`

### Process and create template entities

il faut changer les parametres sur le param-init.env en fonction de  l'environement

`oc process  tpl-fabric  --param-file=param-init.env | oc create -f -`

## Génération de la PKI (public key infrastructure) + Generation du genesis block et des transactions d'initialisation du réseau Exchange Network

La génération de la PKI et du Genesis block ainsi que l'initialisation du réseau sont faite automatiquement lors du lancement du POD (config/commands.sh)
  

# Deploy the Orderer

### Apply template

`oc apply -f templateOrderer.yaml`

### Process and create template entities
`oc process  tpl-orderer | oc create -f -`

## Template Orderer

le template contient la configuration de déploiement pour déployer un pod qui contient un conteneur de type Orderer et les variables d'environnement nécessaires au bon fonctionnement, ainsi qu'un service pour y accéder,
une fois le déploiement est fait , le serveur démarre


# Deploy the peer

### Apply template
```sh 
oc apply -f all-peers-onetemplate.yaml
```
### Process and create template entities

```sh
oc process all-peers-onetemplate  --param-file=param-peer.env | oc create -f -
``` 

## Deployer les clibanks

### Apply template
```sh 
oc apply -f template-clibank1.yaml
oc apply -f template-clibank2.yaml
```
### Process and create template entities

```sh
oc process  tpl-clibank1  | oc create -f -
oc process  tpl-clibank2  | oc create -f -

``` 
## install chaincode

Let's start with the installation of the chaincode on peer0-bank1 , in the cliBank1 :

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK1_TLS_CA`
 
* `export CORE_PEER_ADDRESS=$PEER0_BANK1_PRADDR`
 
* `peer lifecycle chaincode install /fabric/cc-pkg-config/bank1/exchange-cc.tgz`
 

Then on peer1-bank1

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_BANK1_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER1_BANK1_PRADDR`
 
* `peer lifecycle chaincode install /fabric/cc-pkg-config/bank1/exchange-cc.tgz`


Now let's install on peer2-bank2 In cliBank2's console :

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_BANK2_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER2_BANK2_PRADDR`

* `peer lifecycle chaincode install /fabric/cc-pkg-config/bank2/exchange-cc.tgz`


Then on peer3-bank2 :

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER3_BANK2_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER3_BANK2_PRADDR`
 
* `peer lifecycle chaincode install /fabric/cc-pkg-config/bank2/exchange-cc.tgz`

Now let's check that the chaincode has been installed:

In peer0-bank1's console:

* `ls /var/hyperledger/production/lifecycle/chaincodes/`

result : exchangecc:1843cb71d30a6e004b7f009297b928aaa668ab2a600981fc5b73f25434dd782b

we can do this same check on the other peers

## launch chaincodes as external services

first, note the package IDs returned by each installation operation on the peers or by the command :

* `ls /var/hyperledger/production/lifecycle/chaincodes/`

then update the the 'template_exchangecc.tpl'  file by modifying the CHAINCODE_ID environment variable of each service with  the values of the corresponding package IDs.

then build the chaincode'image:

`docker build -t exchangecc ./exchangecc/`

Tag the image

* `docker tag exchangecc:latest us.icr.io/bouygues-bloc-1600085663464/exchangecc:latest`

Push the image to the the container registry

* `docker push  us.icr.io/bouygues-bloc-1600085663464/exchangecc:latest`

Tag the image in order to operate on image streams

* `oc tag us.icr.io/bouygues-bloc-1600085663464/exchangecc:latest choroukamahri/exchangecc:latest --reference-policy=local`

the deploy the chaincodes :

* `oc apply -f template-exchangecc.yaml`

* `oc process  tpl-chaincode  --param-file=param-cc.env | oc create -f -`

## Approval et commit

We will now approve the chaincode on each of the organizations.
 
in clibank1 :

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK1_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER0_BANK1_PRADDR`

* `peer lifecycle chaincode queryinstalled >&log.txt`

* export PACKAGE_ID=`sed -n '/Package/{s/^Package ID: //; s/, Label:.*$//; p;}' log.txt`

* `peer lifecycle chaincode approveformyorg --package-id ${PACKAGE_ID} --channelID $CHANNEL_NAME --name excc --version 2.0 --signature-policy "OR('Bank1MSP.member','Bank2MSP.member')" --init-required --sequence 1 --waitForEvent --tls=true --cafile $ORDERER_TLS_CA`

* `peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name excc --version 2.0 --signature-policy "OR('Bank1MSP.member','Bank2MSP.member')" --init-required --sequence 1  --tls true --cafile $ORDERER_TLS_CA --output json`


in clibank2 : 

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_BANK2_TLS_CA`
* `export CORE_PEER_ADDRESS=$PEER2_BANK2_PRADDR`
* `peer lifecycle chaincode queryinstalled >&log.txt`
*  export PACKAGE_ID=`sed -n '/Package/{s/^Package ID: //; s/, Label:.*$//; p;}' log.txt`
* `peer lifecycle chaincode approveformyorg -o orderer:7050 --tls=true --cafile $ORDERER_TLS_CA --channelID $CHANNEL_NAME --package-id ${PACKAGE_ID} --init-required --name excc --version 2.0 --signature-policy "OR('Bank1MSP.member','Bank2MSP.member')" --sequence 1 --waitForEvent`````
* `peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name excc --version 2.0 --signature-policy "OR('Bank1MSP.member','Bank2MSP.member')" --init-required --sequence 1 --tls true --cafile $ORDERER_TLS_CA --output json`

We can now commit the chaincode now that the two organizations have agreed.

* `peer lifecycle chaincode commit --channelID $CHANNEL_NAME --name excc --version 2.0 --signature-policy "OR('Bank1MSP.member','Bank2MSP.member')" --init-required --sequence 1 --waitForEvent --peerAddresses $PEER2_BANK2_PRADDR --tlsRootCertFiles $PEER2_BANK2_TLS_CA --peerAddresses $PEER0_BANK1_PRADDR --tlsRootCertFiles $PEER0_BANK1_TLS_CA --tls=true --cafile $ORDERER_TLS_CA`

We can now initialize the excc v2.0 chaincode by initializing the accounts of companies a to 100 and b to 200.

sur peer2-bank2 : 

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_BANK2_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER2_BANK2_PRADDR`

* `peer chaincode invoke -o orderer:7050 --tls true --cafile $ORDERER_TLS_CA -C $CHANNEL_NAME -n excc --peerAddresses $PEER2_BANK2_PRADDR --tlsRootCertFiles $PEER2_BANK2_TLS_CA --peerAddresses $PEER0_BANK1_PRADDR --tlsRootCertFiles $PEER0_BANK1_TLS_CA --isInit -c '{"Args":["init","a","100","b","200"]}'`

## Invoke et Query sur la chaincode excc

We can now make queries on the excc chaincode. Here is an example on peer0-bank1:

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK1_TLS_CA`

* `export CORE_PEER_ADDRESS=$PEER0_BANK1_PRADDR`

* `peer chaincode query -C $CHANNEL_NAME -n excc -c '{"Args":["query","a"]}'`

**result :** 100

We are now going to execute our first transaction from account a to account b (a will pay 10 to b).
This operation requires an HLF transaction and therefore what we call an invocation operation:

* `peer chaincode invoke -o orderer:7050  --tls true --cafile $ORDERER_TLS_CA  -C $CHANNEL_NAME -n excc -c '{"Args":["invoke","a","b","10"]}'`

Finally, we are going to make one last request to check the status of account a on peer peer3-bank2:

* `export CORE_PEER_TLS_ROOTCERT_FILE=$PEER3_BANK2_TLS_CA`
* `export CORE_PEER_ADDRESS=$PEER3_BANK2_PRADDR`
* `peer chaincode query -C $CHANNEL_NAME -n excc -c '{"Args":["query","a"]}'`

**result :** 90




