FROM alpine:latest
RUN mkdir /sources
COPY ./entrypoint.sh /sources/entrypoint.sh
COPY config /sources/config
COPY base /sources/base
COPY buildpack /sources/buildpack
COPY cc-pkg-config /sources/cc-pkg-config
RUN chmod +x /sources/entrypoint.sh
RUN mkdir -p /fabric
ENTRYPOINT [ "/sources/entrypoint.sh" ]


