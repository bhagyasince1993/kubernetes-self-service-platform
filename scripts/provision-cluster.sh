#!/bin/bash
set -euo pipefail

CLUSTER="${1:-vmware-lab}"

if ! command -v kind >/dev/null 2>&1; then
  echo "Error: kind is not installed."
  exit 1
fi

if ! command -v kubectl >/dev/null 2>&1; then
  echo "Error: kubectl is not installed."
  exit 1
fi

if kind get clusters | grep -Fxq "$CLUSTER"; then
  echo "Cluster $CLUSTER already exists."
else
  echo "Creating cluster $CLUSTER..."
  kind create cluster --name "$CLUSTER" --wait 5m
fi

kubectl config use-context "kind-$CLUSTER"
kubectl wait --for=condition=Ready nodes --all --timeout=180s

echo "Cluster is ready."
kubectl get nodes
