# Deployer le cliBank

## Prerequisites

you must have run the init Template located in  generating PKI branch (template-init.yaml) before processing . This generate fabric-pvc , the Volume is  needed by this object 


## Deployer le template 
### Apply template
```sh 
oc apply -f template-clibank.yaml
```
### Process and create template entities

```sh
oc process  tpl-clibank   -p NUM=1 | oc create -f -
``` 

OR 

```sh
oc process   tpl-clibank --param-file=param.env | oc create -f -
``` 

 


  

