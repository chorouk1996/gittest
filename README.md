# **Create images stream in the projects**
## **Prerequisite**

**Access to the branch**

* *`git checkout feature-share-pvc-with nfs`*
  
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
busybox used to deploy in nfs-r and nfs-w projects
* *`docker pull busybox`*

NFS used to deploy the server in the nfs-r project

* *`docker build -t ${registry}/${cluster}/${ns_s}/nfs-server .`*
## **Create images stream in the projects**

**Create images in container registry**
* *`docker tag busybox ${registry}/${cluster}/${ns_r}/nfs-client`*
* *`docker push ${registry}/${cluster}/${ns_r}/nfs-client:latest`*

* *`docker tag busybox ${registry}/${cluster}/${ns_w}/nfs-client`*
* *`docker push ${registry}/${cluster}/${ns_w}/nfs-client:latest`*

**Create images stream in each project**
Images stream created in the nfs-r project
* *`oc tag ${registry}/${cluster}/${ns_r}/nfs-client ${ns_r}/nfs-client:latest --reference-policy=local`*

Images stream created in the nfs-w project
* *`oc tag ${registry}/${cluster}/${ns_w}/nfs-client ${ns_w}/nfs-client:latest --reference-policy=local`*

NFS images stream created in the nfs-r project

* *`oc tag ${registry}/${cluster}/${ns_r}/nfs-server ${ns_r}/nfs-server:latest --reference-policy=local`*

## **Deploy reader and writer clients and the NFS server**

**In the nfs-r project**

* *`oc project ${nfs-r}`*
* *`oc apply -nfs-pv.yaml`*
* *`oc apply -nfs-pvc.yaml`*
* *`oc apply -f nfs-server.yaml`*


**In the nfs-w project**
* *`oc project ${nfs-w}`*
* *`oc apply -f nfs-writer-pvc.yaml`*
