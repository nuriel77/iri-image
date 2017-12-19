FROM iotaledger/iri:v1.4.1.4 as base

FROM openjdk:8-jre-slim


ARG TINI_VERSION=v0.16.1

ENV REMOTE_API_LIMIT="attachToTangle, addNeighbors, removeNeighbors" \
    API_PORT=14265 \
    UDP_PORT=14600 \
    TCP_PORT=15600 \
    INIT_MEMORY=2G \
    MAX_MEMORY=4G \
    IRI_CONFIG=/iri/iri.ini \
    JAVA_OPTIONS="-XX:+DisableAttachMechanism -XX:+HeapDumpOnOutOfMemoryError -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"


ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini

COPY docker-entrypoint.sh /
RUN chmod +x /usr/bin/tini

COPY --from=base /iri/iri.jar /iri/target/iri.jar

EXPOSE ${API_PORT}
EXPOSE ${UDP_PORT}/UDP
EXPOSE ${TCP_PORT}

VOLUME /iri/target
VOLUME /iri/conf

ENTRYPOINT ["/usr/bin/tini", "/docker-entrypoint.sh"]
