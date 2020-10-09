### bouygues-poc

bouygues poc



# TASK :  

task name : "Mettre les PKI en Secret dans openshift" 
[lien](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/issues/16)



# I. Base Image Management

Note : The base image is built on "alpine" OS and contains :  

+ all YAML configuration files needed to generate the PKIs  
+ The "oc" (openshift client) needed to generate secrets from generated PKIs  


1) Build the image from the Dockerfile : `docker build -t fabric-secret-alpine .`

2) Tag the image : `docker tag fabric-secret-alpine us.icr.io/bouygues-bloc-1600085663464/fabric-secret-alpine:latest`

3) Push the image to the the container registry : `docker push us.icr.io/bouygues-bloc-1600085663464/fabric-secret-alpine:latest`



# II. Make the image available in Openshift

1) login in openshift : `oc login --token=<generatedToken> --server=https://c103-e.us-south.containers.cloud.ibm.com:31319`

Note : As reminder, login procedure is explained in the very bottom of this wiki (https://github.ibm.com/OpenshiftEverywhere-POCs-FR/global-knewledge/wiki/Tools)  
To sum up : go to RHOCP > open the dropdown menu of our login (top-right corner) > select "Copy Login Command" > "Display Token"  

2) Tag the image in order to operate on image streams : `oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-secret-alpine:latest ${PROJECT}/fabric-secret-alpine:latest --reference-policy=local`



# III. Template Management

1) Apply template : `oc apply -f fabric-secret-template.yaml`

2) Instanciate template : `oc process  tpl-fabric-secret  --param-file=param.env | oc create -f -`

NOTE : Change parameters if needed in the `param.env` file.



