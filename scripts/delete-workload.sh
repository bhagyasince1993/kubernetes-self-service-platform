#!/bin/bash
set -euo pipefail

NAMESPACE="${1:-self-service}"
DEPLOYMENT="${2:-nginx-demo}"

echo "Deleting deployment: $DEPLOYMENT"
echo "Namespace: $NAMESPACE"

kubectl delete deployment "$DEPLOYMENT" \
  --namespace="$NAMESPACE" \
  --ignore-not-found=true \
  --wait=true

echo "Workload cleanup completed."
kubectl get pods --namespace="$NAMESPACE"
