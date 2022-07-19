#!/bin/bash

set -e

log() {
  echo
  echo "##### $*"
}

source install_cleanup_vars.sh

log "Creating namespace $NAMESPACE for Bobbycar demo"
oc new-project "$NAMESPACE" || true
log "Installing operator group"
sed "s:{{NAMESPACE}}:$NAMESPACE:g" config/operators/operator-group.yaml | oc apply -f -
log "Installing the AMQ Broker operator"
sed "s:{{NAMESPACE}}:$NAMESPACE:g" config/operators/amq-operator-subscription.yaml | oc apply -f -
log "Installing the AMQ Streams operator"
sed "s:{{NAMESPACE}}:$NAMESPACE:g" config/operators/amq-streams-operator-subscription.yaml | oc apply -f -
log "Installing the Datagrid operator"
sed "s:{{NAMESPACE}}:$NAMESPACE:g" config/operators/datagrid-subscription.yaml | oc apply -f -
log "Installing the Camel-K operator"
sed "s:{{NAMESPACE}}:$NAMESPACE:g" config/operators/camel-k-operator-subscription.yaml | oc apply -f -

sleep 30

log "Waiting for AMQ Broker operator"
AMQ_BROKER_POD=$(oc get pod -l name=amq-broker-operator -o jsonpath="{.items[0].metadata.name}")
oc wait --for=condition=Ready pod/"$AMQ_BROKER_POD" --timeout 300s
log "Waiting for AMQ Streams operator"
AMQ_STREAMS_POD=$(oc get pod -l name=amq-streams-cluster-operator -o jsonpath="{.items[0].metadata.name}")
oc wait --for=condition=Ready pod/"$AMQ_STREAMS_POD" --timeout 300s
log "Waiting for Datagrid operator"
DATAGRID_POD=$(oc get pod -l name=infinispan-operator -o jsonpath="{.items[0].metadata.name}")
oc wait --for=condition=Ready pod/"$DATAGRID_POD" --timeout 300s
log "Waiting for Camel-K operator"
CAMEL_K_POD=$(oc get pod -l name=camel-k-operator -o jsonpath="{.items[0].metadata.name}")
oc wait --for=condition=Ready pod/"$CAMEL_K_POD" --timeout 300s