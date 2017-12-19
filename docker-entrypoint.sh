#!/bin/bash

exec java \
  $JAVA_OPTIONS \
  -Xms$INIT_MEMORY -Xmx$MAX_MEMORY \
  -Djava.net.preferIPv4Stack=true \
  -Dlogback.configurationFile=/iri/conf/logback.xml \
  -jar /iri/target/iri.jar \
  --config /iri/conf/iri.ini
  "$@"
