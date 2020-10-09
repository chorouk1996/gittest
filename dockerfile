FROM alpine:latest
RUN mkdir /sources
COPY ./entrypoint.sh /sources/entrypoint.sh
COPY ./config /sources/config
COPY base /sources/base
RUN chmod +x /sources/entrypoint.sh
RUN mkdir -p /fabric-secret
COPY ./base /fabric-secret/base
COPY ./config/commands.sh /fabric-secret/commands.sh
COPY ./config/configtx.yaml /fabric-secret/configtx.yaml
COPY ./config/crypto-config.yaml /fabric-secret/crypto-config.yaml
#RUN ls -lha /fabric-secret #FOR DEBUGGING PURPOSES ONLY...
RUN chmod +x /fabric-secret/commands.sh
RUN tar xvf /sources/config/oc.tar
RUN mv oc /usr/local/bin
