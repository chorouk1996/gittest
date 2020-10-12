FROM ubuntu:latest
RUN mkdir /sources
COPY ./create_secrets.sh /sources/create_secrets.sh
RUN chmod +x /sources/create_secrets.sh
COPY ./create_secrets_full.sh /sources/create_secrets_full.sh
RUN chmod +x /sources/create_secrets_full.sh
COPY ./oc /usr/local/bin
RUN mkdir -p /fabric
