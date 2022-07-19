#!/bin/bash

set -e

log() {
  echo
  echo "##### $*"
}

source install_cleanup_vars.sh

log "Installing the infra Helm release: $HELM_INFRA_RELEASE_NAME"
helm install "$HELM_INFRA_RELEASE_NAME" --set-string namespace="$NAMESPACE" --set-string ocpDomain="$APP_DOMAIN" helm/bobbycar-core-infra/

sleep 30

log "Waiting for AMQ Broker pod"
oc wait --for=condition=Ready pod/rover-amq-mqtt-ss-0 --timeout 300s
log "Waiting for Kafka Broker pod"
oc wait --for=condition=Ready pod/rover-cluster-kafka-0 --timeout 300s
log "Waiting for Datagrid pod"
oc wait --for=condition=Ready pod/rover-dg-0 --timeout 300s
log "Waiting for Kafka Bridge pod"
oc wait --for=condition=Available deployment/rover-bridge --timeout 300s