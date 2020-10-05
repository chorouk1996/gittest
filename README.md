# bouygues-poc

bouygues poc


<!-- ########################## -->
# I. TASK : 
<!-- ########################## -->
task name : "Extend PVC" 
[lien](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/issues/7 )


<!-- ########################## -->
# PRE-REQUISITES : 
<!-- ########################## -->
Chosen storageClass must have the following characteristics :  
	- "allowVolumeExpansion" present AND set to "true" (which means selecting a "ibmc-block-<XXX>" storageClass)  
	- "type": Endurance (also, best choice would be "silver" in my own point of view)  
	- "reclaimPolicy" set to "Retain"  
Note that "Block" storage is only with AccessMode type "ReadWriteOnce".  


<!-- ########################## -->
# METHOD 1 : GRAPHIQUE : 
<!-- ########################## -->

[See full procedure here](https://access.redhat.com/documentation/en-us/red_hat_openshift_container_storage/4.5/html/managing_openshift_container_storage/managing-persistent-volume-claims_rhocs)  

I. FOR PVC CREATION : 
----------------------
	1) RHOCP > menu "Projects" > select project "adrienmarchal-iscfrance-fr" (= namespace)
	2) RHOCP > menu "Storage" > "Persistent Volume Claims" > clic "Create Persistent Volume Claim" > cf config bellow > "create"
		- "Storage class" field : "default" -> [TODO : investigations to be done...] : cf au niveau Kubernetes
		- "Persistent Volume Claim Name" : "amar-mongodb-pvc" [note : "_" character is forbidden...]
		- "Access Mode" field : [Single User (RWO)] or [Shared Access (RWX)] or  [Read Only (ROX)]
		- "Size" field : "10" Mi
	3) see YAML generated.
		Note : to download the generated YAML file : RHOCP > menu "Storage" > "Persistent Volume Claims" > clic "..." at the end of the line on the PVC to entend > "Edit PVC" > "download" button

II. TO EXPAND A PVC : 
-----------------------
	=> RHOCP > menu "Storage" > "Persistent Volume Claims" > clic "..." at the end of the line on the PVC to entend > "Expand PVC" > select value (max is 20 Gi) > "Expand"

III. EDIT PVC LABELS : 
------------------------
    NOTE : Labels help you organize and select resources. Adding labels below will let you query for objects that have similar, overlapping or dissimilar labels.  
	=> RHOCP > menu "Storage" > "Persistent Volume Claims" > clic "..." at the end of the line on the PVC to entend > "Edit Labels"

IV. EDIT PVC ANNOTATIONS : 
------------------------
    NOTE : this is a key/values list  
	=> RHOCP > menu "Storage" > "Persistent Volume Claims" > clic "..." at the end of the line on the PVC to entend > "Edit Annotations"


<!-- ############################################## -->
# METHOD 2 IN COMMAND LINE (OC COMMANDS for "PVC") : 
<!-- ############################################## -->
For reference, cf basic CLI operation : https://docs.openshift.com/enterprise/3.0/cli_reference/basic_cli_operations.html  

1) connection :  
    a) login : `oc login --token=<token> --server=<serverName>`  
        Note : As reminder, login procedure is explained in the very bottom of [this wiki](https://github.ibm.com/OpenshiftEverywhere-POCs-FR/global-knewledge/wiki/Tools)  
        To sum up : go to RHOCP > open the dropdown menu of our login (top-right corner) > select "Copy Login Command" > "Display Token"  
    b) connect to project : `oc project ${project}`  
    c) specify user-role : `oc policy add-role-to-user system:image-puller system:serviceaccount:${project}:default --namespace=${project}`  

2) CREATE POD WITH MONGODB INSIDE :  
    a) `docker pull registry.access.redhat.com/openshift3/mongodb-24-rhel7`  
    b)  
```sh
oc new-app \
    -e MONGODB_USER=<username> \
    -e MONGODB_PASSWORD=<password> \
    -e MONGODB_DATABASE=<database_name> \
    -e MONGODB_ADMIN_PASSWORD=<admin_password> \
    -e MONGODB_ADMIN_PASSWORD \
    registry.access.redhat.com/rhscl/mongodb-26-rhel7
```  
    c) `oc status` & `oc get pods` & `oc logs <podName>` for health check  

3) ADD DATA INSIDE CONTAINER :  
    a) enter the MongoDB Container : `oc rsh <podName>`  
    b) connect to db : `mongo -u <username> -p <password> --authenticationDatabase <dbname>`  
    c) select db : `use <dbName>`  
    d) get general infos on db content : `show collections`  
    e) create collection : `db.createCollection("<collectionName>")`  
	NOTE : get general infos on collection content :  
		* `db.getCollection("<collectionName>").find()` or `db.<collectionName>.find()`/`db.<collectionName>.find({})` or `db.<collectionName>.find().pretty()`  
		* `db.<collectionName>.count()`  
		* `db.<collectionName>.getIndexes()`  
    f) insert data : `db.<collectionName>.insert({ x : 1 })`  
    g) quit : `exit`  


<!-- ############################################## -->
# METHOD 3 with YAML files : 
<!-- ############################################## -->
1) PVC  
    a) creation : `oc apply -f mongodb-amar-pvc.yaml`  
    b) get creation status : `oc describe pvc <pvcName>`  
2) POD  
    a) creation : `oc apply -f pod-mongodb-26-rhel7-min-1.yaml`  
    b) get creation status : `oc get pods` then `oc describe pod <podName>` then `oc logs <podName>` for health check and other investigations  
3) use of templates :  
```sh  
oc process -f template-mongodb.yaml \  
    -p MONGODB_ADMIN_PASSWORD=<value1> \  
    -p MONGODB_DATABASE=<value2> \  
    -p MONGODB_PASSWORD=<value3> \  
    -p MONGODB_USER=<value4> \  
    -p VOLUME_SIZE=<value5> \  
    -p STORAGE_CLASS=<value6> \  
	| oc create -f -  
```


<!-- ########################## -->
# Encountered problems and Troubleshoots : 
<!-- ########################## -->
a) Following command FAILS! : 
```sh
oc new-app -e \
    MONGODB_USER=<username>,MONGODB_PASSWORD=<password>,MONGODB_DATABASE=<database_name>,MONGODB_ADMIN_PASSWORD=<admin_password>,MONGODB_ADMIN_PASSWORD \
    registry.access.redhat.com/rhscl/mongodb-26-rhel7
```  
Solution : for each parameter, we must add "-e".  

b) in case of "CrashLoopBackOff" : simply deleting the pod (`oc delete pod <podName> -n <projectName> --grace-period=0 --force`) does not work : a new pod is created each time...   
Solution : we have to delete the associated DeploymentConfig! :  
	METHOD 1 : open dropdown next to "Administrator" (top left) > select "Developper" > "topology" > select the targeted pod > open dropdown on "Actions" (top right) > "Delete Deployment Config"  
	METHOD 2 : RHOCP > Workloads > DeploymentConfigs > "..." in front of the one to be deleted > "Delete Deployment Config"  

c) We have the following error message : 
```sh  
ERROR: Couldn't write into /var/lib/mongodb/data  
		  CAUSE: current user doesn't have permissions for writing to /var/lib/mongodb/data directory  
```  
Solution : add to the YAML file in section "spec:" :  
```sh  
securityContext:
    fsGroup: 1001070000  
```  

d) Trying to DECREASE PVC, we got the error `Forbidden: field can not be less than previous value" for field "spec.resources.requests.storage` :  
Solution : None. This is a normal behaviour in order not to accidentally delete some data.  

e) Trying to EXPAND a PVC, we have the error `persistentvolumeclaims "XXX" is forbidden: only dynamically provisioned pvc can be resized and the storageclass that provisions the pvc must support resize`  
Solution : Select an other storageClass where "allowVolumeExpansion" attribute is set AND set to "true".  
    - Note :  
    * if trying to expand a PVC size until PV initial capacity (having its storageClass where "allowVolumeExpansion"="true") : everything works fine  
    * if trying to expand the size of that PVC that exceeds PV capacity : the 2 following comments can be made :  
        => on PVC side, annotation "volume.kubernetes.io/storage-resizer: ibm.io/ibmc-block" is added in YAML due to PV capacity exceeded.  
        => on PV side, "spec.capacity.storage" field is set with the claimed expanded size.  
        (ex : PVC initially claimed at 15Gi, for an initial PV capacity of 20Gi. If PVC is claimed for extention to 25Gi, "spec.capacity.storage" field of the corresponding PV is set to 25Gi.)  


<!-- ########################## -->
# SOURCES : 
<!-- ########################## -->
- MAIN MENU : 
    * https://docs.openshift.com/container-platform/4.5/welcome/index.html > menu "Storage" on left
    * https://access.redhat.com/documentation/en-us/red_hat_openshift_container_storage/4.5/?extIdCarryOver=true&sc_cid=701f2000001OH74AAG

- Red Hat OpenShift Container Storage : 
	* https://docs.openshift.com/container-platform/4.5/storage/persistent_storage/persistent-storage-ocs.html#red-hat-openshift-container-storage
	* https://access.redhat.com/documentation/en-us/red_hat_openshift_container_storage/4.5/html/managing_openshift_container_storage/overview > select "PDF"


- set a PVC : 
    * https://access.redhat.com/documentation/en-us/red_hat_openshift_container_storage/4.5/html/managing_openshift_container_storage/managing-persistent-volume-claims_rhocs

- expand persistent volumes : 
    * https://docs.openshift.com/container-platform/4.5/storage/expanding-persistent-volumes.html#expanding-persistent-volumes
	=> check result : `oc describe pvc <pvc_name>`


- Kubernetes associated documentation : 
	* https://docs.openshift.com/container-platform/4.1/storage/understanding-persistent-storage.html
	* https://kubernetes.io/fr/docs/concepts/storage/persistent-volumes/
	* https://kubernetes.io/blog/2018/07/12/resizing-persistent-volumes-using-kubernetes/

- StorageClass IBM : 
	* https://cloud.ibm.com/docs/containers?topic=containers-kube_concepts
	* https://cloud.ibm.com/docs/containers?topic=containers-block_storage
	* https://cloud.ibm.com/docs/containers?topic=containers-file_storage
	* https://cloud.ibm.com/docs/FileStorage?topic=FileStorage-about#provisioning-with-endurance-tiers
	* https://cloud.ibm.com/docs/containers?topic=containers-file_storage#file_change_storage_configuration
	* https://cloud.ibm.com/docs/containers?topic=containers-storage_planning#choose_storage_solution  
	=> Characteristics :  
		- **[bronze, silver, gold]** : "endurance" storage type ; depends on IOPS needed
		- **[retain, delete]** : for "retain", if a PVC is deleted, the associated PV is not deleted.
		- **[file, block]** : stockage option ; Block storage is with AccessMode type "ReadWriteOnce" ; "bloc" can be resized ; "file" can not be resized
		- **[endurance, performance]** : "performance" is available for "custom" storage (different from bronze, silver or gold).
		- **[ReadWriteMany, ReadOnlyMany, ReadWriteOnce]** : "ReadWriteOnce" for PVC that can be mounted in Read/Write by ONLY ONE POD ; "ReadWriteMany" for PVC that can be mounted in Read/Write by SEVERAL PODS ; "ReadOnlyMany" for PVC that can be mounted in Read Only by SEVERAL PODS

<!-- ########################## -->
# ACRONYMS / DEFINITIONS : 
<!-- ########################## -->
CSI : Container Storage Interface  
IOPS : Input Output per Second  
PV : persistant volume  
PVC : Persistent Volume Claims  

