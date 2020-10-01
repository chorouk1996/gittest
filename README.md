# bouygues-poc

bouygues poc

<!-- ########################## -->
# I. TASK : 
<!-- ########################## -->
task name : "Extend PVC" 
[lien](https://eu-de.git.cloud.ibm.com/gbs-rh/devops/refimps/g4sam1/bouygues-bloc/bouygues-blockchain/bouygues-poc/-/issues/7 )



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
[28/09/2020 : work in progress]




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

