
## **Prerequisite**

**Access to the branch**

* *`git checkout feature-share-pvc-with-nfs`*
  
**Create new projects**
* *`oc new-project nfs-reader`*

* *`oc new-project nfs-writer`*
 
**Declare variable**
```sh
cluster=bouygues-bloc-1600085663464
registry=us.icr.io
ns_r=nfs-reader
ns_w=nfs-writer
```
## **Create images in local**
busybox image used to deploy in nfs-reader and nfs-writer projects
* *`docker pull busybox`*

NFS image used to deploy the server in the nfs-reader project
* *`docker build -t ${registry}/${cluster}/${ns_r}/nfs-server .`*

## **Create images stream in the projects**

**Push the local images to the container registry**
* *`docker tag busybox ${registry}/${cluster}/${ns_r}/nfs-client`*

* *`docker push ${registry}/${cluster}/${ns_r}/nfs-client:latest`*

* *`docker tag busybox ${registry}/${cluster}/${ns_w}/nfs-client`*

* *`docker push ${registry}/${cluster}/${ns_w}/nfs-client:latest`*

**Create images stream in the projects**

Image stream is created in the nfs-reader project for reader client 
* *`oc tag ${registry}/${cluster}/${ns_r}/nfs-client ${ns_r}/nfs-client:latest --reference-policy=local`*

Image stream created in the nfs-writer project for writer client 
* *`oc tag ${registry}/${cluster}/${ns_w}/nfs-client ${ns_w}/nfs-client:latest --reference-policy=local`*

NFS image stream created in the nfs-reader project
* *`oc tag ${registry}/${cluster}/${ns_r}/nfs-server ${ns_r}/nfs-server:latest --reference-policy=local`*

## **Deploy reader and writer clients and the NFS server**

**In the nfs-reader project**
* *`oc project nfs-reader`*

* *`oc apply -nfs-pv.yaml`*

* *`oc apply -nfs-pvc.yaml`*

* *`oc apply -f nfs-server.yaml`*

* *`oc apply -f nfs-reader.yaml`*

**In the nfs-writer project**
* *`oc project nfs-writer`*

* *`oc apply -f nfs-writer-pvc.yaml`*
