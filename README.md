

Tag the image in order to operate on image streams

```sh
oc tag us.icr.io/bouygues-bloc-1600085663464/fabric-peer:latest brahimchihaoui/fabric-peer:latest --reference-policy=local
```

## Deployer le template 
### Apply template
```sh 
oc
```
### Process and create template entities

```sh
oc process -f peer-template.yaml -p PROJECT=brahimchihaoui -p PEER_BANKSCO_COM=peer0.bank1.banksco.com | oc create -f -
``` 

## Test lors de la creation DC 


  

