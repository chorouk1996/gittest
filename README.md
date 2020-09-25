# Génération de la PKI (public key infrastructure) 

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

#### Create the image locally
Build the image from the Dockerfile

`docker build -t fabric-alpine .`

#### Create the image in the registry 
Tag the image

`docker tag fabric-alpine us.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest`

Push the image to the the container registry

`docker push us.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest`

Tag the image in order to operate on image streams

`oc tagus.icr.io/bouygues-bloc-1600085663464/fabric-alpine:latest ${PROJECT}/fabric-alpine:latest --reference-policy=local`

## Deployer le template 
### Apply template

`oc apply -f template.yaml`

### Process and create template entities
`oc process  tpl-fabric | oc create -f -`

## Génération de la PKI (public key infrastructure)

La génération de la PKI et du Genesis block ainsi que l'initialisation du réseau sont faite automatiquement lors du lancement du POD (config/commands.sh)
  

