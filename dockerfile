FROM alpine:latest
RUN mkdir /sources
COPY ./entrypoint.sh /sources/entrypoint.sh
COPY config /sources/config
COPY base /sources/base
COPY buildpack /sources/buildpack
RUN chmod +x /sources/entrypoint.sh
RUN mkdir -p /fabric
ENTRYPOINT [ "/sources/entrypoint.sh" ]


