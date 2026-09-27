#!/bin/bash
set -euo pipefail

NAMESPACE="${1:-self-service}"

kubectl create namespace "$NAMESPACE" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl apply \
  -f manifests/linux/nginx-deployment.yaml \
  -n "$NAMESPACE"

kubectl rollout status deployment/nginx-demo \
  -n "$NAMESPACE" \
  --timeout=180s

kubectl get pods -n "$NAMESPACE"
