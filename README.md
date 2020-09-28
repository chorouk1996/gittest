# Template Orderer

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

## Deployer le template 
### Apply template

`oc apply -f template.yaml`

### Process and create template entities
`oc process  tpl-fabric | oc create -f -`

## Template Orderer

le template contient le deployment config pour deployer un pod qui contient un conteneur de type Orderer et les variables d'environement necessaire pour le bon fonctionnement , ainsi qu'un service pour y'acceder ,

une fois déployer le serveur démarre