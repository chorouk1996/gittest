# Création des images stream dans le project

## Declaring variables
```sh
cluster=bouygues-bloc-1600085663464
registry=us.icr.io
project_fr=nguyenalain-fr
project_us=nguyenalain-us
```


## **Getting busybox image in local**
* *`docker pull busybox`*

## **Create images stream in the projects**

**Create images in container registry**
* *`docker tag busybox ${registry}/${cluster}/${project_fr}/nfs-client`*
* *`docker push ${registry}/${cluster}/${project_fr}/nfs-client:latest`*

* *`docker tag busybox ${registry}/${cluster}/${project_us}/nfs-client`*
* *`docker push ${registry}/${cluster}/${project_us}/nfs-client:latest`*

**Create images stream in each project**
* *`oc tag ${registry}/${cluster}/${project_fr}/nfs-client ${project_fr}/nfs-client:latest --reference-policy=local`*

* *`oc tag ${registry}/${cluster}/${project_us}/nfs-client ${project_us}/nfs-client:latest --reference-policy=local`*
* *``*
# Create a Alpine server