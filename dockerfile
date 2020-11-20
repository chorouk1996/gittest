FROM alpine:latest
RUN mkdir /sources
COPY ./entrypoint_newNet.sh /sources/entrypoint_newNet.sh
RUN chmod +x /sources/entrypoint_newNet.sh
COPY base /sources/base
#COPY config /sources/config
COPY crypto-config.yaml /sources/crypto-config.yaml
COPY configtx.yaml /sources/configtx.yaml
COPY channelOrg1_newNet.sh /sources/channelOrg1_newNet.sh
COPY channelOrg2_newNet.sh /sources/channelOrg2_newNet.sh
COPY channelOrg3_newNet.sh /sources/channelOrg3_newNet.sh
COPY commands_newNet.sh /sources/commands_newNet.sh
COPY core.yaml /sources/core.yaml
RUN mkdir -p /fabric
ENTRYPOINT [ "/sources/entrypoint_newNet.sh" ]
