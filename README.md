# Log in

## IBM Cloud login
Log in to the Cloud IBM account 
*  *ibmcloud login --sso*

## IBM Cloud Cluster registry connection
Log in to the IBM Cloud Container Registry
* *ibmcloud cr login*

## Log in to the Openshift Container Platform
Use the command line provided by your cluster. The command line containing key token is available in the Openshift console.
*  *oc login --token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --server=https://c103-e.us-south.containers.cloud.ibm.com:31319*

# Use PVC to shqre files over an init container
## Create the alpine image in the container registry  

### Declaring variables : 
 * CLUSTER_NAME=bouygues-bloc-1600085663464 (the command line to get the cluster name is: * ibmcloud cr namespace-list *)
 * REGISTRY=us.icr.io
 * PROJECT=myproject

### Activate the project
Create the project if needed
 *oc new-project ${PROJECT}*

or activate the project
*  *oc project ${PROJECT}*

to check the active project run the command line: *oc status*

Add a role to pull image in the project
*  *oc policy add-role-to-user system:image-puller system:serviceaccount:${PROJECT}:default  --namespace=${PROJECT}*

### Create the image locally
Build the image from the Dockerfile
* *docker build -t local/alpine-postgresql .*

### Create the image in the registry 
Tag the image
* *docker tag local/alpine-postgresql ${REGISTRY}/${CLUSTER_NAME}/alpine-postgresql:latest*

Push the image to the the container registry
* *docker push ${REGISTRY}/${CLUSTER_NAME}/alpine-postgresql:latest*

Tag the image in order to operate on image streams
* *oc tag ${REGISTRY}/${CLUSTER_NAME}/alpine-postgresql:latest ${PROJECT}/alpine-postgresql:latest --reference-policy=local*

# Deployment of postgresql database using the Template 
Run the comment to deploy the Postgresql database
* *oc process -f template_deployment_postgresql --param-file parameters.env | oc create -f -*

# Loading data in Postgresql database without init container
Get the podgresql pod ID
* *oc get pods*  ->for example: postgresql-1-hfndo

Example : copy a weather.sql schema in the pod 

copy the sql files the Postgresql pod
* *oc cp weather.sql postgresql-1-hfndo:/tmp/weather.sql*
start a shell session in the Postgresql pod
* *oc rsh postgresql-1-hfndo*

Go the / tmp folder to access the sql files
* *cd /tmp*

Import data by runing sql commands
* *psql < weather.sql*

NB:  the script weather.sql is juste for test . Change it  with your custom script and make your database ready . 




