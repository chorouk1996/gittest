TEST CASES - READ ME : 

1) input test : create de MongoDB pod without persistent storage & add data in DB
   action : delete the pod and recreate a new pod
   expected : data should not be present anymore
   result : OK

2) input test : create de MongoDB pod with persistent storage (having PVC size < associated PV size) & add data in DB
   action : delete the pod and recreate a new pod with same persistent storage
   expected : data should be kept and associated PV should be the same
   result : OK

3) input test : create de MongoDB pod with persistent storage (having PVC size < associated PV size) & add data in DB
   action : expand PVC having PVC size = associated PV size
   expected : data should be kept and associated PV should be the same
   result : OK

Note if trying to DECREASE SIZE, the following error appears : Error "Forbidden: field can not be less than previous value" for field "spec.resources.requests.storage".

4) input test : create de MongoDB pod with persistent storage (having PVC size = associated PV size) & add data in DB
   action : expand PVC having PVC size > associated PV size
   expected : to be analyzed
   result : OK ("volume.kubernetes.io/storage-resizer: ibm.io/ibmc-block" annotation line is added in the yaml file, because PV capacity exceeded)

