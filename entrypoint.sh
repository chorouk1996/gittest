#!/bin/sh
cp -R /sources/config/* /fabric-secret/
cp -R /sources/base /fabric-secret/base
#exit 0 #to be decommented in final version

#Note : needed instruction for test! otherwise the pod immediately goes in "Completed" status.
#		If the Pod is completed, there's nothing running you can exec into.
sleep 24h #instruction for test purpose