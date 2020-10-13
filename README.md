### bouygues-poc

bouygues poc



# TASK :  

task name : "Mettre les PKI en Secret dans openshift" 
[lien](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/issues/16)



# I. Instanciate Image that generates PKIs

Note : This step aims at doing some steps of the [feature-generationPKI-initNetwork](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/tree/feature-generationPKI-initNetwork) branch.

1) login in openshift : `oc login --token=<generatedToken> --server=https://c103-e.us-south.containers.cloud.ibm.com:31319`

Note : As reminder, login procedure is explained in the very bottom of [this wiki](https://github.ibm.com/OpenshiftEverywhere-POCs-FR/global-knewledge/wiki/Tools)
To sum up : go to RHOCP > open the dropdown menu of our login (top-right corner) > select "Copy Login Command" > "Display Token"

2) Check that the current active project is the right one, via the command line: `oc status`

(if the project is not the right one, activate the project `oc project ${PROJECT}`, or Create the project if needed  `oc new-project ${PROJECT}`)

3) ***!!!WARNING!!! (VERY IMPORTANT STEP)*** allow to write in the PVC to be created : 

a. Add a role to pull image in the project

```
oc policy add-role-to-user system:image-puller system:serviceaccount:${PROJECT}:default  --namespace=${PROJECT}
```

b. Add a rule to write in the volume

```
oc adm policy add-scc-to-user anyuid -z default
```

4) Deploy template : `oc apply -f template-init.yaml`

5) Instanciate template : `oc process  tpl-fabric  --param-file=param-template-init.env | oc create -f -`

(this will create the PVC, the DeploymentConfig and the ImageStream)

NOTES : 

+ Change parameters if needed in the `param-template-init.env` file.

+ generatation of PKI and Genesis block, and network initialisation are automatically done when the POD is stared (config/commands.sh)



# II. Instanciate Image that reads PKIs and generates secrets

The base image is built on "ubuntu" OS and contains : 

+ The "oc" (openshift client) needed to generate secrets from generated PKIs
+ A shell script used to generate the secrets



1) Build the image from the Dockerfile (Create the image locally) : `docker build -t fabric-get-secret-ubuntu .`

(use `--no-cache` option if needed and `RUN ls` for debugging)

2) Tag the image (Create the image in the registry) : `docker tag fabric-get-secret-ubuntu us.icr.io/bouygues-bloc-1600085663464/fabric-get-secret-ubuntu:latest`

3) Push the image to the the container registry : `docker push us.icr.io/bouygues-bloc-1600085663464/fabric-get-secret-ubuntu:latest`
4) Tag the image in order to operate on image streams : `oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-get-secret-ubuntu:latest ${PROJECT}/fabric-get-secret-ubuntu:latest --reference-policy=local`

(in my case `${project}` = `adrienmarchal-iscfrance-fr`)

NOTE : For intermediate tests purpose only (to check the files structues, etc...) :   

​    a. create a pod : `oc apply -f pod-fabric-get-secret-test-1.yaml`

​    b. enter the creaded pod and make the checks  : `oc rsh <podName>`

5) Apply template (Deployer le template) : `oc apply -f fabric-get-secret-template.yaml`

6) Instanciate template : `oc process tpl-fabric-get-secret --param-file=param.env | oc create -f -`

NOTE : Change parameters if needed in the `param.env` file.



# III. Generate secrets

1) connect on the pod that was generated : `oc rsh <podName>`

2) login in openshift <i>inside the container</i> : `oc login --token=<generatedToken> --server=https://c103-e.us-south.containers.cloud.ibm.com:31319 --insecure-skip-tls-verify`

Note : As reminder, login procedure is explained in the very bottom of [this wiki](https://github.ibm.com/OpenshiftEverywhere-POCs-FR/global-knewledge/wiki/Tools)
To sum up : go to RHOCP > open the dropdown menu of our login (top-right corner) > select "Copy Login Command" > "Display Token"

3) execute script :`cd /sources`, then `./create_secrets.sh`

Note : the script generates the secrets in Openshift platform.


