FROM ubuntu:latest
RUN mkdir /sources
COPY ./create_secrets.sh /sources/create_secrets.sh
RUN chmod +x /sources/create_secrets.sh
COPY ./oc /usr/local/bin
RUN mkdir -p /fabric