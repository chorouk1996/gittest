#!/bin/bash
echo "Starting rpcbind..."
/sbin/rpcbind -w
echo "Starting NFS in the background..."
/usr/sbin/rpc.nfsd --debug 8 --no-udp --no-nfs-version 2 --no-nfs-version 3
/usr/sbin/exportfs -ivo rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash *:/data
echo "Starting Mountd in the background..."These
/usr/sbin/rpc.mountd --debug all --no-udp --no-nfs-version 2 --no-nfs-version 3
/bin/ps -ef
ip -4 a show eth0

while true; do
  sleep 3600
done