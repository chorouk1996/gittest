FROM alpine:latest
RUN mkdir /sources
COPY ./entrypoint.sh /sources/entrypoint.sh
COPY config /sources/config
COPY base /sources/base
RUN chmod +x /sources/entrypoint.sh
RUN mkdir -p /fabric-secret
RUN tar xvf /sources/config/oc.tar
RUN export PATH=$PATH:/sources/config/oc
ENTRYPOINT [ "/sources/entrypoint.sh" ]


