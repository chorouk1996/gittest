FROM alpine:latest

RUN mkdir /sources
COPY ./entrypoint.sh /sources/entrypoint.sh
RUN chmod +x /sources/entrypoint.sh
COPY ./data /sources/data
RUN mkdir -p /pvc/postgres
ENTRYPOINT [ "/sources/entrypoint.sh" ]