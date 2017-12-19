#!/bin/bash

exec java \
  $JAVA_OPTIONS \
  -Xms$INIT_MEMORY -Xmx$MAX_MEMORY \
  -Djava.net.preferIPv4Stack=true \
  -Dlogback.configurationFile=/iri/conf/logback.xml \
  -jar /opt/iri/iri.jar \
  --config /iri/conf/iri.ini
  "$@"
