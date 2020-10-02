# Deployer le cliBank

## Prerequisites

you must have run the init Template located in  generating PKI branch (template-init.yaml) before processing . This generate fabric-pvc , the Volume is  needed by this object 


## Deployer le template 
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

 


  

