### Problématique

L'equipe IBM  Blockchain voudrait partager un volume de données (des clés, et des configurations) entre 2 namespaces.
![problématique](./img/challeng.gif) 

### Solution I

Partager un volume via un serveur http (enginx).
Le volume sera accessible via une route depuis tous les namespaces
### Deployment : Namespace B

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
https://task-pv-pod-route-mbarekrayad-ma.bouygues-bloc-160008566-f72ef11f3ab089a8c677044eb28292cd-0000.sjc03.containers.appdomain.cloud/crypto-config/ordererOrganizations/banksco.com/orderers/orderer.banksco.com/tls/ca.crt
![result](./img/result.png)


### USECASE => Déployement d'un ordrer : Namespace B

### Copier les fichiers à partir du serveur enginx vers un nouveau pvc local

Il faut d'abord s'assurer que le serveur enginx est bien démarré et les fichiers de pvc d'origine sont bien accessibles via la route openshift.
Pour copier ces fichiers il suffit de déployer ce template en passant les curls des fichiers en param.env
PS1: vous pouvez modifier le template et utiliser un fichier command.sh 
PS2: j'ai essayé de copier tout un répértoire en utilisant wget mais ça n'a pas marché, du coup j'ai opté pour cette solution basée sur curl.

```sh 
oc apply -f copy-pvc-from-http-template.yaml
```
#### Process and create template entities

```sh
oc process  copy-pvc-template  --param-file=param.env | oc create -f -
```
### Génerer un ordrer en se basant sur le nouveau pvc
### Apply template
```sh 
oc apply -f ordrer-pvc-template.yaml
```
#### Process and create template entities

```sh
oc process  ordrer-pvc-template | oc create -f -

