
## Prerequisites

you must have run the init Template located in  generating PKI branch (template-init.yaml) before processing . This generate fabric-pvc , the Volume is  needed by others objects 

Tag the image in order to operate on image streams

```sh
oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-peer:latest brahimchihaoui/fabric-peer:latest --reference-policy=local
```

## Deployer le template 
### Apply template
```sh 
oc apply -f peer-template.yaml
```
### Process and create template entities

```sh
oc process -f peer-template.yaml -p PROJECT=brahimchihaoui -p PEER_BANKSCO_COM=peer0.bank1.banksco.com | oc create -f -
``` 
 


  

