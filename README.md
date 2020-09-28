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


<!-- ########################## -->
# ACRONYMS / DEFINITIONS : 
<!-- ########################## -->
PVC : Persistent Volume Claims  
CSI : Container Storage Interface

