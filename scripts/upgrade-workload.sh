#!/bin/bash
set -euo pipefail

NAMESPACE="${1:-self-service}"
DEPLOYMENT="${2:-nginx-demo}"
IMAGE="${3:-nginx:1.28}"

echo "Upgrading $DEPLOYMENT to $IMAGE..."

kubectl set image \
  deployment/"$DEPLOYMENT" \
  nginx="$IMAGE" \
  -n "$NAMESPACE"

if kubectl rollout status \
  deployment/"$DEPLOYMENT" \
  -n "$NAMESPACE" \
  --timeout=180s; then
  echo "Upgrade successful."
else
  echo "Upgrade failed. Rolling back..."
  kubectl rollout undo deployment/"$DEPLOYMENT" \
    -n "$NAMESPACE"
  kubectl rollout status deployment/"$DEPLOYMENT" \
    -n "$NAMESPACE" \
    --timeout=180s
  exit 1
fi
