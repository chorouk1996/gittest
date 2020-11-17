FROM alpine:latest
COPY fstab /etc
COPY nfsd.sh /usr/bin/nfsd.sh
RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 && mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && chmod +x /usr/bin/nfsd.sh
ENTRYPOINT ["/usr/bin/nfsd.sh"]