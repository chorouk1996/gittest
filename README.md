### Problématique

L'equipe IBM  Blockchain voudrait partager un volume de données (des clés, et des configurations) entre 2 namespaces.
![problématique](./img/challeng.gif) 

### Solution I

Partager un volume via un serveur http (enginx).
Le volume sera accessible via une route depuis tous les namespaces
### Deployment

Pour déployer cette solution, il suffit de vous rendre sur votre cluster openshift, vous vous connectez puis charger et executer le template ci-joint (share-pvc-template.yaml).

Le template nécessite un param "PVCNAME" pour ddéfinir le nom de volume claim à monter et partager.

Si vous n'avez pas de nom de volume vous pouvez utiliser fabric_pvc celui crée dans le poc suivant :

[./feature-generationPKI-initNetwork/README.md](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/blob/feature-generationPKI-initNetwork/README.md)

### Apply template
```sh 
oc apply -f share-pvc-template.yaml
```
### Process and create template entities

```sh
 oc process  share-pvc-template -p PVCNAME=fabric-pvc | oc create -f -
``` 
### RESULT
https://task-pv-pod-route-mbarekrayad-ma.bouygues-bloc-160008566-f72ef11f3ab089a8c677044eb28292cd-0000.sjc03.containers.appdomain.cloud/crypto-config/peerOrganizations/bank1.banksco.com/peers/peer0.bank1.banksco.com/tls/server.crt
![result](./img/result.png)
