### Prerequisite

before proceeding to this step, make sure that the PKI ((Public Key Infrastructure) are generated, otherwise start by generating them:
[link to the feature-generationPKI-initNetwork.](./feature-generationPKI-initNetwork/README.md)

### Apply template
```sh 
oc apply -f all-peer-template.yaml
```
### Process and create template entities

```sh
oc process -f all-peer-template | oc create -f -
``` 