# Création des images stream dans le project

## Declaring variables
```sh
cluster=bouygues-bloc-1600085663464
registry=us.icr.io
```


## **Getting busybox image in local**
* *`docker pull busybox`*

## **Create images stream in the projects**

**Create images in container registry**
* *`docker tag busybox ${registry}/${cluster}/namespace_A/nfs-client`*
* *`docker push ${registry}/${cluster}/namespace_A/nfs-client:latest`*

* *`docker tag busybox ${registry}/${cluster}/namespace_B/nfs-client`*
* *`docker push ${registry}/${cluster}/namespace_B/nfs-client:latest`*

**Create images stream in each project**
* *`oc tag ${registry}/${cluster}/namespace_A/nfs-client namespace_A/nfs-client:latest --reference-policy=local`*

* *`oc tag ${registry}/${cluster}/namespace_B/nfs-client namespace_B/nfs-client:latest --reference-policy=local`*
* *``*
# Create a Alpine server