#!/bin/bash

set -e

log() {
  echo
  echo "##### $*"
}

source install_cleanup_vars.sh

log "Installing the apps Helm release: $HELM_APP_RELEASE_NAME"
helm install "$HELM_APP_RELEASE_NAME" helm/bobbycar-core-apps \
--set-string ocpDomain="$APP_DOMAIN" \
--set-string ocpApi="$API_DOMAIN" \
--set-string namespace="$NAMESPACE" \
--set-string dashboard.config.googleApiKey="$GOOGLE_API_KEY"

sleep 30

log "Waiting for Rover pod"
oc wait --for=condition=Available dc/car-simulator --timeout 300s
log "Waiting for Rover Dashboard pod"
oc wait --for=condition=Available dc/dashboard --timeout 300s
log "Waiting for Dashboard Streaming service pod"
oc wait --for=condition=Available deployment/dashboard-streaming --timeout 300s

log "Waiting for Camel-K integrations to complete..."
oc wait --for=condition=Ready integration/cache-service --timeout 1800s
oc wait --for=condition=Ready integration/kafka2datagrid --timeout 1800s
oc wait --for=condition=Ready integration/mqtt2kafka --timeout 1800s

log "Installation completed! Open the Rover dashboard and get started:"
oc get route dashboard -o json | jq -r .spec.host