#!/bin/bash
set -euo pipefail

NAMESPACE="${1:-self-service}"
DEPLOYMENT="${2:-nginx-demo}"
REPLICAS="${3:-3}"

if ! [[ "$REPLICAS" =~ ^[0-9]+$ ]]; then
  echo "Error: Replicas must be a non-negative integer."
  exit 1
fi

echo "Scaling $DEPLOYMENT to $REPLICAS replicas..."

kubectl scale deployment "$DEPLOYMENT" \
  --replicas="$REPLICAS" \
  --namespace="$NAMESPACE"

kubectl rollout status deployment/"$DEPLOYMENT" \
  --namespace="$NAMESPACE" \
  --timeout=180s

kubectl get pods --namespace="$NAMESPACE"
